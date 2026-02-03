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

# Powerlevel10k theme (with fallback for terminals that don't support it)
# Use fallback if: SIMPLE_PROMPT=1, or terminal is dumb/unknown, or inside Claude Code
_use_p10k=1
[[ "$SIMPLE_PROMPT" == "1" ]] && _use_p10k=0
[[ "$TERM" == "dumb" || -z "$TERM" ]] && _use_p10k=0
[[ -n "$CLAUDE_CODE" || "$TERM_PROGRAM" == "claude-code" ]] && _use_p10k=0

if (( _use_p10k )) && [[ -r "$HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme"
  [[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
else
  # Stylish fallback prompt for terminals without p10k
  source_if_exists "$HOME/.zsh/fallback-prompt.zsh"
fi
unset _use_p10k
