#!/bin/bash

# 📌 Definir rutas
REPO_DIR="$HOME/scripts-automatizacion"
LOG_FILE="$HOME/.git_private_logs/registro_subidas.log"

# 📌 Crear directorio de logs si no existe
mkdir -p "$(dirname "$LOG_FILE")"

# 📌 Mensaje de prueba
echo "Ejecutando script de subida automática" | tee -a "$LOG_FILE"
