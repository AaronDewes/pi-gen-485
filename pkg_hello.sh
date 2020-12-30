#!/bin/bash -x

cd hello_1.0
dh clean
dh build
fakeroot dh binary
cd ..

