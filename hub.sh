#!/bin/bash

version=1.0.3
docker build . -f Dockerfile -t zjb0807/asch:"$version"
#docker build . -f Dockerfile --no-cache -t zjb0807/asch:"$version"

docker tag zjb0807/asch:"$version" zjb0807/asch:latest

docker login
docker push zjb0807/asch:"$version"
docker push zjb0807/asch:latest
