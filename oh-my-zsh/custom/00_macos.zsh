OS=$(uname)

if [[ $OS == "Darwin" ]]; then
  # Setup tunnels
  alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"

  # Setup homebrew
  [ -s "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

  # Setup command line utilities for VS Code
  if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then
    export PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  fi

  # Setup command line utilities for Sublime
  if [ -d "/Applications/Sublime Text.app/Contents/SharedSupport/bin" ]; then
    export PATH=$PATH:"/Applications/Sublime Text.app/Contents/SharedSupport/bin"
  fi

fi
