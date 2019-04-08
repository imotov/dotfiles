OS=$(uname)

if [[ $OS == "Linux" ]]; then
  NVM_DIR=~/.nvm; export NVM_DIR
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"
  alias tues="ssh -C -N -T -v -L 5601:127.0.0.1:5601 home"
  alias tuci="ssh -C -N -T -v -L 8080:127.0.0.1:8080 home"
fi
