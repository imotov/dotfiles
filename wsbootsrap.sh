#!/bin/bash
#
# Workstation bootstrap
#

set -e
mkdir -p ~/.wsbootstrap

wsbDir=~/.wsbootstrap
markerUpgrade=$wsbDir/0
markerSetup1=$wsbDir/1
markerSetup2=$wsbDir/2
markerSetup3=$wsbDir/3
bootstapDisk=/media/$USER/Bootstrap
hostName=`hostname`

if [ ! -f  $markerUpgrade ]; then
  sudo apt-get update
  sudo apt-get -y dist-upgrade
  if [[ -n "$MACHINE_NAME" ]]; then
    sudo --preserve-env=MACHINE_NAME sed -i "s/ubuntu/$MACHINE_NAME/g" /etc/hosts
    sudo --preserve-env=MACHINE_NAME sed -i "s/ubuntu/$MACHINE_NAME/g" /etc/hostname
  fi
  touch $markerUpgrade
  echo
  echo "Restart the system"
  exit 0
fi

# Setup 1st Phase
if  [ ! -f  $markerSetup1 ]; then
  echo "Initial Setup"
  sudo mkdir -p /var/cache/oracle-jdk11-installer-local/
  sudo cp $bootstapDisk/java/jdk-11.0.3_linux-x64_bin.tar.gz /var/cache/oracle-jdk11-installer-local/

  sudo add-apt-repository ppa:linuxuprising/java
  sudo apt-get update
  sudo apt-get install -y\
    ant\
    apt-transport-https\
    ca-certificates\
    calibre\
    curl\
    gadmin-openvpn-client\
    git\
    gnome-tweaks\
    jq\
    jupyter\
    libxml2-utils\
    lm-sensors\
    libxcb-xtest0\
    libpango1.0-0\
    libpangox-1.0-0\
    network-manager-openvpn\
    network-manager-openvpn-gnome\
    openjdk-8-jdk\
    openjdk-8-source\
    openvpn\
    oracle-java11-installer-local\
    oracle-java12-installer\
    powertop\
    python3\
    python3-matplotlib\
    python3-pandas\
    python3-geopandas\
    python3-geojson\
    python3-shapely\
    python-gpg\
    python3-gpg\
    python3-distutils\
    software-properties-common\
    tree\
    virtualbox\
    tlp\
    zsh

  sudo snap install atom --classic
  sudo snap install intellij-idea-ultimate --classic
  sudo snap install pycharm-professional --classic
  sudo snap install slack --classic
  sudo snap install go --classic
  sudo snap install spotify

  #docker
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  # chrome
  curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo add-apt-repository "deb https://dl.google.com/linux/chrome/deb/ stable main"

  sudo apt-get update
  sudo apt-get install -y docker-ce google-chrome-stable

  # setup variables
  sudo bash -c "cat >> /etc/environment" <<EOF
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
JAVA_HOME="/usr/lib/jvm/java-12-oracle"
RUNTIME_JAVA_HOME="/usr/lib/jvm/java-11-oracle"
JAVE8_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
JAVA11_HOME="/usr/lib/jvm/java-11-oracle"
JAVA12_HOME="/usr/lib/jvm/java-12-oracle"
EOF

  echo "Switching to zsh"
  chsh -s /bin/zsh
  rm -rf ~/.oh-my-zsh
  rm -rf ~/.dotfiles
  git clone -q git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  cd ~/.oh-my-zsh/plugins && git clone -q git://github.com/zsh-users/zsh-syntax-highlighting.git
  git clone -q https://github.com/imotov/dotfiles.git ~/.dotfiles
  . ~/.dotfiles/push
  pushd ~/.dotfiles
  # Set proper url for .dotfiles remote repository
  git remote set-url origin git@github.com:imotov/dotfiles.git
  popd
  mkdir ~/Projects
  touch $markerSetup1
fi

# Setup 2nd Phase
if  [ ! -f  $markerSetup2 ]; then
  echo "Setting up Bootstrap files"
  while [ ! -f $bootstapDisk/update.sh ]; do
    echo "Bootstrap disk not found. Insert bootstrap disk and press any key. Press q to quit."
    read -n 1 k <&1
    echo
    if [[ $k = q ]] ; then
      exit 1
    fi
  done
  cp -r $bootstapDisk/bootstrap/$hostName/. ~

  touch $markerSetup2
fi

# Setup 3rd Phase
if  [ ! -f  $markerSetup3 ]; then
  echo "Setting up Misc Apps"
  # Zoom
  (cd ~/Downloads && curl -O -L https://zoom.us/client/latest/zoom_amd64.deb)
  sudo dpkg -i ~/Downloads/zoom_amd64.deb
  sudo apt-get install -f

  # Dropbox
  if [[ $hostName = "silverfish" ]] ; then
    echo "Installing HA development dependencies"
    sudo apt-get install -y python3-pip python3-dev python3-venv
    sudo apt-get install -y autoconf libssl-dev libxml2-dev libxslt1-dev libjpeg-dev libffi-dev libudev-dev zlib1g-dev
    sudo apt-get install -y libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev libavfilter-dev

    echo "Installing Dropbox..."
    (cd ~/Downloads && curl -O -L https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2019.02.14_amd64.deb)
    sudo dpkg -i ~/Downloads/dropbox_2019.02.14_amd64.deb

    echo "Installing Misc utils..."
    sudo apt-get install -y youtube-dl

    # Fix sleep issue
    sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash mem_sleep_default=deep"/' /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
  fi

  touch $markerSetup3
fi

echo "Done"
