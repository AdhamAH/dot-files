# Common PATH helpers and entries

path_prepend() {
  for p in "$@"; do
    [[ -d "$p" ]] || continue
    case ":$PATH:" in
      *":$p:"*) ;;
      *) PATH="$p:$PATH" ;;
    esac
  done
}

path_append() {
  for p in "$@"; do
    [[ -d "$p" ]] || continue
    case ":$PATH:" in
      *":$p:"*) ;;
      *) PATH="$PATH:$p" ;;
    esac
  done
}

path_append "$HOME/.local/bin" "$HOME/.dotnet/tools" "$HOME/go/bin"

export KREW_ROOT="${KREW_ROOT:-$HOME/.krew}"
path_prepend "$KREW_ROOT/bin"
