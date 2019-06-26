DOCKER_NAME=smtt/arg_testing_framework
VERSION=0.0.1
DOCKER_NAME_FULL=$(DOCKER_NAME):$(VERSION)
ROBOT_TESTS=
LOG_LEVEL=INFO
ENV=development

clean:
	@find . -iname "*~" | xargs rm 2>/dev/null || true
	@find . -iname "*.pyc" | xargs rm 2>/dev/null || true
	@find . -iname "*output.xml" | xargs rm 2>/dev/null || true
	@find . -iname "*log.html" | xargs rm 2>/dev/null || true
	@find . -iname "Sikuli_java_std*" | xargs rm 2>/dev/null || true
	@find . -iname "sikuli_captured" | xargs rm -rf 2>/dev/null || true

clean-reports:
	sudo rm output/*

build: clean
	docker build -t $(DOCKER_NAME_FULL) .

run:
	docker run --rm -e ROBOT_TESTS=$(ROBOT_TESTS) -e LOG_LEVEL=$(LOG_LEVEL) -e ENV=$(ENV) -v /dev/shm:/dev/shm -v $(shell pwd):/opt/mb/robot/ $(DOCKER_NAME_FULL)

run-jenkins:
		@docker pull $(DOCKER_NAME_FULL)
		docker run --rm -e ROBOT_TESTS=$(ROBOT_TESTS) --network host -e LOG_LEVEL=$(LOG_LEVEL) -e ENV=$(ENV) -v /dev/shm:/dev/shm -v $(shell pwd):/opt/mb/robot/ $(DOCKER_NAME_FULL)

interactive:
	docker run -it -v $(shell pwd):/opt/mb/robot/  $(DOCKER_NAME_FULL) bash


publish: build
	@docker push $(DOCKER_NAME_FULL)
