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

  _nvm_load() {
    unfunction nvm node npm 2>/dev/null
    unalias nvm node npm 2>/dev/null
    . "$_nvm_sh"
  }

  nvm() { _nvm_load; nvm "$@"; }
  node() { _nvm_load; node "$@"; }
  npm() { _nvm_load; npm "$@"; }

  # Ensure a default Node is available on new shells.
  # Set NVM_LAZY_LOAD=1 to keep lazy loading behavior.
  if [[ -o interactive ]] && [[ -z "${NVM_LAZY_LOAD:-}" ]]; then
    unalias nvm node npm 2>/dev/null
    . "$_nvm_sh"
    nvm use --silent default >/dev/null 2>&1 || true
  fi
fi
unset _nvm_sh _nvm_root _brew_nvm
