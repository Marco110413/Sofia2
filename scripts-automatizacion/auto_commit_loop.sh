#!/bin/bash

# 📌 Directorio del repositorio
REPO_DIR="$HOME/scripts-automatizacion"

# 📌 Mensaje de commit con fecha y hora
COMMIT_MESSAGE="🔄 Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"

# 📌 Mover al directorio del repositorio
cd "$REPO_DIR" || exit

# 📌 Agregar todos los archivos nuevos o modificados
git add .

# 📌 Verificar si hay cambios para hacer commit
if git diff-index --quiet HEAD --; then
    echo "✅ No hay cambios nuevos. No se necesita commit."
else
    # 📌 Realizar el commit con el mensaje generado
    git commit -m "$COMMIT_MESSAGE"
    echo "✅ Commit realizado: $COMMIT_MESSAGE"

    # 📌 Enviar cambios a GitHub
    git push origin main
    echo "🚀 Cambios subidos a GitHub con éxito."
fi
