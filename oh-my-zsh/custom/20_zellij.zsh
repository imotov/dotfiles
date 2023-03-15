  # Setup zellij environment
  if [ -x "$HOME/.cargo/bin/zellij" ]; then
    alias z="zellij"
    alias za="zellij a -c default"
    alias zls="zellij ls"
    alias zka="zellij ka"
  fi
