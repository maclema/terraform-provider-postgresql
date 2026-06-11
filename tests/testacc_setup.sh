#!/bin/bash

source "$(pwd)"/tests/switch_superuser.sh
# --build ensures the image is rebuilt for the current PGVERSION
docker compose -f "$(pwd)"/tests/docker-compose.yml up -d --build --wait
