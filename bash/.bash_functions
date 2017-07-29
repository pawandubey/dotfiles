function projects() {
  if [[ -d "$PROJECTS_DIR" ]]; then
    cd "$PROJECTS_DIR"
  else
    echo "ERROR: PROJECTS_DIR is not set or doesn't exist."
  fi
}

function dotfiles() {
  if [[ -d ~/.dotfiles ]]; then
    cd ~/.dotfiles
  else
    echo "ERROR: .dotfiles doesn't exist."
  fi
}
