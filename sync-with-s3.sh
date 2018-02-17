#!/bin/bash

set -ex

# aws s3 rm --recursive s3://twomushrooms-static-site/

# for f in `find _build/localhost:9292 -maxdepth 1 -type f | grep -v "\."`; do
#   aws s3 cp --content-type 'text/html' $f s3://twomushrooms-static-site/
# done

aws s3 sync --delete _build/localhost:9292/ s3://$STATIC_SITE_S3_BUCKET/
