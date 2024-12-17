#!/bin/bash

# Arquivo principal: git-helper.sh
# Ponto de entrada para os comandos do Git Helper

# Carrega os comandos e funções utilitárias
source "$(dirname "$0")/commands/init.sh"
source "$(dirname "$0")/commands/utils.sh"

# Função principal para gerenciar os comandos
function main() {
    case "$1" in
        init)
            init_git_project
        ;;
        *)
            echo "Uso: git h [comando]"
            echo "Comandos disponíveis:"
            echo "  init   Inicializa um repositório Git com branches configuradas"
            exit 1
        ;;
    esac
}

main "$@"
