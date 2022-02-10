#!/bin/bash

set -e

OS=linux 
ARCH=amd64

rm -rf /usr/local/go

apt-get update && \
    apt-get install -y build-essential \
    libseccomp-dev pkg-config squashfs-tools cryptsetup

wget -O /tmp/go"${GO_VERSION}"."${OS}"-"${ARCH}".tar.gz https://dl.google.com/go/go"${GO_VERSION}"."${OS}"-"${ARCH}".tar.gz && \
    tar -C /usr/local -xzf /tmp/go"${GO_VERSION}"."${OS}"-"${ARCH}".tar.gz

export GOPATH=/root/go PATH=/usr/local/go/bin:"${PATH}":"${GOPATH}"/bin

mkdir -p "${GOPATH}"/src/github.com/sylabs && \
    cd "${GOPATH}"/src/github.com/sylabs && \
    rm -rf singularity && \
    git clone https://github.com/hpcng/singularity.git && \
    cd singularity

git checkout v"${SINGULARITY_VERSION}"

cd "${GOPATH}"/src/github.com/sylabs/singularity && \
    ./mconfig && \
    cd ./builddir && \
    make && \
    make install

singularity version
