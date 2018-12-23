# Python
MAIN_NAME=
ENV_NAME=venv
PYTHON_VERSION=`which python3`

# Docker
DOCKER_IMAGE_NAME=
DOCKER_OPTIONS=--rm -it
DOCKER=docker
DOCKER_COMPOSE=docker-compose

.PHONY: run setup build rund killd clean cleand

all: build

deploy: ckill
	${DOCKER_COMPOSE} up -d

cbuild:
	${DOCKER_COMPOSE} build

ckill:
	${DOCKER_COMPOSE} kill

build:
	${DOCKER} build -t ${DOCKER_IMAGE_NAME} .

rund: killd
	${DOCKER} run ${DOCKER_OPTIONS} --name ${DOCKER_IMAGE_NAME} ${DOCKER_IMAGE_NAME}

killd:
	if [ -z "$(${DOCKER} ps -q) | grep ${DOCKER_IMAGE_NAME}" ]; then \
		${DOCKER} kill ${DOCKER_IMAGE_NAME}; \
	fi

setup:
	if [ -d ${ENV_NAME} ]; then \
		rm -rf ${ENV_NAME}; \
	fi
	if [ -a requirements.txt ]; then \
		touch requirements.txt; \
	fi
	which virtualenv && pip install virtualenv || true
	virtualenv -p ${PYTHON_VERSION} ${ENV_NAME}
	./${ENV_NAME}/bin/pip install -r requirements.txt

run: 
	if [ ! -d ${ENV_NAME} ]; then \
		make setup; \
	fi
	./${ENV_NAME}/bin/python ${MAIN_NAME}

cleand: killd
	echo 'y' | ${DOCKER} system prune
	if [ -n "`${DOCKER} image list -q | grep ${DOCKER_IMAGE_NAME}`" ]; then \
		${DOCKER} rmi ${DOCKER_IMAGE_NAME}; \
	fi

clean:
	if [ -d ${ENV_NAME} ]; then \
		rm -rf ${ENV_NAME}; \
	fi
	if [ -n "`find . -name __pycache__`" ]; then \
		rm -rf `find . -name __pycache__`;
	fi
