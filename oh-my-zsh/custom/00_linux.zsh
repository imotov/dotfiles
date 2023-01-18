OS=$(uname)

if [[ $OS == "Linux" ]]; then
  PATH=$PATH:$JAVA_HOME/bin:/home/igor/.local/bin
  PYENV_ROOT="$HOME/.pyenv"
  PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  fi
fi
