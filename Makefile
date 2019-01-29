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
	docker run -v `pwd`:/srv/jekyll -p 4000:4000 -it jekyll/jekyll:3.8 jekyll serve --watch --drafts
