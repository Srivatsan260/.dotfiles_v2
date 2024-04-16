#!/usr/bin/env bash

set -e

read -p "Enter git url: " git_url
if [ -z "$git_url" ]; then
    echo "No git url provided"
    exit 1
fi

read -p "Enter the path to clone the repo: " repo_dir
if [ -z "$repo_dir" ]; then
    echo "No repo path provided"
    exit 1
fi

read -p "Enter branch name: " branch_name
if [ -z "$branch_name" ]; then
    echo "No branch name provided, assuming main"
    branch_name="main"
fi

read -p "Enter git user name (default is global user name): " git_user_name
if [ -z "$git_user_name" ]; then
    echo "No git user name provided, assuming global user name"
    git_user_name="$(git config --global user.name)"
fi

read -p "Enter git user email (default is global user email): " git_user_email
if [ -z "$git_user_email" ]; then
    echo "No git user email provided, assuming global user email"
    git_user_email="$(git config --global user.email)"
fi

cd "$repo_dir" && git clone --bare "$git_url"
cd "$(basename "$git_url")" && mkdir code


git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch --all

git worktree add "code/$branch_name" "$branch_name"

git config user.name "$git_user_name"
git config user.email "$git_user_email"
