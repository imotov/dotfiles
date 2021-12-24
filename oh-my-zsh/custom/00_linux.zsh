OS=$(uname)

if [[ $OS == "Linux" ]]; then
  PATH=$PATH:/home/igor/.local/bin
  PYENV_ROOT="$HOME/.pyenv"
  PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
  fi
fi
