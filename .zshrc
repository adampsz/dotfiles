# Clone zinit if it's not installed
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

# Load zinit
source "$HOME/.zinit/bin/zinit.zsh"

# Load a few important annexes, without Turbo
zinit light-mode for \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node


# Load powerlevel10k prompt
zinit light-mode for \
  romkatv/powerlevel10k


# Load syntax highlighting, autosuggestions and completions
zstyle :plugin:history-search-multi-word reset-prompt-protect 1

zinit wait lucid light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
  atload'_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

# Oh my!
# Load important oh-my-zsh files
# completion.zsh - configures completion
# history.zsh - saves history in ~/.zsh_history, ignores duplicates etc
# key-bindings.zsh - makes delete key work
COMPLETION_WAITING_DOTS=true
zinit light-mode for \
  OMZL::completion.zsh \
  OMZL::history.zsh \
  OMZL::key-bindings.zsh

# Load less important zsh plugins
# directories.zsh - allows traversing using `...`, `1`, etc
zinit wait lucid light-mode for \
  OMZL::directories.zsh \
  OMZL::theme-and-appearance.zsh

# Load various zsh plugins after some time
zinit wait'1' lucid light-mode for \
  OMZP::command-not-found \
  OMZP::common-aliases \
  OMZP::git \
  OMZP::sudo \
  zdharma/history-search-multi-word \
  zpm-zsh/undollar \
  hlissner/zsh-autopair \
  MichaelAquilina/zsh-you-should-use \
  if'[ ! -f /bin/busybox ]' zpm-zsh/colorize

# Load environment-specific plugins
zinit wait'2' lucid light-mode for \
  has'code' OMZP::vscode \
  has'docker' OMZ::plugins/docker/_docker \
  has'docker-compose' OMZP::docker-compose \
  has'yarn' OMZP::yarn \
  has'poetry' atpull'%atclone' atclone'poetry completions zsh > _poetry' MichaelAquilina/zsh-autoswitch-virtualenv \
  if'[ -f /etc/arch-release ]' OMZP::archlinux \
  if'[ -f /etc/debian_version ]' OMZP::debian \
  if'[ -n "$(grep -s ^NAME /etc/os-release | grep Ubuntu)" ]' OMZP::ubuntu \
  has'dnf' OMZP::dnf \
  has'yum' OMZP::yum \
  has'zypper' OMZP::suse

# Add various folders to path
[ -d "$HOME/bin" ] && path+=("$HOME/bin")
[ -d "$HOME/.yarn" ] && path+=("$HOME/.yarn/bin")
[ -d "$HOME/.local/bin" ] && path+=("$HOME/.local/bin")

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Don't start with error
true
