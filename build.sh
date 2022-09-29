#!/bin/bash

set -e

STACK_VERSIONS=(18 20 22)

for stack_version in "${STACK_VERSIONS[@]}"; do
  mkdir -p build

  image_name=libvips/heroku-$stack_version:$VIPS_VERSION

  docker build \
    --file container/Dockerfile \
    --build-arg VIPS_VERSION=${VIPS_VERSION} \
    --build-arg STACK_VERSION=${stack_version} \
    --tag $image_name \
    build

  docker cp $(docker create $image_name):/usr/local/vips/build/. build

  image_name=libvips/heroku-test-$stack_version:$VIPS_VERSION

  docker build \
    --file container/Dockerfile.test \
    --build-arg STACK_VERSION=${stack_version} \
    --tag $image_name \
    build
done
