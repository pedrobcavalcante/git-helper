#!/bin/bash

CONFIG_FILE=".git-helper-config"

function start_feature() {
    # Carrega configurações
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Erro: Arquivo de configuração '$CONFIG_FILE' não encontrado. Execute 'git h init' primeiro."
        exit 1
    fi
    source "$CONFIG_FILE"

    # Usa o argumento fornecido, se existir
    if [ -n "$1" ]; then
        feature_name="$1"
    else
        # Pergunta o nome da feature apenas se não foi fornecido
        echo -n "Digite o nome da nova feature (padrão: ${feature_prefix}nova-feature): "
        read feature_name
        feature_name=${feature_name:-nova-feature}
    fi

    # Remove prefixo duplicado, se existir
    if [[ "$feature_name" == "${feature_prefix}"* ]]; then
        final_feature="$feature_name"
    else
        final_feature="${feature_prefix}${feature_name}"
    fi

    # Define a branch base
    base_branch="$prod_branch"
    if ! branch_exists "$base_branch"; then
        echo "Aviso: Branch '$base_branch' não encontrada. Usando '$develop_branch' como base."
        base_branch="$develop_branch"
    fi

    if ! branch_exists "$base_branch"; then
        echo "Erro: Nenhuma branch base válida encontrada ('prod' ou 'develop')."
        exit 1
    fi

    # Atualiza a branch base
    echo "Atualizando a branch base '$base_branch' da origin..."
    git fetch origin "$base_branch" 2>/dev/null
    git checkout "$base_branch"
    git pull origin "$base_branch"

    # Cria a nova branch de feature
    echo "Criando a nova branch de feature: $final_feature"
    git checkout -b "$final_feature"

    echo "Feature '$final_feature' criada com sucesso a partir de '$base_branch'!"
}
