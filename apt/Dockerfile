FROM httpd:2.4

RUN apt -y update && \
    mkdir -p /usr/share/man/man1 ; \
    apt -y install --no-install-recommends \
        dpkg-dev dpkg-sig \
        ca-certificates \
	apt-utils \
        iproute2  ;   

ENTRYPOINT  /mnt/apt/apt_setup.sh && httpd-foreground

