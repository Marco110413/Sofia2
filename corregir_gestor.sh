#!/bin/bash

# Archivos y directorios esenciales
CONFIG_FILE="$HOME/.config_gestor"
DATOS_PERSONALES="$HOME/.datos_personales"
ERROR_LOG="$HOME/.errores_gestor"
DIR_PROYECTOS="$HOME/proyectos"
GESTOR_SCRIPT="$HOME/gestor_proyectos.sh"

# 1️⃣ Crear archivos y directorios si no existen
echo "🔍 Verificando archivos y directorios esenciales..."
mkdir -p "$DIR_PROYECTOS"

touch "$CONFIG_FILE"
touch "$DATOS_PERSONALES"
touch "$ERROR_LOG"

# 2️⃣ Revisar permisos y corregir si es necesario
echo "🔍 Revisando permisos..."
chmod 755 "$GESTOR_SCRIPT"

# 3️⃣ Verificar sintaxis del gestor de proyectos
echo "🔍 Analizando errores de sintaxis..."
bash -n "$GESTOR_SCRIPT" 2> "$ERROR_LOG"

if [ -s "$ERROR_LOG" ]; then
    echo "❌ Se encontraron errores en la sintaxis del script:"
    cat "$ERROR_LOG"
    exit 1
else
    echo "✅ No hay errores de sintaxis."
fi

# 4️⃣ Ejecutar el gestor para pruebas
echo "🚀 Ejecutando el Gestor de Proyectos..."
bash "$GESTOR_SCRIPT"
