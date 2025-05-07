#!/bin/bash

# -------------------------------
# ANIQUILAR_HD.SH
# Destrói completamente um disco
# -------------------------------

# Confirmação de root
if [ "$EUID" -ne 0 ]; then
  echo "Execute como root!"
  exit 1
fi

# Seleção do disco
read -rp "Digite o disco a ser aniquilado (ex: /dev/sdb): " DISK

# Confirmação dupla
echo "⚠️  Todos os dados de $DISK serão perdidos e o disco será inutilizado!"
read -rp "Digite 'ANIQUILAR' para confirmar: " CONFIRM

if [[ "$CONFIRM" != "ANIQUILAR" ]]; then
  echo "Cancelado."
  exit 1
fi

echo "Iniciando destruição definitiva de $DISK..."

# 1. Corromper tabela de partição
echo "Corrompendo tabela de partições..."
dd if=/dev/urandom of="$DISK" bs=512 count=10 status=progress

# 2. Sobrescrever com dados aleatórios
echo "Sobrescrevendo todo o disco com dados aleatórios..."
dd if=/dev/urandom of="$DISK" bs=1M status=progress || true

# 3. Zerar os primeiros e últimos setores
echo "Zerando setores críticos (MBR e GPT backup)..."
dd if=/dev/zero of="$DISK" bs=512 count=2048 status=progress
DISK_SIZE=$(blockdev --getsz "$DISK")
dd if=/dev/zero of="$DISK" bs=512 seek=$(($DISK_SIZE - 2048)) count=2048 status=progress

# 4. Apagar assinatura de filesystem
echo "Apagando assinaturas de sistema de arquivos..."
wipefs -a "$DISK"

# 5. Corromper estrutura SMART (experimental - opcional)
# echo "Tentando corromper registros SMART..."
# hdparm --security-erase NULL "$DISK" || true

# 6. Ejetar disco (se possível)
echo "Sincronizando e ejetando disco..."
sync
udisksctl power-off -b "$DISK" || echo "Disco não pôde ser ejetado automaticamente."

echo "✅ Processo finalizado. O disco foi destruído logicamente com sucesso."
echo "Agora é seguro descartá-lo (ou destruir fisicamente se desejar)."

