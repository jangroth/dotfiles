.PHONY: help lint docker-build docker-run

help:
	@echo "lint          check syntax of all config and shell files"
	@echo "docker-build  build the dotfiles Docker image"
	@echo "docker-run    build image and launch interactive container"

lint:
	./tests/lint.sh

docker-build:
	./build-container.sh

docker-run: docker-build
	./run-container.sh
