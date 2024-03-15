#!/usr/bin/env bash

set -e

if [ "$#" -ne 3 ]; then
    echo "Usage: clone_bare_repo.sh <dir> <url> <branch>"
    exit 1
fi

cd "$1" && git clone --bare "$2"
cd "$(basename "$2")" && mkdir code

git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch --all

git worktree add "code/$3" "$3"
