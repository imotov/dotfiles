OS=$(uname)

if [[ $OS == "Linux" ]]; then
  NVM_DIR=~/.nvm; export NVM_DIR
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  GOPATH=~/Projects/GoWork; export GOPATH
  PATH=$PATH:$GOPATH/bin:$HOME/.cargo/bin; export PATH
  alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"
  alias tues="ssh -C -N -T -v -L 5601:127.0.0.1:5601 home"
  alias tuci="ssh -C -N -T -v -L 8080:127.0.0.1:8080 home"
  # adjust USB-C display
  alias ucdon='xrandr --output DP-1 --scale 2x2'
  alias ucdoff='xrandr --output DP-1 --scale 1x1'
batsave() {
  sudo sh -c 'echo "min_power" > "/sys/class/scsi_host/host1/link_power_management_policy"'
  sudo sh -c 'echo "min_power" > "/sys/class/scsi_host/host0/link_power_management_policy"'
  sudo sh -c 'echo "1500" > "/proc/sys/vm/dirty_writeback_centisecs"'
}
fi
