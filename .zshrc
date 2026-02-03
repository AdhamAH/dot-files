# --------------------------------------------------------------------------
# Antigen Configuration
# --------------------------------------------------------------------------

# Load Antigen
source $(brew --prefix)/share/antigen/antigen.zsh

# Load Oh-My-Zsh library (Antigen will handle sourcing oh-my-zsh.sh)
antigen use oh-my-zsh

# --------------------------------------------------------------------------
# Oh My Zsh Settings (Set BEFORE antigen apply)
# --------------------------------------------------------------------------

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# --------------------------------------------------------------------------
# Antigen Bundles (Theme & Plugins)
# --------------------------------------------------------------------------

# Load the theme
antigen theme agnoster

# Load plugins (git is included by oh-my-zsh bundle)
# antigen bundle git # No need to list 'git' explicitly when using 'antigen use oh-my-zsh'
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search # Added from your old config
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle fdellwing/zsh-bat
antigen bundle marlonrichert/zsh-autocomplete@main # zsh-autocomplete

# Apply antigen configuration (Downloads and sources themes/plugins)
antigen apply

# --------------------------------------------------------------------------
# Custom Prompt Functions (Define AFTER antigen apply)
# --------------------------------------------------------------------------
# These override or supplement the theme's functions

# Custom prompt_dir from your old config
# prompt_dir() {
#   prompt_segment blue $CURRENT_FG '%1~'
# }

# Custom prompt_context from your old config
# prompt_context() {
#   # Show user@host if not default user or on SSH
#   if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
#     prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
#   fi
# }

# Custom main prompt function to add a newline (from Antigen example)
# This calls the theme's functions like prompt_dir, prompt_context, prompt_git etc.
prompt_agnoster_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  prompt_status
#   prompt_virtualenv # Uncomment if you use python virtualenvs
  prompt_aws # Add other segments provided by agnoster/plugins if needed
  prompt_context # Uses your custom function above
  prompt_dir     # Uses your custom function above
  prompt_git
#   prompt_bzr
#   prompt_hg
  prompt_newline # Add the newline
  prompt_end
}

# Function to add the newline segment (from Antigen example)
prompt_newline() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{%f%}"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
  echo # This actually prints the newline
}

# Tell Zsh to use your custom prompt build function (from Antigen example)
build_prompt() {
  prompt_agnoster_main
}

# --------------------------------------------------------------------------
# Environment Variables and Paths
# --------------------------------------------------------------------------

# Standard paths (optional, uncomment if needed)
# export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Pipx path
export PATH="$PATH:$HOME/.local/bin"

# MySQL path
export PATH="$PATH:/usr/local/mysql/bin/"

# LM Studio CLI path (Using the path from your old config, corrected with $HOME)
# Make sure this is the correct location on your Mac
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# User configuration (optional, uncomment if needed)
# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8

# Preferred editor (optional, uncomment/modify if needed)
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim' # Or 'code', 'nano', etc.
# fi

# Compilation flags (optional, uncomment if needed on Apple Silicon/Intel)
# export ARCHFLAGS="-arch x86_64" # Or "-arch arm64"

# --------------------------------------------------------------------------
# NVM (Node Version Manager)
# --------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
# Ensure the path to nvm.sh is correct for your Homebrew installation
# On Apple Silicon Macs, Homebrew is usually in /opt/homebrew
# On Intel Macs, Homebrew is usually in /usr/local
# The following lines attempt to load from the common Apple Silicon path:
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# If the above doesn't work (e.g., on Intel), try this path:
# [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"
# [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"


# --------------------------------------------------------------------------
# Other Customizations
# --------------------------------------------------------------------------

# Source Brew Zsh completions (useful for commands installed via brew)
# Place this AFTER antigen apply to ensure compinit is handled correctly
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    # Re-run compinit only if needed, Oh My Zsh/Antigen usually handle it.
    # Check if compinit is already loaded to avoid errors/slowdown.
    # if ! command -v compinit >/dev/null 2>&1; then
    #   autoload -Uz compinit
    #   compinit
    # fi
fi

# Fabric bootstrap
# if [ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ]; then
#   . "$HOME/.config/fabric/fabric-bootstrap.inc"
# fi

# Aliases should generally go into ~/.oh-my-zsh/custom/aliases.zsh
# or another file sourced here, e.g.:
# if [ -f "$HOME/.zsh_aliases" ]; then
#   source "$HOME/.zsh_aliases"
# fi



# --- End of .zshrc ---

# Added by Windsurf
export PATH="/Users/adham/.codeium/windsurf/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/share/flutter/bin:$PATH"

# Added by Antigravity
export PATH="/Users/adham/.antigravity/antigravity/bin:$PATH"

# opencode
export PATH=/Users/adham/.opencode/bin:$PATH
export PATH="$PATH:/Users/adham/.dotnet/tools" export PATH="/opt/homebrew/opt/php@8.2/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.2/sbin:$PATH"
