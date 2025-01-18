#!/bin/bash

source .env

lftp -e "mirror -e -R build $DEPLOY_DIR && exit" -u $DEPLOY_USERNAME $DEPLOY_HOST
