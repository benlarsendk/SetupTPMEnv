#!/bin/bash


# Install requirements for IBM
apt install libssl-dev build-essential autoconf libtool pkg-config -y
# Install requirements for dev
apt install cmake gdb -y



# Download IBM Software TPM and TSS
cd /tmp/
wget -O ibmtpm.tar.gz https://sourceforge.net/projects/ibmswtpm2/files/latest/download
wget -O ibmtss.tar.gz https://sourceforge.net/projects/ibmtpm20tss/files/latest/download


mkdir /opt/ibmtpm && tar -xzf ibmtpm.tar.gz -C /opt/ibmtpm
mkdir /opt/ibmtss && tar -xzf ibmtss.tar.gz -C /opt/ibmtss


# Build IBM TPM
cd /opt/ibmtpm/src
make

cd /opt/ibmtss
autoreconf -i
./configure --prefix=${HOME}/local --disable-hwtpm
make clean
make -f utils/makefiletpmc
make install
