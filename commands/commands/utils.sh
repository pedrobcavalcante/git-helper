#!/bin/bash

# Função para verificar se uma branch existe
function branch_exists() {
    local branch=$1
    git show-ref --verify --quiet refs/heads/"$branch"
}
