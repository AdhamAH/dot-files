# ~/.zshrc (managed by yadm)

# Only run in interactive shells
[[ -o interactive ]] || return

# Powerlevel10k instant prompt (disable by default to avoid partial loads)
P10K_INSTANT_PROMPT=${P10K_INSTANT_PROMPT:-0}
if [[ "$P10K_INSTANT_PROMPT" == "1" ]] && [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Helper
source_if_exists() {
  [[ -r "$1" ]] && source "$1"
}

# History and options
setopt AUTO_CD
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=10000
SAVEHIST=10000

# Paths (common) and OS-specific overrides (yadm alternates)
source_if_exists "$HOME/.zsh/paths.zsh"
source_if_exists "$HOME/.zsh/os.zsh"

# Completion
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump"

# Plugins (optional)
source_if_exists "$HOME/.zsh/plugins.zsh"

# User config
source_if_exists "$HOME/.zsh/aliases.zsh"
source_if_exists "$HOME/.zsh/functions.zsh"
source_if_exists "$HOME/.zsh/nvm.zsh"
source_if_exists "$HOME/.zsh/wsl2fix.zsh"
source_if_exists "$HOME/.zsh/goto.zsh"
source_if_exists "$HOME/.zsh/local.zsh"

# direnv
if (( ${+commands[direnv]} )); then
  eval "$(direnv hook zsh)"
fi

# zoxide
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# Powerlevel10k theme
if [[ -r "$HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme"
fi
[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
