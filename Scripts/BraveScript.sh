#!/bin/bash
# Adicione os comandos que deseja executar aqui

echo "$(date) - Alsamixer foi restaurado!" >> ~/alsamixerLog.log
sudo alsactl restore


echo "$(date) - Brave foi aberto!" >> ~/braveLog.log
/home/apollo/Scripts/PipewireRestartAllServices.sh 2>/dev/null

