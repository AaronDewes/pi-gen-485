#!/bin/bash -x

## create a debian package for the hello example 

cd hello_1.0
dh clean
dh build
fakeroot dh binary
cd ..

