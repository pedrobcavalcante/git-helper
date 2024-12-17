#!/bin/bash

# Comando: init
# Inicializa um repositório Git com nomes personalizados para as branches

CONFIG_FILE=".git-helper-config"

function init_git_project() {
    # Verifica se o Git já foi inicializado
    if [ -d ".git" ]; then
        echo "Aviso: Este repositório já foi inicializado. Continuando..."
    else
        # Inicializa o repositório Git
        echo "Inicializando repositório Git..."
        git init
    fi
    
    # Pergunta ao usuário o nome das branches
    echo -n "Digite o nome da branch de release (somente salva, padrão: release): "
    read release_branch
    release_branch=${release_branch:-release}
    
    echo -n "Digite o nome da branch de produção (padrão: main): "
    read prod_branch
    prod_branch=${prod_branch:-main}
    
    echo -n "Digite o nome da branch de desenvolvimento (padrão: develop): "
    read develop_branch
    develop_branch=${develop_branch:-develop}
    
    # Salva o nome da branch de release no arquivo de configuração
    echo "Salvando configurações..."
    echo "release_branch=$release_branch" > "$CONFIG_FILE"
    
    # Criação das branches necessárias
    create_branch "$prod_branch"
    create_branch "$develop_branch"
    
    echo "Configuração concluída! Branches '$prod_branch' e '$develop_branch' verificadas/criadas."
    echo "O nome da branch de release foi salvo em '$CONFIG_FILE'."
}

# Função para criar branches (com verificação de existência)
function create_branch() {
    local branch_name=$1
    
    echo "Verificando branch: $branch_name"
    if branch_exists "$branch_name"; then
        echo "Aviso: A branch '$branch_name' já existe. Pulando..."
    else
        echo "Criando branch: $branch_name"
        git checkout -b "$branch_name"
    fi
    
    # Volta para a branch principal (main ou master)
    git checkout main 2>/dev/null || git checkout master 2>/dev/null
}
