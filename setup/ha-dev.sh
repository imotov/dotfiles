#!/bin/bash
#
# HA development environment
#

set -e
sudo apt-get update
sudo apt-get install -y\
  autoconf\
  libssl-dev\
  libxml2-dev\
  libxslt1-dev\
  libjpeg-dev\
  libffi-dev\
  libudev-dev\
  zlib1g-dev\
  libavformat-dev\
  libavcodec-dev\
  libavdevice-dev\
  libavutil-dev\
  libswscale-dev\
  libavresample-dev\
  libavfilter-dev\


sudo snap install pycharm-community --classic
