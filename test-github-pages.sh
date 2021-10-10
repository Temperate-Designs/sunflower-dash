#!/bin/bash

set -e -u -x

basedir=$(readlink --canonicalize $(dirname $0))

docker run \
  --volume ${basedir}/docs:/srv/jekyll \
  --volume ${basedir}/docs/_site:/srv/jekyll/_site \
  --publish 4000:4000 \
  jekyll/builder:latest \
  /bin/bash -c "jekyll serve --watch -H 0.0.0.0 --future"
