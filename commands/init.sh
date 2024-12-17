#!/bin/bash

# Comando: init
# Inicializa um repositório Git com nomes personalizados para as branches

CONFIG_FILE=".git-helper-config"


function init_git_project() {
    echo "Inicializando o projeto Git Helper..."
    
    # Verificação se o Git já foi inicializado
    if [ -d ".git" ]; then
        echo "Aviso: Este repositório já foi inicializado. Continuando..."
    else
        git init
    fi
    
    # Pergunta ao usuário as configurações
    echo -n "Digite o prefixo padrão para features (padrão: feature/): "
    read feature_prefix
    feature_prefix=${feature_prefix:-feature/}
    
    echo -n "Digite o nome da branch de produção (padrão: main): "
    read prod_branch
    prod_branch=${prod_branch:-main}
    
    echo -n "Digite o nome da branch de desenvolvimento (padrão: develop): "
    read develop_branch
    develop_branch=${develop_branch:-develop}
    
    # Salva as configurações no arquivo
    echo "feature_prefix=$feature_prefix" > "$CONFIG_FILE"
    echo "prod_branch=$prod_branch" >> "$CONFIG_FILE"
    echo "develop_branch=$develop_branch" >> "$CONFIG_FILE"
    
    echo "Configuração concluída! Configurações salvas em '$CONFIG_FILE'."
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
