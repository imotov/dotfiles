OS=$(uname)

if [[ $OS == "Darwin" ]]; then
  PATH=$PATH:$HOME/.local/bin

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
      # Ensure that pip can only install to virtualenv's make gpip a workaround
      export PYENV_VIRTUALENV_DISABLE_PROMPT=1
      export PIP_REQUIRE_VIRTUALENV=true
      gpip() {
          PIP_REQUIRE_VIRTUALENV="" pip "$@"
      }
      export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
    fi
  fi

  # Setup poetry
  if command -v poetry 1>/dev/null 2>&1; then
    mkdir -p $ZSH_CUSTOM/plugins/poetry
    poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry
  fi

  # Setup command line utilities for VS Code
  if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then
    export PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  fi

  # Setup command line utilities for Sublime
  if [ -d "/Applications/Sublime Text.app/Contents/SharedSupport/bin" ]; then
    export PATH=$PATH:"/Applications/Sublime Text.app/Contents/SharedSupport/bin"
  fi

  if [ -s "/opt/homebrew/opt/chruby/share/chruby/chruby.sh" ]; then
    source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
    source /opt/homebrew/opt/chruby/share/chruby/auto.sh
  fi

  if [ -s "/usr/libexec/java_home" ]; then
    export ES_JAVA_HOME=`/usr/libexec/java_home -v17`
  fi

  if [ -d "$HOME/Software/apache-opennlp-1.9.4" ]; then
    export PATH=$PATH:"$HOME/Software/apache-opennlp-1.9.4/bin"
  fi
  
fi
