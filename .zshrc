#!/bin/env zsh
# vim:fileencoding=utf-8:foldmethod=marker

[[ -n $ZPROF_ENABLE ]] && zmodload zsh/zprof

#: exports {{{
#
# add jdk to path
export BREW_PREFIX=$(brew --prefix)

export JAVA_HOME="$BREW_PREFIX/Cellar/openjdk/21.0.2/"
export -U PATH="$JAVA_HOME/bin:$PATH"
export -U PATH="$BREW_PREFIX/opt/llvm/bin/:$PATH"
export -U PATH="$PATH:$HOME/.local/share/bob/nvim-bin/"
export -U PATH="$PATH:$HOME/.local/bin/"
export -U PATH="$PATH:$HOME/.local/scripts/"
export -U PATH="$PATH:$BREW_PREFIX/bin/"
export -U PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"

export RUST_CODE=~/Documents/rust_code

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

export SPARK_HOME=$HOME/spark/
export -U PATH="$SPARK_HOME/bin:$PATH"
export PYSPARK_PYTHON="python"
export PYSPARK_DRIVER_PYTHON="ptpython"
export -U PYTHONPATH=$HOME/spark/python/
export SPARK_VERSION="3.5.1"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export VAULT_ADDR="http://127.0.0.1:8200"
export VIRTUAL_ENV="$(which python)"
export EDITOR='nvim'
export VISUAL='nvim'
export RANGER_LOAD_DEFAULT_RC=FALSE
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#78a9ff,bg=none,bold"

export GOPATH="$HOME/go"
export -U PATH="$PATH:$GOPATH/bin"

#: }}}

#: aliases {{{

alias wisdom="fortune | cowsay | lolcat"
alias cl='clear'
alias e='exa -lah'
alias ru="$RUST_CODE"
# alias n="~/.local/share/neovim/bin/nvim"
alias n="nvim"
alias nv="$BREW_PREFIX/Cellar/neovide/0.12.2/bin/neovide --frame none --maximized"
alias v="$BREW_PREFIX/bin/vim"
alias lazygit='LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml" lazygit'
alias lg="lazygit"
alias ptpython="ptpython --config-file ~/dotfiles/ptpython/config.py"
alias cn="c && n ."
alias sz="source ~/.zshrc"
alias nz="n  ~/.zshrc"
alias nf='nvim --headless "+call firenvim#install(0) | q"'
alias rr="ranger"
alias tldrf="tldr --list | fzf --preview 'tldr {1}' --preview-window=right,70% | uniq -u | xargs tldr"

alias emd="emacs --daemon"
alias emc="emacsclient -n -c -a 'emacs' ."


alias tmx="~/.local/scripts/tmux_env.sh"
alias snowsql=/Applications/SnowSQL.app/Contents/MacOS/snowsql

alias gwl="git worktree list"
alias gwf="git fetch --all"

alias ctags="$BREW_PREFIX/Cellar/ctags/5.8_2/bin/ctags"

pomo() {
    timer $1 && osascript -e "display notification \"☕\" with title \"Timer up!\" subtitle \"$1 has / have passed\" sound name \"Crystal\""
}

alias wo="pomo 45m"
alias rs="pomo 15m"

#: }}}

#: functions {{{

plugins=(vi-mode zsh-autosuggestions)

options() {
    PLUGIN_PATH="$HOME/.oh-my-zsh/plugins/"
    for plugin in $plugins; do
        echo "\n\nPlugin: $plugin";
        grep -r "^function \w*" $PLUGIN_PATH$plugin \
            | awk '{print $2}' \
            | sed 's/()//' \
            | tr '\n' ', ' \
            | grep "$1" ||  echo;
        grep -r "^alias" $PLUGIN_PATH$plugin \
            | awk 'BEGIN {FS="alias ";}{print $2}' \
            | grep "$1" ||  echo;
            #| awk '{print $2, $3}' #| sed 's/=.*//' |  tr '\n' ', '
    done
}

tp() {
    ping creedthoughtsgov.com
}

git-fshow() {
    local g=(
        git log
        --graph
        --format='%C(auto)%h%d %s %C(white)%C(bold)%cr'
        --color=always
        "$@"
    )

    local fzf=(
        fzf
        --ansi
        --reverse
        --tiebreak=index
        --no-sort
        --bind=ctrl-s:toggle-sort
        --preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}'
    )
    $g | $fzf
}

random_choice() {
    echo $(($RANDOM % ($2 - $1 + 1) + $1))
}

br() {
    local cmd cmd_file code
    cmd_file=$(mktemp)
    if broot --outcmd "$cmd_file" "$@"; then
        cmd=$(<"$cmd_file")
        command rm -f "$cmd_file"
        eval "$cmd"
    else
        code=$?
        command rm -f "$cmd_file"
        return "$code"
    fi
}

#: }}}

#: source stuff {{{

eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

# NOTE: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="refined" # set by `omz`

source $ZSH/oh-my-zsh.sh
source $BREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source "$HOME/.local/lib/zsh-autoenv/init.zsh"

[[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -s ~/.luaver/luaver ] && . ~/.luaver/luaver >> /dev/null
luaver use 5.1 >> /dev/null
luaver use-luarocks 2.3.0 >> /dev/null
eval "$(luarocks path)"

eval "$(pyenv init -)"
source "$HOME/.pyenv/versions/$(pyenv version-name)/bin/virtualenvwrapper.sh"

# if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
#     print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
#     command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
#     command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
#         print -P "%F{33} %F{34}Installation successful.%f%b" || \
#         print -P "%F{160} The clone has failed.%f%b"
# fi
#
# source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit
#
# # Load a few important annexes, without Turbo
# # (this is currently required for annexes)
# zinit light-mode for \
#     zdharma-continuum/zinit-annex-as-monitor \
#     zdharma-continuum/zinit-annex-bin-gem-node \
#     zdharma-continuum/zinit-annex-patch-dl \
#     zdharma-continuum/zinit-annex-rust
#
# zinit ice as"completion"
# zinit snippet https://github.com/dbt-labs/dbt-completion.bash/blob/master/_dbt

source ~/dotfiles/work_dots/.zshrc

#: }}}

#: misc {{{

ulimit -n 65535
ulimit -u 2047

PROMPT='%F{219}[%D{%Y-%m-%d %H:%M:%S}]%f '$PROMPT

wisdom

#: }}}

[[ -n $ZPROF_ENABLE ]] && zprof
