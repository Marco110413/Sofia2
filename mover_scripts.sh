#!/bin/bash

# 📌 Definir directorios
REPO_DIR="$HOME/scripts-automatizacion"
SEARCH_DIR="$HOME"  # Puedes cambiarlo si deseas otro directorio base

# 📌 Crear carpeta de destino si no existe
mkdir -p "$REPO_DIR"

# 📌 Buscar y copiar scripts manteniendo la estructura de carpetas
find "$SEARCH_DIR" -type f -name "*.sh" -o -name "*.py" -o -name "*.js" -o -name "*.php" -o -name "*.pl" -o -name "*.rb" | while read -r file; do
    # Obtener ruta relativa
    RELATIVE_PATH="${file#$SEARCH_DIR/}"
    
    # Crear la estructura de directorios en la carpeta de destino
    DEST_DIR="$REPO_DIR/$(dirname "$RELATIVE_PATH")"
    mkdir -p "$DEST_DIR"

    # Copiar archivo manteniendo su ruta
    cp "$file" "$DEST_DIR/"

    echo "📂 Copiado: $file → $DEST_DIR/"
done

echo "✅ Todos los scripts han sido copiados a $REPO_DIR de forma ordenada."
