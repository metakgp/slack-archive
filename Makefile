MAKEQ := $(MAKE) --no-print-directory

ifeq (, $(shell which docker-compose))
    DOCKER_COMPOSE=docker compose
else
    DOCKER_COMPOSE=docker-compose
endif

CURRENT_MAKEFILE := $(lastword $(MAKEFILE_LIST))
PROJECT_DIR := $(shell dirname $(realpath $(CURRENT_MAKEFILE)))

ENVS := $(shell grep -v '^#' .env)
EXCRETOR_DEV_ENVS := $(ENVS) RUST_BACKTRACE=1

DATABASE_VOLUME := food

default: build run

.PHONY: help dev dev-stop build run stop digest run-digester check_clean clean

## help: Show this help message
help:
	@echo "Usage: make [target]"
	@sed -n 's/^##//p' $(CURRENT_MAKEFILE) | column -t -s ':' |  sed -e 's/^/ /'
	@echo ""
	@echo "Running 'make' without a target is equivalent to running 'make build run'."

## build: Build the excretor docker image
build:
	@echo "Building excretor docker image..."
	@$(DOCKER_COMPOSE) build excretor

## run: Run the excretor docker container
run:
	@echo "Running excretor docker container..."
	@$(DOCKER_COMPOSE) up excretor -d

## stop: Stop the excretor docker container
stop:
	@echo "Stopping excretor docker container..."
	@$(DOCKER_COMPOSE) stop excretor
	@$(DOCKER_COMPOSE) down excretor

## digest: Run the digester container
digest:
ifeq (, $(FILE))
	@echo "ERROR: No file path provided. Please specify the file path using 'make digest FILE=/path-to-file'"
	@exit 1;
endif
	@echo "Starting digester..."
	@bash -c "trap 'echo ""; $(DOCKER_COMPOSE) down digester; exit 0' SIGINT SIGTERM ERR; ZIPFILE_PATH='$(FILE)' $(DOCKER_COMPOSE) up digester --build --abort-on-container-exit;"
# In case the digester gracefully shuts down
	@$(DOCKER_COMPOSE) down digester

%:
ifneq (, $(MAKECMDGOALS))
	@echo "Target '$(MAKECMDGOALS)' not found."
	@echo ""
	@$(MAKEQ) --no-print-directory help
endif
