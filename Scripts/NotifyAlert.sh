#!/bin/bash

# Caminho para um som padrão do sistema (substitua se quiser outro)
SOUND="/usr/share/sounds/freedesktop/stereo/service-logout.oga"

# Toca o som (use 'paplay' se você estiver usando PipeWire/PulseAudio)
paplay "$SOUND" &

# Exibe notificação crítica que não desaparece automaticamente
notify-send -u critical -t 0 "Pipewire Service Reiniciado!"



