brew doctor
brew update
brew install ant maven32 ivy nvm python3 awscli youtube-dl
# Install gradle 2.13
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/df07b59fbed8ee73baef662a85766f2ab7ebe4bf/Formula/gradle.rb
# Setup squid
brew install squid
mkdir /usr/local/etc/squid
~/bin/update_ads.sh
cp ~/.dotfiles/brew/squid.conf /usr/local/etc
