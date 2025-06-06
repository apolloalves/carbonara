#!/bin/bash
set -e

BACKUP_DIR="/mnt/MDSATA/CLONEZILLA/VENTOY/2025-05-03-01-VENTOY"
IMAGES=("sdd1.exfat-ptcl-img.zst" "sdd2.dd-ptcl-img.zst")
MOUNT_POINT="/mnt/clonezilla-mount"
DEST_DIR="$HOME/ISOs_extraidos"

echo "=== Localizador e Extrator de ISOs de imagens Clonezilla ==="
mkdir -p "$MOUNT_POINT"
mkdir -p "$DEST_DIR"

for BASE_NAME in "${IMAGES[@]}"; do
    echo -e "\n🔍 Processando: $BASE_NAME"
    JOINED_ZST="$BACKUP_DIR/${BASE_NAME}.joined.zst"
    RAW_IMG="$BACKUP_DIR/${BASE_NAME}.img"

    if [[ -f "$BACKUP_DIR/${BASE_NAME}.aa" ]]; then
        echo "➡️ Fragmentos detectados. Juntando..."
        cat "$BACKUP_DIR/${BASE_NAME}."* > "$JOINED_ZST"
    else
        echo "📄 Arquivo único. Copiando para .joined.zst..."
        cp "$BACKUP_DIR/$BASE_NAME" "$JOINED_ZST"
    fi

    echo "📦 Descompactando $JOINED_ZST..."
    unzstd -f "$JOINED_ZST" -o "$RAW_IMG"

    echo "🔗 Configurando loop device..."
    LOOPDEV=$(losetup --find --partscan --show "$RAW_IMG")

    echo "📁 Loop device: $LOOPDEV"
    sleep 1

    PART="${LOOPDEV}p1"
    if [[ ! -e "$PART" ]]; then
        echo "❌ Nenhuma partição detectada em $LOOPDEV. Pulando."
        losetup -d "$LOOPDEV"
        continue
    fi

    echo "📂 Montando $PART em $MOUNT_POINT..."
    mount -o ro "$PART" "$MOUNT_POINT"

    echo "🔎 Procurando arquivos .iso..."
    find "$MOUNT_POINT" -type f -iname "*.iso" -exec cp {} "$DEST_DIR/" \;

    echo "💾 Desmontando e liberando recursos..."
    umount "$MOUNT_POINT"
    losetup -d "$LOOPDEV"

    echo "✅ Finalizado para: $BASE_NAME"
done

echo -e "\n🏁 Todos os arquivos .iso foram copiados para: $DEST_DIR"
