#!/bin/bash

SCRIPT="/home/apollo/Scripts/BraveScript.sh"
LOCKFILE="/tmp/brave_script.lock"

# Aguarda a PRIMEIRA janela do Brave normal abrir (ignora YouTube Music)
while ! xdotool search --onlyvisible --class "Brave-browser" > /dev/null 2>&1; do
    sleep 2
done

# Se já rodou antes, sai
if [ -f "$LOCKFILE" ]; then
    exit 0
fi

# Cria o lockfile para evitar reexecução
touch "$LOCKFILE"

# Executa o script
$SCRIPT
