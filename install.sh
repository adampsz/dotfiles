#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

BOLD="$(echo -e "\e[1m")"
BLUE="$(echo -e "\e[34m")"
RESET="$(echo -e "\e[0m")"

function info {
  echo "${BOLD}${BLUE}info:${RESET}" "$@"
}

function yn {
  read -p "${BOLD}${BLUE}::${RESET}${BOLD} $@ ${RESET}[Y/n] " ans
  case "$ans" in 
    y|Y ) return 0;;
    * ) return 1;;
  esac
}

function show_opt_deps {
  info "Optional dependencies for $1:"
  shift
  for dep in "$@"; do
    echo "  " "$dep"
  done
}

function copy_file {
  echo

  local file="$1"
  local src="$DIR/$file"
  local target="$HOME/$file"

  if [ -e "$target" ] && ! yn "Overwrite $file?"; then
    return 1
  fi

  mkdir -p "$(dirname "$target")"
  cp "$src" "$target"
}

total=1


# Zshrc

function copy_zshrc {
  if ! command -v zsh >/dev/null 2>&1; then
    warn "zsh seems not to be installed on your system."
    yn "Copy .zshrc file anyway?" || return 1
  fi

  copy_file .zshrc || return 1
}

function copy_p10k {
  if ! command -v zsh >/dev/null 2>&1; then
    return 1
  fi

  copy_file .p10k.zsh || return 1
}

copy_zshrc \
  && info "installed .zshrc" \
  && show_opt_deps "zshrc" \
    "command-not-found or pkgfile - for \"Command not found\" functionality" \
    "grc - for more colorful program outputs" \
  || info "skipped .zshrc"

copy_p10k \
  && info "installed .p10k.zsh" \
  && info "to reconfigure prompt, type \`p10k configure\`" \
  || info "skipped .p10k.zsh"


