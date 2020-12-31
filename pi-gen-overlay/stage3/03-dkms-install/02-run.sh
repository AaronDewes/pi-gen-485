#!/bin/sh -ex

echo "PWD ${PWD}"

echo apt install hello
on_chroot <<EOF
echo $(uname)
apt install hello
EOF
