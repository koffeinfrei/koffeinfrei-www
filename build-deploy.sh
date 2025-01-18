#!/bin/bash

bundle exec middleman build && \
  ./deploy.sh
