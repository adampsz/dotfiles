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


# Configure and load pure prompt
PURE_PROMPT_SYMBOL='$' # Keep classic dollar
PURE_PROMPT_VICMD_SYMBOL=':' # Very vimish
zstyle :prompt:pure:prompt:success color green

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure


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
  OMZL::directories.zsh

# Load various zsh plugins after some time
zinit wait'1' lucid light-mode for \
  OMZP::command-not-found \
  OMZP::common-aliases \
  OMZP::git \
  OMZP::sudo \
  zdharma/history-search-multi-word \
  zpm-zsh/undollar \
  src'colorize.plugin.zsh' zpm-zsh/colorize \
  hlissner/zsh-autopair \
  MichaelAquilina/zsh-you-should-use

# Load plugins for specific commands or systems
zinit light-mode has'pacman' for OMZP::archlinux
zinit light-mode has'screen' for OMZP::screen
zinit light-mode has'code' for OMZP::vscode
zinit light-mode has'yarn' for OMZP::yarn

# Add user binaries from ~/bin to path
path+=("$HOME/bin")