autoload -Uz add-zsh-hook

_auto_venv() {
  local dir=$PWD target=""

  # Child shells inherit virtualenv variables and PATH, but not deactivate.
  # Clear that stale state so this shell can activate its own environment.
  if [[ -n "${VIRTUAL_ENV:-}" ]] && (( ! $+functions[deactivate] )); then
    path=("${(@)path:#${(b)VIRTUAL_ENV}/bin}")
    unset VIRTUAL_ENV VIRTUAL_ENV_PROMPT _auto_venv_path
  fi

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
    source "$target/bin/activate" && _auto_venv_path=$target
  fi
}

add-zsh-hook chpwd _auto_venv
_auto_venv
