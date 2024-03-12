#!/bin/bash
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  make \
  bison \
  flex \
  gettext \
  binutils \
  libdevmapper-dev
