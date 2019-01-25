#!/usr/bin/env bash

#Get needed stuff 1st
./download.sh

#Clean anything with same name to get rid of clashes
docker-compose down

#update with actual password
echo "password" > ./secrets/artifactoryPassword

#update older jenkins image, make sure it doesnt use cache
docker-compose build --no-cache

#run all
docker-compose up -d