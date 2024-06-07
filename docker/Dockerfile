# docker build docker/ -t edward314/darknet:latest -t edward314/darknet:20240608
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN sed 's/archive.ubuntu.com/mirror.iscas.ac.cn/g' /etc/apt/sources.list -i \
    && apt-get update && apt-get install -y wget software-properties-common \
    && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin -O /etc/apt/preferences.d/cuda-repository-pin-600 \
    && apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub \
    && add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" \
    && apt-get update && apt-get install -y \
        git build-essential  libopencv-dev xmlstarlet \
        nvidia-cuda-dev nvidia-cuda-toolkit libcudnn8-dev libcublas-12-0 \
    && mkdir /build && cd /build && git clone https://github.com/edward314/darknet && cd darknet && git checkout 6e79256ea2dd7ee9c2f4c902927a99c4a6b32e55 \
    && make -j$(nproc) && cp darknet /usr/bin/darknet
