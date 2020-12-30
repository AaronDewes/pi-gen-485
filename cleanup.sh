#!/bin/bash 

WORKING="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


docker kill apt_server
docker container rm apt_server

rm -rf ${WORKING}/pi-gen
