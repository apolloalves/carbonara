#!/bin/bash
# Adicione os comandos que deseja executar aqui
SOUND="/usr/share/sounds/freedesktop/stereo/service-logout.oga"

paplay "$SOUND" &
notify-send -u critical -t 0 "Pipewire Service Restarted"

echo "$(date) - Alsamixer foi restaurado!" >> ~/Pipewire/alsamixer.log
sudo alsactl restore


echo "$(date) - Brave foi aberto!" >> ~/Pipewire/brave.log
/home/apollo/Scripts/PipewireRestartAllServices.sh 2>/dev/null

