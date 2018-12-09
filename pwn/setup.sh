#!/bin/bash

ENV_NAME=env

[ -d $ENV_NAME ] && rm -rf $ENV_NAME && echo "rm -rf $ENV_NAME"
pip install virtualenv
virtualenv -p `which python3` $ENV_NAME
. ./$ENV_NAME/bin/activate
pip install -r requirements.txt
