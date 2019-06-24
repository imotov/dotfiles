OS=$(uname)

if [[ $OS == "Linux" ]]; then
  NVM_DIR=~/.nvm; export NVM_DIR
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"
  alias tues="ssh -C -N -T -v -L 5601:127.0.0.1:5601 home"
  alias tuci="ssh -C -N -T -v -L 8080:127.0.0.1:8080 home"
  # adjust USB-C display
  alias ucdon='xrandr --output DP-1 --scale 2x2'
  alias ucdoff='xrandr --output DP-1 --scale 1x1'
fi
