#!/usr/bin/env bash

usage() {
    echo "Usage: tmux_env.sh -c code_dir -s session_name -b branch_name"
    exit 1
}

[ "$#" -ne 6 ] && usage

declare code_dir
declare session_name
declare branch_name

while [[ "$#" -gt 0 ]]
do
    case $1 in
        -c) code_dir=$2; shift ;;
        -s) session_name=$2; shift ;;
        -b) branch_name=$2; shift ;;
        *) usage
    esac
    shift
done

cd $code_dir
if [ -z $(ls -a | grep '\.git$') ]
then
    echo "$code_dir does not have a git repo"
    exit 1
fi

worktree_exists=$(git worktree list | grep "\[$branch_name\]")
if [[ -z $worktree_exists ]]
then
    if [ -z `git branch --list $branch_name` ]
    then
        git branch $branch_name master
    fi
    git worktree add .worktrees/$session_name $branch_name
fi
cd .worktrees/$session_name

tmux new-session -A -d -s $session_name
if [ "$TERM_PROGRAM" = tmux ]
then
    tmux switch -t $session_name
else
    tmux attach -t $session_name
fi
