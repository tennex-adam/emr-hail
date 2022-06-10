#!/bin/bash
set -x -e
export PATH=$PATH:/usr/local/bin

yum -y install \
  bzip2-devel \
  diffutils \
  gcc72-c++ \
  gcc-gfortran \
  libcurl-devel \
  libXt-devel \
  pcre-devel \
  perl \
  readline-devel \
  xz-devel \
  zlib-devel

export R_VERSION=3.5.3
export R_MAJOR_VERSION=$(echo $R_VERSION | cut -d . -f 1)
curl -O https://cran.rstudio.com/src/base/R-${R_MAJOR_VERSION}/R-${R_VERSION}.tar.gz
tar -xzvf R-${R_VERSION}.tar.gz
cd R-${R_VERSION}

 ./configure \
  --prefix=/opt/R/${R_VERSION} \
  --enable-memory-profiling \
  --enable-R-shlib \
  --with-blas \
  --with-lapack

make
make install

ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R
ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript

cd ..
rm -rf R-${R_VERSION}.tar.gz R-${R_VERSION}
