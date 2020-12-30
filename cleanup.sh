#!/bin/bash 

WORKING="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


echo "removing docker containers"
docker kill apt_server
docker container rm apt_server
docker container rm hello_builder

echo "removing pi-gen directory"
rm -rf ${WORKING}/pi-gen
