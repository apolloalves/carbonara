#!/bin/bash

# Definir placa de som principal (ajuste conforme necessário)
CARD=$(aplay -l | grep -m1 'card' | awk '{print $2}' | tr -d ':')

echo "Configuração de áudio para graves no ALSA - Placa de Som: hw:$CARD"

# Ajustar os níveis no alsamixer
amixer -c $CARD set Master 76% unmute
amixer -c $CARD set Front 96% unmute
amixer -c $CARD set PCM 95% unmute
amixer -c $CARD set LFE 67% unmute
amixer -c $CARD set Center 70% unmute
amixer -c $CARD set Bass Red 94% unmute
amixer -c $CARD set Surround 82% unmute

# Salvar as configurações
sudo alsactl store
sudo alsactl restore

echo "Configuração concluída! Teste seu áudio para verificar os graves."

# Teste de som opcional
#read -p "Deseja testar os graves agora? (s/n): " resp
#if [[ "$resp" =~ ^[Ss]$ ]]; then
 #   speaker-test -t sine -f 50
#fi

