#!/bin/bash

# Comando: feature start
# Cria uma nova feature a partir da branch 'prod' ou 'develop'

CONFIG_FILE=".git-helper-config"

function start_feature() {
    # Carrega configurações
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Erro: Arquivo de configuração '$CONFIG_FILE' não encontrado. Execute 'git h init' primeiro."
        exit 1
    fi
    
    source "$CONFIG_FILE"
    
    # Pergunta ao usuário o nome da feature
    echo -n "Digite o nome da nova feature (padrão: $feature_prefix<nome>): "
    read feature_name
    feature_name=${feature_name:-default}
    
    # Nome final da feature
    final_feature="feature/${feature_prefix}${feature_name}"
    
    # Verifica se a branch base existe
    base_branch=${prod_branch:-main}
    if ! branch_exists "$base_branch"; then
        echo "Aviso: Branch '$base_branch' não encontrada. Usando 'develop' como base."
        base_branch="develop"
    fi
    
    # Verifica se a branch base existe agora
    if ! branch_exists "$base_branch"; then
        echo "Erro: Nenhuma branch base válida encontrada ('prod' ou 'develop')."
        exit 1
    fi
    
    # Atualiza a branch base
    echo "Atualizando a branch base '$base_branch' da origin..."
    git fetch origin "$base_branch"
    git checkout "$base_branch"
    git pull origin "$base_branch"
    
    # Cria a nova feature
    echo "Criando a nova branch de feature: $final_feature"
    git checkout -b "$final_feature"
    
    echo "Feature '$final_feature' criada com sucesso a partir de '$base_branch'!"
}
