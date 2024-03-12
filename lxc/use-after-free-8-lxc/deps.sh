#!/bin/bash
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  libpcap-dev \
  libgnutls28-dev
