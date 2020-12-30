#!/bin/bash -e

install -m 644 files/*.list ${ROOTFS_DIR}/etc/apt/sources.list.d/

on_chroot << EOF
apt-get update
EOF
