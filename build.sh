#!/bin/sh

wget --mirror --page-requisites --directory=./_build/ localhost:9292

wget --content-on-error --directory-prefix=./_build/ localhost:9292/error.html
mv ./_build/error.html ./_build/localhost:9292/error.html
