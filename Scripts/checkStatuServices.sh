#!/bin/bash

FAILED=()
RECOVERED=()

STATE_FILE="/tmp/.service_states"
SOUND="/usr/share/sounds/freedesktop/stereo/service-logout.oga"

declare -A SERVICES_STATUS

# Lista de serviços a monitorar
SERVICES=(

    "pipewire-pulse.service"
    "pipewire.service"
    "pipewire-pulse.socket"
    "pipewire.socket"
    "wireplumber.service"
    "gdm.service"
)


# Carrega status anterior (se existir)
if [[ -f $STATE_FILE ]]; then
    while read -r line; do
        name=$(echo "$line" | cut -d':' -f1)
        status=$(echo "$line" | cut -d':' -f2)
        SERVICES_STATUS["$name"]=$status
    done < "$STATE_FILE"
fi

# Atualiza status e age
> "$STATE_FILE"
for svc in "${SERVICES[@]}"; do
    # Verifica se o serviço existe antes de prosseguir
    if ! systemctl list-units --type=service --all | grep -q "$svc"; then
        echo "O serviço $svc não foi encontrado, pulando..."
        continue
    fi

    systemctl --user is-active --quiet "$svc"
    active=$?

    if [[ $active -ne 0 ]]; then
        # Serviço caiu
        [[ "${SERVICES_STATUS[$svc]}" != "down" ]] && {
            paplay "$SOUND" &
            notify-send -u critical "🚨 $svc parado!" "Tentando reiniciar..."
            logger "⚠️ Serviço $svc parado, tentativa de reinício."
        }
        systemctl --user restart "$svc"
        FAILED+=("$svc")
        echo "$svc:down" >> "$STATE_FILE"
    else
        # Serviço está ativo
        if [[ "${SERVICES_STATUS[$svc]}" == "down" ]]; then
            paplay "$SOUND" &
            notify-send -u normal "✅ $svc voltou ao estado ativo!"
            logger "ℹ️ Serviço $svc recuperado."
        fi
        echo "$svc:up" >> "$STATE_FILE"
    fi
done

