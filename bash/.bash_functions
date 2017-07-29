alias errecho='>&2 echo'

function projects() {
  if [[ -d "$PROJECTS_DIR" ]]; then
    cd "$PROJECTS_DIR"
  else
    errecho "ERROR: PROJECTS_DIR is not set or doesn't exist."
  fi
}

function dotfiles() {
  if [[ -d ~/.dotfiles ]]; then
    cd ~/.dotfiles
  else
    errecho "ERROR: .dotfiles doesn't exist."
  fi
}
