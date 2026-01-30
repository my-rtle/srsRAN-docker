# Dockerfile
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

# srsRAN 4G deps (from srsRAN 4G installation docs)
RUN apt update && apt-get install -y \
  ca-certificates curl wget gnupg lsb-release sudo git \
  build-essential ccache cmake pkg-config \
  autoconf automake doxygen ethtool inetutils-tools \
  libboost-all-dev \
  libusb-1.0-0 libusb-1.0-0-dev libusb-dev \
  libncurses5 libncurses5-dev \
  python3-dev python3-pip python3-mako python3-numpy python3-requests python3-scipy python3-setuptools \
  python3-ruamel.yaml \
  libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev \
  && rm -rf /var/lib/apt/lists/*

ARG UHD_REPO=https://github.com/EttusResearch/uhd.git
ARG UHD_BRANCH=master

RUN git clone --depth 1 --branch ${UHD_BRANCH} ${UHD_REPO} /opt/uhd \
  && cd /opt/uhd/host \
  && mkdir -p build && cd build \
  && cmake ../ \
  && make -j"$(nproc)" \
  && ctest --output-on-failure || true \
  && make install \
  && ldconfig

# Download FPGA/firmware images (works even when uhd-images pkg isn't available)
RUN uhd_images_downloader || true

# Build & install srsRAN 4G from source
WORKDIR /opt
RUN git clone https://github.com/srsran/srsRAN_4G.git \
    && cd srsRAN_4G \
    && mkdir -p build && cd build \
    && cmake .. \
    && make -j"$(nproc)" \
    && make install \
    && ldconfig


WORKDIR /work
CMD ["bash"]
