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

function prj() {
  if [[ $# -gt 0 ]]; then
    if [[ -d "$1" ]]; then
      projects
      cd "$1"
    else
      errecho "ERROR: $1 no such directory"
    fi
  else
    if command -v sk > /dev/null; then
       dest="$(find $PROJECTS_DIR -maxdepth 3 -type d | sk)"
       cd "$dest"
    else
      errecho "ERROR: skim is not installed"
    fi
  fi
}
