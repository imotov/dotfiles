NAME=$(uname -n)

if [[ $NAME == "grasshopper" ]]; then
  # adjust USB-C display
  alias ucdon='xrandr --output DP-1 --scale 2x2'
  alias ucdoff='xrandr --output DP-1 --scale 1x1'
  # is video on?
  # returns 1 is a video camera in use and 0 otherwise
  alias ivo="lsmod | grep '^uvcvideo' | cut -b 31-"
batsave() {
  sudo sh -c 'echo "min_power" > "/sys/class/scsi_host/host1/link_power_management_policy"'
  sudo sh -c 'echo "min_power" > "/sys/class/scsi_host/host0/link_power_management_policy"'
  sudo sh -c 'echo "1500" > "/proc/sys/vm/dirty_writeback_centisecs"'
}
  alias lon='kasa --plug --alias "Leafminer Plug" on'
  alias loff='kasa --plug --alias "Leafminer Plug" off'
fi
