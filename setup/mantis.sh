#!/bin/bash
#
# Bootstraping my workstation
#

set -e

# Setup oh-my-zsh
ssh-add --apple-use-keychain
curl -sk https://raw.githubusercontent.com/imotov/dotfiles/master/bootstrap | zsh

# Install brew and required packages
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew install gradle 

# Install rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
rustup toolchain install nightly 
cargo install cargo-nextest --locked

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# Install jekyll
brew install ruby-install chruby xz
ruby-install --update ruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby | cut -c 4- > ~/.ruby-version
gem update
gem install bundler jekyll

# Install zola
brew install zola
