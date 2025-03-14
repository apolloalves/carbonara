#!/bin/bash
clear
echo "Restarting PipeWire and WirePlumber services..."

systemctl --user restart --now wireplumber.service
systemctl --user restart --now pipewire.service

sleep 5
printf "\nPipeWire and WirePlumber services restarted!\n"

# Verifica se o script PipewireCheckServices.sh existe e executa
if [[ -x "$(command -v PipewireCheckServices.sh)" ]]; then
    PipewireCheckServices.sh
    echo "Pipewire service started!"
else
    echo "PipewireCheckServices.sh not found or not executable"
fi

