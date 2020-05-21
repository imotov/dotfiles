#!/bin/bash
#
# Bootstraping my desktop
#

set -e
sudo apt-get update
sudo apt-get -y dist-upgrade

sudo sed -i "s/ubuntu/leafminer/g" /etc/hosts
sudo sed -i "s/ubuntu/leafminer/g" /etc/hostname

# general utilities
sudo apt-get install -y\
  git\
  curl\
  zsh\
  apt-transport-https\
  ca-certificates\
  gnome-tweaks\
  flameshot\
  rclone\


# java development
sudo apt-get install -y\
  ant\
  jq\
  openjdk-8-jdk\
  openjdk-8-source\
  openjdk-11-jdk\
  openjdk-11-source\
  default-jdk\


# jupyter and python development setup
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
  python3-lxml\
  pipenv\


# python and home assistant development
sudo apt-get install -y\
  build-essential\
  libncurses5-dev\
  libgdbm-dev\
  libnss3-dev\
  libreadline-dev\
  libffi-dev\
  libsqlite3-dev\
  autoconf\
  libssl-dev\
  libxml2-dev\
  libxslt1-dev\
  libjpeg-dev\
  libffi-dev\
  libudev-dev\
  zlib1g-dev\
  pkg-config\
  libavformat-dev\
  libavcodec-dev\
  libavdevice-dev\
  libavutil-dev\
  libswscale-dev\
  libavresample-dev\
  libavfilter-dev\
  git-secret\



# misc utilities
sudo apt-get install -y\
  screenkey\


# custom apt repositories
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"
sudo add-apt-repository ppa:linuxuprising/java

sudo apt-get update
sudo apt-get install -y\
  google-chrome-stable\
  docker.io\
  docker-compose\
  oracle-java14-installer\


# snap utilities
sudo snap install atom --classic
sudo snap install pycharm-professional --classic
sudo snap install intellij-idea-community --classic
sudo snap install spotify


# setup dotfiles and enviroments
git clone -q git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cd ~/.oh-my-zsh/plugins && git clone -q git://github.com/zsh-users/zsh-syntax-highlighting.git
git clone -q https://github.com/imotov/dotfiles.git ~/.dotfiles
. ~/.dotfiles/push

pushd ~/.dotfiles
# Set proper url for .dotfiles remote repository
git remote set-url origin git@github.com:imotov/dotfiles.git
popd

sudo mv /etc/environment /etc/environment.bak
sudo bash -c "cat > /etc/environment" <<EOF
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:"
JAVA_HOME="/usr/lib/jvm/java-14-oracle"
RUNTIME_JAVA_HOME="/usr/lib/jvm/java-11-oracle"
JAVA8_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
JAVA11_HOME="/usr/lib/jvm/java-11-oracle"
JAVA14_HOME="/usr/lib/jvm/java-14-oracle"
EOF

chsh -s /usr/bin/zsh

# Install keybase
pushd ~/Downloads
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install -y ./keybase_amd64.deb
popd

# Install python3.7.7
pushd ~/Downloads
curl --remote-name https://www.python.org/ftp/python/3.7.7/Python-3.7.7.tgz
tar -xzf Python-3.7.7.tgz
cd Python-3.7.7
./configure -enable-loadable-sqlite-extensions --enable-optimizations
sudo make altinstall
popd

echo "- install zoom from https://zoom.us/download"
echo "- restart the system"
echo "- run run_keybase"
