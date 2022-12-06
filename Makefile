REGISTRY := ic-registry.epfl.ch
NAME   := whisper
TAG    := $$(git log -1 --pretty=%h)
IMG    := ${NAME}:${TAG}
LATEST := ${NAME}:latest

build:
	docker build . -t ${IMG} 
	docker tag ${IMG} ${LATEST}
	docker tag ${IMG} ${REGISTRY}/${IMG}
	docker tag ${LATEST} ${REGISTRY}/${LATEST}

push:
	docker push ${REGISTRY}/${NAME}
	docker push ${REGISTRY}/${IMG}
