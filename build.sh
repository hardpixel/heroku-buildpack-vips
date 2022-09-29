#!/bin/bash

set -e

STACK_VERSIONS=(18 20 22)

for stack_version in "${STACK_VERSIONS[@]}"; do
  image_name=libvips-heroku-$stack_version:$VIPS_VERSION

  docker build \
    --build-arg VIPS_VERSION=${VIPS_VERSION} \
    --build-arg STACK_VERSION=${stack_version} \
    -t $image_name \
    container

  mkdir -p build

  docker run --rm -t -v $PWD/build:/build --user $(id -u):$(id -g) \
    $image_name sh -c "cp -rf /usr/local/vips/build/* /build"

  image_name=libvips-heroku-test-$stack_version:$VIPS_VERSION

  docker build \
    --file container/Dockerfile.test \
    --build-arg STACK_VERSION=${stack_version} \
    -t $image_name \
    build
done
