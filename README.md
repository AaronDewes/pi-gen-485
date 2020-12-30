# pi-gen-485
Example for pi-gen bug #485

*I am not able to complete the test at this moment as the pi-gen build is not working any any of my systems.  There seems to be an error retrieving the `adduser 3.118` package.*

This is an example of the dkms issue in pi-gen as noted in [bug 485](https://github.com/RPi-Distro/pi-gen/issues/485).

This example uses Docker to run various components.

The directory where `setup.sh` is located is called the `WORKING` directory.

# setup.sh

The `setup.sh` script will setup the environment for the pi-gen to execute.  It performs the following tasks

 1. creates the debian install pacakge for the hello_1.0 program.  The hello_1.0 program is a simple kernel module that prints ""Hello, this is my first kernel module" in the kernel log when it loads.
 2. creates a repository directory (`repo`) under the `WORKING` directory and copies the `*.deb` file into it.
 3. creates a apt server using the Docker file in the `apt` directory.
 4. runs the apt server and updates the `repo` directory to contain all the necessary files to support the apt repository.
 5. checksout the current version of pi-gen into the `WORKING/pi-gen` directory.
 6. copies the files in the `WORKING/pi-gen-overlay` tree onto the `WORKING/pi-gen` tree.  This applies the changes necessary to have the build attempt to install the hello project.
 7. adds the apt server as a repository in the `stage3/02-configure-apt/files` directory as `hello.list`.
 
at this point pi-gen is ready to be run from the `WORKING/pi-gen` directory using the command `build-docker.sh`.

# cleanup.sh

This script removes all docker images created by the `setup.sh` script and removes the `WORKING/pi-gen` directory, so that the `setup.sh` script can be run again.
