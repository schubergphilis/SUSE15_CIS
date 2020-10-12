.PHONY: help
help:
	@echo "Read the Makefile if you want to know which commands you can execute."
	@echo "Commands available: clean/dev/devimage/test/converge/testtag"
	@echo "only the 'testtag' command has parameters:"
	@echo " make TAG=<ansible tag you want to include> testtag"
# for use within venv
.PHONY: clean
clean:
	set -e
	rm -rf .venv
	pipenv install

.PHONY: devimage
devimage:
	docker build -t devimage:latest other

.PHONY: rundevimage
rundevimage:
	docker run --privileged --name=devimage --rm -v /sys/fs/cgroup:/sys/fs/cgroup:ro devimage &

.PHONY: test
test:
	docker build -t devimage:latest other
	export DOCKER_IMAGE=devimage && time pipenv run molecule test

.PHONY: converge
converge:
	export DOCKER_IMAGE=devimage && time pipenv run molecule converge

.PHONY: tagdev
tagdev:
#for speeding up dev work. Usage: 'make TAG=<ansible tag> testtag'.
#use 'make devimage' first, this will create a local docker image for use with this stage
	export DOCKER_IMAGE=devimage && time pipenv run molecule converge -- --tags=always,$(TAG)

.PHONY: lint
lint:
	pipenv run ansible-lint && pipenv run yamllint .

.PHONY: fmt
fmt:
	@bash other/yamlfmt.sh