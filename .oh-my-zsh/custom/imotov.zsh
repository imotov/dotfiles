unsetopt correct_all
# Connect phone to emulator
alias adbemu='adb -d forward tcp:5601 tcp:5601'
# Emulator screen capture
alias adbesc="adb -e shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' >"
# Device screen capture
alias adbdsc="adb -d shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' >"
