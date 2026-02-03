# Fallback prompt when Powerlevel10k isn't available
# Uses standard ANSI colors and ASCII - works in any terminal

# Git info function
_fallback_git_info() {
  # Check if in git repo
  git rev-parse --is-inside-work-tree &>/dev/null 2>&1 || return

  local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  local status_icons=""

  # Check git status
  local git_status=$(git status --porcelain 2>/dev/null)
  [[ -n "$git_status" ]] && status_icons+=" %F{214}*%f"

  # Check for unpushed commits
  local unpushed=$(git log @{u}.. --oneline 2>/dev/null | wc -l | tr -d ' ')
  (( unpushed > 0 )) && status_icons+=" %F{117}↑${unpushed}%f"

  # Check for unpulled commits
  local unpulled=$(git log ..@{u} --oneline 2>/dev/null | wc -l | tr -d ' ')
  (( unpulled > 0 )) && status_icons+=" %F{117}↓${unpulled}%f"

  echo " %F{245}(%f%F{213}${branch}%f${status_icons}%F{245})%f"
}

# Shortened path (like p10k truncation)
_fallback_short_path() {
  local pwd_display="${PWD/#$HOME/~}"

  # If path is long, truncate middle directories
  if [[ ${#pwd_display} -gt 45 ]]; then
    local parts=("${(@s:/:)pwd_display}")
    local len=${#parts[@]}
    if (( len > 4 )); then
      pwd_display="${parts[1]}/.."
      pwd_display+="/${parts[-2]}/${parts[-1]}"
    fi
  fi

  echo "$pwd_display"
}

# Set up the fallback prompt
_setup_fallback_prompt() {
  setopt PROMPT_SUBST

  # Color palette (256-color compatible)
  local c_user="%F{114}"       # soft green
  local c_at="%F{245}"         # gray
  local c_host="%F{180}"       # soft orange/tan
  local c_path="%F{75}"        # soft blue
  local c_frame="%F{240}"      # dark gray for frame
  local c_reset="%f"

  # Prompt char: green › on success, red › on error
  local prompt_char="%(?.%F{114}›%f.%F{203}›%f) "

  # Two-line prompt with frame
  PROMPT=''
  PROMPT+=$'\n'                                                    # blank line
  PROMPT+="${c_frame}┌─[${c_reset}"                               # frame start
  PROMPT+="${c_user}%n${c_reset}"                                  # username
  PROMPT+="${c_at}@${c_reset}"                                     # @
  PROMPT+="${c_host}%m${c_reset}"                                  # hostname
  PROMPT+="${c_frame}]─[${c_reset}"                               # separator
  PROMPT+="${c_path}"'$(_fallback_short_path)'"${c_reset}"        # path
  PROMPT+="${c_frame}]${c_reset}"                                 # close bracket
  PROMPT+='$(_fallback_git_info)'                                 # git info
  PROMPT+=$'\n'                                                    # newline
  PROMPT+="${c_frame}└─${c_reset}"                                # frame end
  PROMPT+="${prompt_char}"                                         # prompt char

  # Right prompt: last command duration + time
  RPROMPT="${c_frame}[${c_reset}%F{245}%T${c_reset}${c_frame}]${c_reset}"
}

_setup_fallback_prompt
