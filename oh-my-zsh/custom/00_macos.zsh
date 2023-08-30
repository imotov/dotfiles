OS=$(uname)

if [[ $OS == "Darwin" ]]; then
  # Setup tunnels
  alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"

  # Setup homebrew
  [ -s "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

  # Setup node.js virtual environment manager
  if [ -s "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  fi

  # Setup pyenv
  if [ -d "$HOME/.pyenv" ]; then
    PYENV_ROOT="$HOME/.pyenv"
    PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
      export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    fi
  fi

  # Setup command line utilities for VS Code
  if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then
    export PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  fi

  # Setup command line utilities for Sublime
  if [ -d "/Applications/Sublime Text.app/Contents/SharedSupport/bin" ]; then
    export PATH=$PATH:"/Applications/Sublime Text.app/Contents/SharedSupport/bin"
  fi

fi
