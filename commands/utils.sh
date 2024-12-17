#!/bin/bash

# Função para verificar se uma branch existe
function branch_exists() {
    local branch=$1
    git show-ref --verify --quiet refs/heads/"$branch"
}

# Função para verificar se uma branch remota existe
function remote_branch_exists() {
    local remote=$1
    local branch=$2
    git ls-remote --exit-code --heads "$remote" "$branch" > /dev/null 2>&1
}
