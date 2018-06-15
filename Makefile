
TAG=amarburg/dat-server:latest


build:
	docker build -t ${TAG} .

push:
	docker push ${TAG}

.PHONY: build push
