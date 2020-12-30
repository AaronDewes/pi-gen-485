#!/bin/bash -x

WORKING="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

## build the package
# Check the arch of the machine we're running on. If it's 64-bit, use a 32-bit base image instead
case "$(uname -m)" in
  x86_64|aarch64)
    BASE_IMAGE=i386/debian:buster
    ;;
  *)
    BASE_IMAGE=debian:buster
    ;;
esac
docker build --build-arg BASE_IMAGE=${BASE_IMAGE} -t hello_builder ${WORKING}
docker run -it -v ${WORKING}:/mnt/example -w /mnt/example --name hello_builder hello_builder /mnt/example/pkg_hello.sh

## create a apt repository
mkdir -p ${WORKING}/repo
rm -rf ${WORKING}/repo
mv -f *.deb ${WORKING}/repo

## start apt server
cd ${WORKING}/apt
docker container rm apt_server
docker build -t apt_server ${WORKING}/apt
docker run -itd -v ${WORKING}/repo:/usr/local/apache2/htdocs/repo -v ${WORKING}/apt:/mnt/apt -w /mnt/apt --name apt_server apt_server 

## get the IP for the apt server
export APT_IP=`docker exec -t apt_server bash -c "ip add | grep global | cut -f6 -d' ' | cut -f1 -d'/' " | tr -d '\r'` 

## clone pi-gen
cd ${WORKING}
git clone --single-branch --depth 1 https://github.com/RPi-Distro/pi-gen.git
rsync -rv pi-gen-overlay/* pi-gen

echo "deb [trusted=yes] http://${APT_IP}/repo /" > pi-gen/stage3/02-configure-apt/files/hello.list



