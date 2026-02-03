# Fix interop error that can occur in VS Code terminal on WSL2
fix_wsl2_interop() {
  for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
    if [[ -e "/run/WSL/${i}_interop" ]]; then
      export WSL_INTEROP="/run/WSL/${i}_interop"
    fi
  done
}
