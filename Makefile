MAKEFLAGS := --no-print-directory --silent

default: help

ARCH := $(shell arch=$$(uname -m); if [ "$${arch}" = "x86_64" ]; then echo "amd64"; else echo "$${arch}"; fi)
IMAGE := $(shell jq ".build_from.$(ARCH)" build.json)

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z\._-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
.PHONY: help

build: ### build the docker image locally
	docker build -t proxmox-qdevice-homeassistant-addon --build-arg BUILD_FROM=$(IMAGE) .

run.interactive: build
	docker run -it proxmox-qdevice-homeassistant-addon bash

run: build
	docker run -it proxmox-qdevice-homeassistant-addon

make tools: ### Install dependencies used
	brew install jq