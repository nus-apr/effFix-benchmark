#!/bin/bash
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  bison \
  wget
