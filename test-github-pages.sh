#!/bin/bash

set -e -u -x

basedir=$(readlink --canonicalize $(dirname $0))

docker build --tag sunflower-dash/gh-pages .
docker run \
  --interactive --tty --rm \
  --volume "${basedir}":/src \
  --env HUGO_ENV=production \
  --publish 0.0.0.0:1313:1313 \
  sunflower-dash/gh-pages \
  server --source docs --disableFastRender
