#!/bin/bash

# Comando: init
# Inicializa um repositório Git com nomes personalizados para as branches

function init_git_project() {
    # Verifica se o Git já foi inicializado
    if [ -d ".git" ]; then
        echo "Aviso: Este repositório já foi inicializado. Continuando..."
    else
        # Inicializa o repositório Git
        echo "Inicializando repositório Git..."
        git init
    fi
    
    # Pergunta ao usuário os nomes das branches
    echo -n "Digite o nome da branch de release (padrão: release): "
    read release_branch
    release_branch=${release_branch:-release} # Define o padrão se estiver vazio
    
    echo -n "Digite o nome da branch de produção (padrão: prod): "
    read prod_branch
    prod_branch=${prod_branch:-prod}
    
    echo -n "Digite o nome da branch de desenvolvimento (padrão: develop): "
    read develop_branch
    develop_branch=${develop_branch:-develop}
    
    # Criação das branches
    create_branch "$release_branch"
    create_branch "$prod_branch"
    create_branch "$develop_branch"
    
    echo "Configuração concluída! Branches '$release_branch', '$prod_branch' e '$develop_branch' verificadas/criadas."
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
