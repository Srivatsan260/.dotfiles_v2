#!/bin/env zsh
# vim:fileencoding=utf-8:foldmethod=marker

#: exports {{{
#
# add jdk to path
export JAVA_HOME="/opt/homebrew/Cellar/openjdk/21.0.2/"
export PATH="/opt/homebrew/Cellar/openjdk/21.0.2/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin/:$PATH"
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PYSPARK_DRIVER_PYTHON="ptpython"
export RUST_CODE=~/Documents/rust_code

[[ ":$PATH:" != ":$HOME/.local/share/neovim/bin/"* ]] && export PATH="$PATH:$HOME/.local/share/neovim/bin/"
[[ ":$PATH:" != ":$HOME/.local/bin/"* ]] && export PATH="$PATH:$HOME/.local/bin/"
[[ ":$PATH:" != ":$HOME/.local/scripts/"* ]] && export PATH="$PATH:$HOME/.local/scripts/"
export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$HOME/.local/share/neovim/bin/:$PATH"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1


export SPARK_HOME=/opt/homebrew/Cellar/apache-spark/3.5.0/libexec
export PYTHONPATH=/opt/homebrew/Cellar/apache-spark/3.5.0/libexec/python/
export SPARK_VERSION="3.5.0"

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
export PATH="$PATH:$HOME/go/bin"

#: }}}

#: aliases {{{

alias wisdom="fortune | cowsay | lolcat"
alias cl='clear'
alias e='exa -lah'
alias ru="$RUST_CODE"
# alias n="~/.local/share/neovim/bin/nvim"
alias n="nvim"
alias nv="/opt/homebrew/Cellar/neovide/0.12.2/bin/neovide --frame none --maximized"
alias v="/opt/homebrew/bin/vim"
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

alias ctags="/opt/homebrew/Cellar/ctags/5.8_2/bin/ctags"

pomo() {
    timer $1 && osascript -e "display notification \"☕\" with title \"Timer up!\" subtitle \"$1 has / have passed\" sound name \"Crystal\""
}

alias wo="pomo 45m"
alias rs="pomo 15m"

#: }}}

#: functions {{{

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

#: misc {{{

ulimit -n 65535
ulimit -u 2047

eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

# NOTE: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="refined" # set by `omz`

plugins=(vi-mode zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source "$HOME/.local/lib/zsh-autoenv/init.zsh"

#: source project-specific config {{{

source ~/dotfiles/work_dots/.zshrc

[[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

eval "$(pyenv init -)"
source "$HOME/.pyenv/versions/$(pyenv version-name)/bin/virtualenvwrapper.sh"

#: }}}

# enable vi mode in zsh
bindkey -v

# eval $(starship init zsh)

wisdom

#: }}}
