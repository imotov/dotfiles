NAME=$(uname -n)

if [[ $NAME == "ladybug" ]]; then
  NVM_DIR=~/.nvm; export NVM_DIR
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  GOPATH=~/Projects/GoWork; export GOPATH
  PATH=$PATH:$GOPATH/bin:$HOME/.cargo/bin; export PATH
fi
