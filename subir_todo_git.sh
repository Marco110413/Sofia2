#!/bin/bash

# 📌 Definir rutas
REPO_DIR="$HOME/scripts-automatizacion"
LOG_FILE="$HOME/.git_private_logs/registro_subidas.log"

# 📌 Mover todos los scripts antes de subirlos
bash "$HOME/mover_scripts.sh"

# 📌 Verificar si hay cambios en Git
cd "$REPO_DIR" || exit
if git status --porcelain | grep -qE '^(M| M|A| A|\?\?)'; then
    # 📌 Agregar todos los cambios
    git add .

    # 📌 Commit con mensaje automático basado en la fecha y hora
    COMMIT_MESSAGE="🚀 Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
    git commit -m "$COMMIT_MESSAGE"

    # 📌 Subir cambios al repositorio
    git push origin main

    echo "✅ Cambios subidos a GitHub con éxito: $COMMIT_MESSAGE" | tee -a "$LOG_FILE"
else
    echo "🔍 No hay cambios nuevos para subir." | tee -a "$LOG_FILE"
fi
