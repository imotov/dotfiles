brew doctor
brew update
brew install ant maven32 ivy nvm python3 awscli youtube-dl
# Setup squid
brew install squid
mkdir /usr/local/etc/squid
~/bin/update_ads.sh
cp ~/.dotfiles/brew/squid.conf /usr/local/etc
