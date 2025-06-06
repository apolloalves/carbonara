#!/bin/bash

clear
echo
echo "LIMPEZA COMPLETA DO SISTEMA ARCH"
echo "-------------------------------------------"

# Espaço antes da limpeza
echo "Calculando espaço ocupado antes..."
espaco_antes=$(df -h / | awk 'NR==2 {print $4}')
echo "Espaço livre antes: $espaco_antes"
echo

# -------------------------
# 1. Limpar pacotes órfãos
# -------------------------
echo "Verificando pacotes órfãos..."
echo "-------------------------------------------"
orphans=$(pacman -Qtdq)

if [[ -n "$orphans" ]]; then
    echo "Removendo pacotes órfãos..."
    sudo pacman -Rns $orphans
else
    echo "Nenhum pacote órfão encontrado."
fi
echo

# -------------------------
# 2. Limpar cache do pacman
# -------------------------
echo "Limpando cache do pacman (mantendo versão atual)..."
echo "-------------------------------------------------------"
sudo paccache -r -k1
echo

# -------------------------
# 3. Limpar cache do AUR
# -------------------------
if command -v yay &> /dev/null; then
    echo "Limpando cache do yay..."
    yay -Sc --noconfirm
elif command -v paru &> /dev/null; then
    echo "Limpando cache do paru..."
    paru -Sc --noconfirm
else
    echo "Nenhum helper de AUR detectado (yay, paru...)"
fi
echo

# -------------------------
# 4. Limpar Flatpak (se houver)
# -------------------------
if command -v flatpak &> /dev/null; then
    echo "Limpando cache do Flatpak..."
    flatpak uninstall --unused -y
    sudo rm -rf /var/tmp/flatpak-cache-*
else
    echo "Nenhum Flatpak encontrado."
fi
echo

# -------------------------
# 5. Limpeza de thumbnails
# -------------------------

echo "Limpando miniaturas (thumbnails)..."
echo "-------------------------------------------"
rm -rf ~/.cache/thumbnails/*
echo

# -------------------------
# 6. Limpeza do Brave
# -------------------------

echo "Limpando cache do Brave..."
echo "-------------------------------------------"
rm -rf ~/.cache/BraveSoftware/Brave-Browser/Default/Cache/*
rm -rf ~/.cache/BraveSoftware/Brave-Browser/Default/Code\ Cache/js/*
rm -rf ~/.cache/BraveSoftware/Brave-Browser/Default/GPUCache/*
rm -rf ~/.config/BraveSoftware/Brave-Browser/Crash\ Reports/*
echo

# -------------------------
# 7. Limpeza de systemd & logs antigos
# -------------------------
echo "Limpando coredumps e logs antigos..."
echo "-------------------------------------------"
sudo rm -rf /var/lib/systemd/coredump/*
sudo journalctl --vacuum-time=7d
echo


# -------------------------
# 8. Limpeza de /tmp
# -------------------------
echo "Limpando arquivos temporários em /tmp..."
echo "-------------------------------------------"
sudo rm -rf /tmp/*
echo

# -------------------------------------------------
# 9. Limpeza recents / trash / cliboard content
# -------------------------------------------------

echo "Removendo lixo..."
echo "-------------------------------------------"
xsel --clipboard --clear && printf "\nclipboard was cleaner!\n";sudo trash-empty --all -f && printf "Rubbish is clear!\n"; rm -rf /home/*/.local/share/recently-used.xbel && printf "Files recent was removed!\n"
echo

# -------------------------
# 10. Auditoria de arquivos grandes
# -------------------------
echo "Maiores arquivos (>100MB) encontrados no sistema:"
echo "-----------------------------------------------------"
sudo find / -type f -size +200M -exec du -sh {} + 2>/dev/null | sort -hr | head -n 80
echo

# -------------------------
# 11. Sincronizar disco
# -------------------------
sync

# Espaço após a limpeza
espaco_depois=$(df -h / | awk 'NR==2 {print $4}')
echo "Espaço livre depois: $espaco_depois"
echo
echo "LIMPEZA CONCLUÍDA COM SUCESSO!"
echo "Espaço liberado: De $espaco_antes para $espaco_depois"
echo "-------------------------------------------"


