#!/bin/bash

# Arquivo principal: git-helper.sh
# Este script gerencia os subcomandos do Git Helper

# Carrega os subcomandos
source "$(dirname "$0")/commands/init.sh"
source "$(dirname "$0")/commands/feature.sh"
source "$(dirname "$0")/commands/utils.sh"

# Função principal para gerenciar comandos
function main() {
    case "$1" in
        init)
            init_git_project
        ;;
        feature)
            feature "${@:2}"
        ;;
        *)
            echo "Uso: git h [subcomando]"
            echo "Subcomandos disponíveis:"
            echo "  init              Inicializa um repositório Git com configurações básicas"
            echo "  feature start     Cria uma nova feature a partir de 'prod' ou 'develop'"
            exit 1
        ;;
    esac
}

# Gerencia o subcomando 'feature'
function feature() {
    case "$1" in
        start)
            start_feature "${@:2}"
        ;;
        *)
            echo "Uso: git h feature [subcomando]"
            echo "Subcomandos disponíveis:"
            echo "  start             Cria uma nova feature a partir de 'prod' ou 'develop'"
            exit 1
        ;;
    esac
}

main "$@"
