#!/bin/bash
#
# Bootstraping elasticsearch development environment on Ubuntu
#
set -e

sudo apt-get update
sudo apt-get -y dist-upgrade

echo "Downloading jdk-11"
curl --tftp-blksize 10240  -o ~/Downloads/jdk-11.0.3_linux-x64_bin.tar.gz tftp://192.168.14.10/java/jdk-11.0.3_linux-x64_bin.tar.gz
sudo mkdir -p /var/cache/oracle-jdk11-installer-local/
sudo cp ~/Downloads/jdk-11.0.3_linux-x64_bin.tar.gz /var/cache/oracle-jdk11-installer-local/

sudo add-apt-repository ppa:linuxuprising/java
sudo apt-get update
sudo apt-get install -y\
  ant\
  jq\
  openjdk-8-jdk\
  openjdk-8-source\
  oracle-java11-installer-local\
  oracle-java12-installer\

sudo snap install intellij-idea-ultimate --classic
sudo snap install pycharm-professional --classic
sudo snap install go --classic

# setup variables
sudo bash -c "cat >> /etc/environment" <<EOF
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/go/bin"
JAVA_HOME="/usr/lib/jvm/java-12-oracle"
RUNTIME_JAVA_HOME="/usr/lib/jvm/java-11-oracle"
JAVA8_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
JAVA11_HOME="/usr/lib/jvm/java-11-oracle"
JAVA12_HOME="/usr/lib/jvm/java-12-oracle"
JAVA13_HOME="/usr/lib/jvm/java-13-oracle"
GOROOT="/usr/local/go"
EOF
