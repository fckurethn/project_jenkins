#!/bin/bash

TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKERHUB_USERNAME}'", "password": "'${DOCKERHUB_PASSWORD}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)
REPO_LIST=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${DOCKERHUB_USERNAME}/?page_size=10000 | jq -r '.results|.[]|.name')

for i in ${REPO_LIST}
do
    IMAGE_TAGS=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${DOCKERHUB_USERNAME}/${i}/tags/?page_size=10000 | jq -r '.results|.[]|.name')
    IMAGE_TAGS=`echo ${IMAGE_TAGS} | awk '{$1=""; $2=""; $3=""; print $0}' | cut -c 3-`
    for j in ${IMAGE_TAGS}
	do
	curl -s  -X DELETE  -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${DOCKERHUB_USERNAME}/${i}/tags/${j}/
	done
done
