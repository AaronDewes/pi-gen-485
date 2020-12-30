FROM httpd:2.4

RUN apt -y update && \
    mkdir -p /usr/share/man/man1 ; \
    apt -y install --no-install-recommends \
        dpkg-dev dpkg-sig \
        ca-certificates \
	apt-utils \
	openssh-server ;\
    useradd -m apt ; \
    printf 'acc3ss!\nacc3ss!' | passwd apt ; \
    mkdir -p /usr/local/apache2/htdocs/repo/armhf ; \
    mkdir ~/.gnupg ; \
    echo "cert-digest-algo SHA256" >> ~/.gnupg/gpg.conf ; \
    echo "digest-algo SHA256" >> ~/.gnupg/gpg.conf ; 

COPY --chown=apt:apt hd44780-i2c_1.0.0-178_armhf.deb /usr/local/apache2/htdocs/repo/armhf
COPY dpkg1.batch .

RUN gpg --batch --key-gen dpkg1.batch ; \
    gpg --import dpkg1.key ; \
    export KEYID=`gpg dpkg1.key | grep 4096R | cut -f2 -d' ' | cut -f2 -d'/'` ; \
    gpg --output /usr/local/apache2/htdocs/repo/key.gpg --armor --export $KEYID ; 

RUN cd /usr/local/apache2/htdocs/repo ;  \
    apt-ftparchive --arch armhf packages armhf > Packages ; \
    gzip -k -f Packages ; \
    apt-ftparchive release . > Release ; \
    gpg --default-key dpkg1 -abs -o Release.gpg Release ; \
    gpg --default-key dpkg1 --clearsign -o InRelease Release

ENTRYPOINT  /etc/init.d/ssh start && httpd-foreground

