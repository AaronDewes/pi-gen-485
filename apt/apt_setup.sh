#!/bin/bash

cd /usr/local/apache2/htdocs/repo

apt-ftparchive packages . > Packages
gzip -k -f Packages 
apt-ftparchive release . > Release


