#!/bin/bash

# Definir la ruta del repositorio
REPO="$HOME/scripts-automatizacion"

# Verificar si el repositorio existe
if [ ! -d "$REPO/.git" ]; then
    echo "❌ No se encontró el repositorio en $REPO. Clonándolo..."
    git clone https://github.com/marco110413/scripts-automatizacion.git "$REPO"
fi

# Mover todos los scripts al repositorio
mv $HOME/*.sh "$REPO" 2>/dev/null

# Entrar al repositorio
cd "$REPO" || exit

# Sincronizar con GitHub
git pull origin main
git add .
git commit -m "Subida automática de scripts"
git push origin main

echo "✅ Scripts subidos correctamente a GitHub."
