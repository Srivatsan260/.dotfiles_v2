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

# pyenv
export PATH="$HOME/.pyenv/versions/3.9.11/bin/:$PATH"
export VIRTUALENVWRAPPER_PYTHON=~/.pyenv/versions/3.9.11/bin/python
source ~/.pyenv/versions/3.9.11/bin/virtualenvwrapper.sh

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

#: }}}

#: functions {{{

# code() {
#     VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;
# }

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

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="refined" # set by `omz`

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source "$HOME/.local/lib/zsh-autoenv/init.zsh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#: source project-specific config {{{

source ~/dotfiles/work_dots/.zshrc

[[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

#: }}}

# enable vi mode in zsh
bindkey -v

# eval $(starship init zsh)

#: }}}
