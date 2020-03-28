#!/bin/bash
#
# Jupiter installation
#

set -e
sudo apt-get update
sudo apt-get install -y\
  jupyter\
  libxml2-utils\
  libxcb-xtest0\
  libxcb-xtest0\
  libpango1.0-0\
  libpangox-1.0-0\
  python3\
  python3-matplotlib\
  python3-pandas\
  python3-geopandas\
  python3-geojson\
  python3-shapely\
  
