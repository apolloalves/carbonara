#!/bin/bash

# Verifica se está rodando como root
source 'carbo__verifyRoot.sh'

print_status() {
    if [ "$?" -eq 0 ]; then
        printf "\n\033[01;37m[\033[00;32m OK\033[01;37m ]\033[m\n"
    else
        printf "[ \033[01;31mFAILED\033[01;37m ]\033[m\n"
    fi
}

clear
echo
echo "LIMPEZA PROFUNDA DO SISTEMA ARCH"
echo "-------------------------------------------"

# Espaço antes
echo "Calculando espaço livre antes da limpeza..."
espaco_antes=$(df -h / | awk 'NR==2 {print $4}')
echo "Espaço livre antes: $espaco_antes"
echo

# 1. Limpeza de pacotes órfãos
echo "Removendo pacotes órfãos..."
orphans=$(pacman -Qtdq)
if [[ -n "$orphans" ]]; then
    sudo pacman -Rns --noconfirm $orphans
else
    echo "Nenhum pacote órfão encontrado."
fi
print_status

# 2. Limpeza de dependências não requeridas
echo "Removendo dependências não utilizadas..."
to_remove=$(pacman -Qdtq)
if [[ -n "$to_remove" ]]; then
    sudo pacman -Rns --noconfirm $to_remove
else
    echo "Nenhuma dependência extra encontrada."
fi
print_status

# 3. Limpeza de cache do pacman
echo "Limpando cache do pacman..."
sudo paccache -r -k1
print_status

# 4. Limpeza de arquivos APT/dpkg (caso tenha Ubuntu instalado em dual boot)
sudo rm -rfv /var/lib/apt/lists/lock /var/lib/dpkg/lock-frontend /var/lib/apt/lists/*
print_status

# 5. Limpeza de thumbnails
rm -rfv ~/.cache/thumbnails/* ~/.cache/thumbnails/normal/*
print_status

# 6. Limpeza de ícones em cache
rm -rf ~/.cache/icon*
print_status

# 7. Limpeza de cache do usuário (exceto Brave e thumbnails)
echo "Limpando cache geral do usuário (exceto navegador)..."
find ~/.cache -mindepth 1 -maxdepth 1 ! -name "BraveSoftware" ! -name "thumbnails" -exec rm -rf {} +
print_status

# 8. Limpeza do AUR (yay/paru)
if command -v yay &> /dev/null; then
    echo "Limpando cache do yay..."
    yay -Sc --noconfirm
elif command -v paru &> /dev/null; then
    echo "Limpando cache do paru..."
    paru -Sc --noconfirm
else
    echo "Nenhum helper AUR detectado."
fi
print_status

# 9. Flatpak
if command -v flatpak &> /dev/null; then
    echo "Limpando Flatpak..."
    flatpak uninstall --unused -y
    sudo rm -rf /var/tmp/flatpak-cache-*
else
    echo "Nenhum Flatpak encontrado."
fi
print_status

# 10. Limpeza do navegador Brave
echo "Limpando cache do Brave..."
rm -rf ~/.cache/BraveSoftware/Brave-Browser/Default/{Cache,Code\ Cache/js,GPUCache}/*
rm -rf ~/.config/BraveSoftware/Brave-Browser/Crash\ Reports/*
print_status

# 11. Logs e coredumps
echo "Limpando coredumps e logs antigos..."
sudo rm -rf /var/lib/systemd/coredump/*
sudo journalctl --vacuum-time=7d
print_status

# 12. Remoção de logs rotacionados
echo "Removendo logs antigos e rotacionados..."
sudo rm -f /var/log/*.gz /var/log/*.1 /var/log/*-???????? /var/log/*.old
print_status

# 13. systemd-tmpfiles
echo "Limpando arquivos temporários via systemd-tmpfiles..."
sudo systemd-tmpfiles --clean
sudo systemd-tmpfiles --remove
print_status

# 14. /tmp
echo "Limpando /tmp..."
sudo rm -rf /tmp/*
print_status

# 15. Lixeira e conteúdo recente
echo "Limpando clipboard, lixeira e arquivos recentes..."
xsel --clipboard --clear && echo "Clipboard limpo!"
trash-empty --all -f && echo "Lixeira esvaziada!"
rm -rf ~/.local/share/recently-used.xbel && echo "Arquivos recentes removidos!"
print_status

# 16. Auditoria de arquivos grandes
echo
echo "Maiores arquivos (>200MB) encontrados no sistema:"
sudo find / -type f -size +200M -exec du -sh {} + 2>/dev/null | sort -hr | head -n 80
echo

# 17. Sincronizar disco
sync

# Espaço após
espaco_depois=$(df -h / | awk 'NR==2 {print $4}')
echo "Espaço livre depois: $espaco_depois"
echo
echo "✅ LIMPEZA CONCLUÍDA COM SUCESSO!"
echo "🚀 Espaço liberado: de $espaco_antes para $espaco_depois"
echo "-------------------------------------------"

