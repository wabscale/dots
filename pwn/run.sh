#!/bin/bash

ENV_NAME=env

[ -d $ENV_NAME ] || ./setup.sh
. ./$ENV_NAME/bin/activate

python solve
