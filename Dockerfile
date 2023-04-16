FROM ubuntu:20.04
LABEL maintainer="Ridwan Shariffdeen <rshariffdeen@gmail.com>"

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y

# install some basic software
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
    ca-certificates \
    cmake \
    gdb \
    git \
    make \
    nano \
    openssh-client \
    vim \
    wget


# install dependencies for benchmark programs
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
    bison \
    clang-format \
    flex \
    gettext \
    libdaq-dev \
    libdnet \
    libdumbnet-dev \
    libedit-dev \
    libelf-dev \
    libffi-dev \
    libluajit-5.1-dev \
    libnghttp2-dev \
    libpcap-dev \
    libpcre3 \
    libpcre3-dev \
    libssl-dev \
    libtasn1-dev \
    nasm \
    openssl \
    php \
    php7.4-dev \
    zlib1g-dev








