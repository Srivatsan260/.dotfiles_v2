autoload -Uz add-zsh-hook

_auto_venv() {
  local dir=$PWD target=""

  while true; do
    if [[ -f "$dir/.venv/bin/activate" ]]; then
      target="$dir/.venv"
      break
    fi
    [[ "$dir" == / ]] && break
    dir=${dir:h}
  done

  [[ "$target" == "${VIRTUAL_ENV:-}" ]] && return

  # Only deactivate environments this hook activated.
  if [[ -n "$_auto_venv_path" &&
        "${VIRTUAL_ENV:-}" == "$_auto_venv_path" ]]; then
    deactivate
    unset _auto_venv_path
  fi

  # Leave manually activated environments alone.
  if [[ -n "$target" && -z "${VIRTUAL_ENV:-}" ]]; then
    source "$target/bin/activate"
    _auto_venv_path=$target
  fi
}

add-zsh-hook chpwd _auto_venv
_auto_venv
