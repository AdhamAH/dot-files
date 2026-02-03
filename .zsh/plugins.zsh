# Optional plugins (no plugin manager required)

plugins_dir="$HOME/.zsh/plugins"

source_first() {
  for f in "$@"; do
    [[ -r "$f" ]] && source "$f" && return 0
  done
  return 1
}

# zsh-autocomplete
source_first \
  "$plugins_dir/zsh-autocomplete/zsh-autocomplete.plugin.zsh" \
  /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh \
  /usr/local/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh \
  /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh \
  /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# zsh-autosuggestions
source_first \
  "$plugins_dir/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-history-substring-search
source_first \
  "$plugins_dir/zsh-history-substring-search/zsh-history-substring-search.zsh" \
  /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh \
  /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh \
  /usr/share/zsh-history-substring-search/zsh-history-substring-search.zsh \
  /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

if (( ${+functions[history-substring-search-up]} )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# zsh-you-should-use
source_first \
  "$plugins_dir/zsh-you-should-use/you-should-use.plugin.zsh" \
  /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh \
  /usr/local/share/zsh-you-should-use/you-should-use.plugin.zsh \
  /usr/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh \
  /usr/share/zsh-you-should-use/you-should-use.plugin.zsh

# zsh-bat
source_first \
  "$plugins_dir/zsh-bat/zsh-bat.plugin.zsh" \
  /opt/homebrew/share/zsh-bat/zsh-bat.plugin.zsh \
  /usr/local/share/zsh-bat/zsh-bat.plugin.zsh \
  /usr/share/zsh-bat/zsh-bat.plugin.zsh \
  /usr/share/zsh/plugins/zsh-bat/zsh-bat.plugin.zsh

# zsh-syntax-highlighting (must be last)
source_first \
  "$plugins_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
