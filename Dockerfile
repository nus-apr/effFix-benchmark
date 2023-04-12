FROM ubuntu:20.04
LABEL maintainer="Ridwan Shariffdeen <rshariffdeen@gmail.com>"

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y

# install dependencies for benchmark programs
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
    libedit-dev \
    nasm \
    php \
    php7.4-dev \
    libpcap-dev \
    libpcre3 \
    libpcre3-dev \
    libdumbnet-dev \
    zlib1g-dev \
    libluajit-5.1-dev \
    libssl-dev \
    libnghttp2-dev \
    libdnet \
    openssl \
    bison \
    flex \
    libdaq-dev \
    clang-format \
    gettext \
    libtasn1-dev \
    libffi-dev \
    libelf-dev



