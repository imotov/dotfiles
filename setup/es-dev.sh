#!/bin/bash
#
# Bootstraping elasticsearch development environment on Ubuntu
#
set -e

sudo apt-get update
sudo apt-get -y dist-upgrade

if [ ! -f /var/cache/oracle-jdk11-installer-local/jdk-11.0.6_linux-x64_bin.tar.gz ]; then
  echo "Downloading jdk-11"
  curl --tftp-blksize 10240  -o ~/Downloads/jdk-11.0.6_linux-x64_bin.tar.gz tftp://192.168.14.10/java/jdk-11.0.6_linux-x64_bin.tar.gz
  sudo mkdir -p /var/cache/oracle-jdk11-installer-local/
  sudo cp ~/Downloads/jdk-11.0.6_linux-x64_bin.tar.gz /var/cache/oracle-jdk11-installer-local/
fi

sudo apt-get install -y\
  ant\
  jq\
  openjdk-8-jdk\
  openjdk-8-source\
  oracle-java11-installer-local\
  oracle-java13-installer\
  oracle-java14-installer\

if [[ $NAME == "grasshopper" ]]; then
  sudo snap install intellij-idea-ultimate --classic
else
  sudo snap install intellij-idea-community --classic
fi

sudo snap install go --classic

# setup variables
sudo mv /etc/environment /etc/environment.bak
sudo bash -c "cat > /etc/environment" <<EOF
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/go/bin"
JAVA_HOME="/usr/lib/jvm/java-14-oracle"
RUNTIME_JAVA_HOME="/usr/lib/jvm/java-11-oracle"
JAVA8_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
JAVA11_HOME="/usr/lib/jvm/java-11-oracle"
JAVA13_HOME="/usr/lib/jvm/java-13-oracle"
JAVA14_HOME="/usr/lib/jvm/java-14-oracle"
GOROOT="/usr/local/go"
EOF
