#!/bin/bash
docker rm -f website
docker images -- format '{{.Repository}}:{{.Tag}}' | grep 'takashilouisnguyen/crawler-website' | xargs -r docker rmi
docker run --net crawler --name website -p 3100:80 takashilouisnguyen/crawler-website:$1