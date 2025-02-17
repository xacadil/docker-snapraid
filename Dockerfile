FROM debian
MAINTAINER Alex Kretzschmar <alexktz@gmail.com>

ARG SNAPRAID_VERSION

# Builds SnapRAID from source
RUN apt update && \
    apt install -y \
      gcc \
      git \
      make \
      checkinstall \
      curl \
      libblkid1
RUN curl -LO https://github.com/amadvance/snapraid/releases/download/v${SNAPRAID_VERSION}/snapraid-${SNAPRAID_VERSION}.tar.gz && \
      tar -xvf snapraid-${SNAPRAID_VERSION}.tar.gz && \
      cd snapraid-${SNAPRAID_VERSION} && \
      ./configure && \
      make -j4 && \
      make -j4 check && \
      checkinstall -Dy --install=no --nodoc && \
      mkdir /build && \
      cp *.deb /build/snapraid-from-source.deb
