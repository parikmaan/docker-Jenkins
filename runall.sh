#!/usr/bin/env bash

# Download Images
./download.sh

# Stop
docker-compose down

# Update with actual password
echo "admin" > ./secrets/jenkinsUsername
echo "password" > ./secrets/jenkinsPassword
echo "password" > ./secrets/artifactoryPassword

# Build
docker-compose build --no-cache

# Start
docker-compose up -d
