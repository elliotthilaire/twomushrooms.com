#!/bin/bash

set -ex

bundle install
yarn install
node_modules/brunch/bin/brunch build

bundle exec rackup
