#!/bin/bash

set -ex

aws s3 sync --delete _build/localhost:9292/ s3://$STATIC_SITE_S3_BUCKET/
