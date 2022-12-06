FROM nvcr.io/nvidia/pytorch:22.11-py3

CMD pip install git+https://github.com/openai/whisper.git 
CMD apt update && apt install ffmpeg && Lrm -rf /var/lib/apt/lists/*

# Download the large model
CMD touch empty && whisper empty --model large; exit 0
