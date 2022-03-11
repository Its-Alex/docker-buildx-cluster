#!/usr/bin/env bash

docker buildx create \
    --name cluster_builder \
    --append \
    --node local \
    --platform linux/amd64,linux/386 \
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10000000 \
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=10000000

docker buildx create \
    --name cluster_builder \
    --append \
    --node remote \
    --platform linux/arm64 \
    ssh://vagrant@192.168.56.12 \
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10000000 \
    --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=10000000

docker buildx use cluster_builder