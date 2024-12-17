#!/bin/bash

# Script de instalação para o Git Helper
# Ele configura o Git alias e ajusta permissões dos arquivos necessários

# Caminho absoluto para o diretório do script
INSTALL_DIR=$(pwd)
MAIN_SCRIPT="$INSTALL_DIR/git-helper.sh"

# Verificação se o arquivo principal existe
if [ ! -f "$MAIN_SCRIPT" ]; then
    echo "Erro: O arquivo principal 'git-helper.sh' não foi encontrado no diretório atual."
    exit 1
fi

# Configura o alias no Git
echo "Configurando alias 'git h'..."
git config --global alias.h "!bash $MAIN_SCRIPT"

# Dá permissão de execução ao script principal e comandos
echo "Definindo permissões executáveis..."
chmod +x "$MAIN_SCRIPT"
chmod +x $INSTALL_DIR/commands/*.sh

echo "Instalação concluída com sucesso!"
echo "Agora você pode usar 'git h init' para inicializar o repositório."
