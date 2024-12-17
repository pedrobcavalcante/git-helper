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
    
    # Definição da branch base em ordem de prioridade
    if remote_branch_exists "origin" "$prod_branch"; then
        base_branch="$prod_branch"
        remote_base=true
        elif branch_exists "$prod_branch"; then
        base_branch="$prod_branch"
        elif remote_branch_exists "origin" "$develop_branch"; then
        base_branch="$develop_branch"
        remote_base=true
        elif branch_exists "$develop_branch"; then
        base_branch="$develop_branch"
    else
        echo "Erro: Nenhuma branch base válida encontrada ('main' ou 'develop', remota ou local)."
        exit 1
    fi
    
    # Atualiza a branch base, se for remota
    echo "Atualizando a branch base '$base_branch'..."
    if [ "$remote_base" = true ]; then
        git fetch origin "$base_branch"
    fi
    git checkout "$base_branch"
    git pull origin "$base_branch" 2>/dev/null || echo "Branch local '$base_branch' atualizada."
    
    # Cria a nova branch de feature
    echo "Criando a nova branch de feature: $final_feature"
    git checkout -b "$final_feature"
    
    echo "Feature '$final_feature' criada com sucesso a partir de '$base_branch'!"
}

