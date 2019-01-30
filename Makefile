SHELL := /bin/bash
.DEFAULT_GOAL := help

help:
	@echo "help"
	@echo ""
	@echo "Commands available:"
	@echo "==================="
	@echo ""
	@echo "run"

run:
	docker-compose up -d
