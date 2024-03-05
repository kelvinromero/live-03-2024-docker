target := app-production
dc := docker compose

.PHONY: help
help:
	@echo "up: Start the development environment"
	@echo "upd: Start the development environment in the background"
	@echo "down: Stop the development environment"
	@echo "rash: Run ash in the development environment"
	@echo "ash: Run ash in the development environment"
	@echo "build: Build the development environment"

.PHONY: up
up:
	$(dc) up

.PHONY: upd
upd:
	$(dc) up -d

.PHONY: down
down:
	$(dc) down

.PHONY: rash
rash:
	$(dc) run --rm $(target) ash

.PHONY: ash
ash: upd
	$(dc) exec $(target) ash

.PHONY: build
build:
	$(dc) build --no-cache