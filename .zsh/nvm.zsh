# NVM lazy load
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

_nvm_sh=""
if [ -s "$NVM_DIR/nvm.sh" ]; then
  _nvm_sh="$NVM_DIR/nvm.sh"
elif command -v brew >/dev/null 2>&1; then
  _brew_nvm="$(brew --prefix 2>/dev/null)/opt/nvm/nvm.sh"
  [ -s "$_brew_nvm" ] && _nvm_sh="$_brew_nvm"
fi

if [ -n "$_nvm_sh" ]; then
  _nvm_root="${_nvm_sh%/nvm.sh}"
  [ -s "$_nvm_root/etc/bash_completion.d/nvm" ] && . "$_nvm_root/etc/bash_completion.d/nvm"
  alias nvm='unalias nvm node npm && . "$_nvm_sh" && nvm'
  alias node='unalias nvm node npm && . "$_nvm_sh" && node'
  alias npm='unalias nvm node npm && . "$_nvm_sh" && npm'
fi
unset _nvm_sh _nvm_root _brew_nvm
