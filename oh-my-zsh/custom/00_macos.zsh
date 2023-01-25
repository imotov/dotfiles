OS=$(uname)

if [[ $OS == "Darwin" ]]; then
  # Setup tunnels
  alias callhome="ssh -C -N -2 -v -D 8080 home -p 22422"

  # Setup java
  /usr/libexec/java_home &> /dev/null
  if [ $? -eq 0 ]; then
    JAVA17_HOME=$(/usr/libexec/java_home -v 17.0); export JAVA17_HOME
    launchctl setenv JAVA17_HOME "$JAVA17_HOME"

    JAVA19_HOME=$(/usr/libexec/java_home -v 19.0); export JAVA19_HOME
    launchctl setenv JAVA17_HOME "$JAVA19_HOME"

    JAVA_HOME=$JAVA17_HOME; export JAVA_HOME
    launchctl setenv JAVA_HOME "$JAVA_HOME"
  fi

  # Setup homebrew
  [ -s "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # Setup pyenv environment
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  fi

  # Setup Rust environment
  if [ -s "$HOME/.cargo/env" ]; then
    source $HOME/.cargo/env
  fi

  #Setup Ruby environment
  if [ -s "/opt/homebrew/opt/chruby/share/chruby/chruby.sh" ]; then
    source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
    source /opt/homebrew/opt/chruby/share/chruby/auto.sh
    chruby ruby-3.1.2
  fi

  # Setup command line utilities for Sublime
  if [ -d "/Applications/Sublime Text.app/Contents/SharedSupport/bin/" ]; then
    export PATH=$PATH:"/Applications/Sublime Text.app/Contents/SharedSupport/bin/"
  fi

  # Setup command line utilities for VS Code
  if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then
    export PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  fi

fi
