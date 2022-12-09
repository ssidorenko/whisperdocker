# Automated transcription using Whisper on the EPFL IC Cluster

This is a short guide on using the deep learning model Whisper for transcribing audio on the EPFL IC Cluster. The model can run on a computer as well, but is much slower, so using the cluster's GPU is advised.

### Step 0. install kubectl and runai CLI

Follow instructions here: https://docs.run.ai/admin/runai-setup/config/cli-admin-install/ 

And here: https://kubernetes.io/docs/tasks/tools/install-kubectl/

### Step 1. create a RunAI account

Follow the docs here: https://icitdocs.epfl.ch/display/clusterdocs/Getting+Started+with+RunAI+SAML (only accessible from EPFL network or VPN).

### Step 2. create an interactive workload


You can use any name you want instead of transcription1, but be consistent and use the same name for subsequent commands.

```
runai config project lhst-yourgasparhandle
runai submit transcription1 -i ic-registry.epfl.ch/lhst/whisper -g 1 --interactive -- sleep infinity
```

(For more info on creating workloads: https://docs.run.ai/Researcher/Walkthroughs/walkthrough-build/)

### Step 3. Check that the container is running and get the name of the pod.

This can take a while before the container is provisioned. You can check its status using 

```
runai describe job transcription1 -p lhst-yourgasparhandle
```

Wait for STATUS to go from PENDING to RUNNING.

Note down the full name of the pod which should be something like "transcription-1-0-0"

### Step 4. Copy files to the pod

Copy a file from your desktop to the pod's workspace:

```
kubectl cp ~/Desktop/Someaudio.mp3 transcription-1-0-0:/workspace/
```

### Step 5. get a shell to your container

When the job is running, you can get a shell to the container using

```
runai bash build1
```

### Step 6. run the transcription 

Inside the container shell, run

```
whisper Someaudio.mp3 --model large --language French
```

You will see results of the transcription appearing live in your terminal. 

### Step 7. Retrieve the transcription

```
kubectl cp transcription-1-0-0:/workspace/Someaudio.mp3.txt ./
kubectl cp transcription-1-0-0:/workspace/Someaudio.mp3.srt ./
```

