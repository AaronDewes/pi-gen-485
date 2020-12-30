ARG BASE_IMAGE=debian:buster
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
        debhelper \ 
	fakeroot \
    && rm -rf /var/lib/apt/lists/*




