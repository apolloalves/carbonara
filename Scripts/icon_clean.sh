#!/bin/bash
echo "🔍 Buscando links simbólicos corrompidos em /usr/lib..."

find /usr/lib -type l | grep -P '[^\x00-\x7F]' > /tmp/links_corrompidos.txt

if [[ -s /tmp/links_corrompidos.txt ]]; then
  echo "⚠️ Encontrados os seguintes links corrompidos:"
  cat /tmp/links_corrompidos.txt
  echo
  echo "🧹 Removendo os links..."
  while read -r link; do
    sudo rm -v "$link"
  done < /tmp/links_corrompidos.txt
else
  echo "✅ Nenhum link simbólico com caracteres corrompidos encontrado."
fi

echo
echo "🔎 Procurando arquivos PNG em /usr/lib (não deveriam estar lá)..."
find /usr/lib -iname "*.png" > /tmp/pngs_indevidos.txt

if [[ -s /tmp/pngs_indevidos.txt ]]; then
  echo "⚠️ PNGs encontrados em /usr/lib (anormal):"
  cat /tmp/pngs_indevidos.txt
  echo
  read -p "❓ Deseja removê-los? (s/n): " resp
  if [[ $resp == "s" ]]; then
    while read -r img; do
      sudo rm -v "$img"
    done < /tmp/pngs_indevidos.txt
  fi
else
  echo "✅ Nenhuma imagem PNG fora do lugar em /usr/lib."
fi

echo
echo "🚮 Limpando cache de ícones e regenerando..."
sudo gtk-update-icon-cache -f /usr/share/icons/hicolor

echo
echo "🧼 ldconfig para atualizar links de libs..."
sudo ldconfig

echo
echo "✅ Limpeza finalizada com segurança."

