#!/usr/bin/env make

.DEFAULT_GOAL := help

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RED    := $(shell tput -Txterm setaf 1)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

TARGET_MAX_CHAR_NUM := 20

###Help
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/(^[a-zA-Z\-\.\_0-9]+:)|(^###[a-zA-Z]+)/ { \
		header = match($$1, /^###(.*)/); \
		if (header) { \
			title = substr($$1, 4, length($$1)); \
			printf "${CYAN}%s${RESET}\n", title; \
		} \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

###Setup
## Pull latest from GitHub and run setup
update:
	@git diff --quiet && git diff --cached --quiet || (echo "Error: uncommitted changes, please commit or stash first"; exit 1)
	git pull
	$(MAKE) install

## Run all setup scripts
install:
	./scripts/run_all.sh

## Force re-fetch all remote dependencies and run setup
reinstall:
	DOT_FORCE=true ./scripts/run_all.sh

###Test
## Check syntax of all config and shell files
lint:
	./tests/lint.sh

###Docker
## Build the dotfiles Docker image
docker-build:
	./docker/build.sh

## Build image and launch interactive container
docker-run: docker-build
	./docker/run.sh

.PHONY: help update install reinstall lint docker-build docker-run
