#!/bin/bash

# Ruta del gestor de proyectos
GESTOR="$HOME/gestor_proyectos.sh"
LOG_ERRORES="$HOME/.errores_gestor"
CONFIG_GLOBAL="$HOME/.config_gestor"

# Función para corregir errores automáticamente
corregir_errores() {
    ERROR="$1"

    case "$ERROR" in
        *"command not found"*)
            echo "🔴 Error: Comando no encontrado. Verificando permisos..."
            chmod +x "$GESTOR"
            ;;
        *"No such file or directory"*)
            echo "🔴 Error: Archivo no encontrado. Restaurando configuración..."
            touch "$CONFIG_GLOBAL"
            echo "DIR_PROYECTOS=$HOME/proyectos" > "$CONFIG_GLOBAL"
            echo "PERMISOS_DEFECTO=755" >> "$CONFIG_GLOBAL"
            ;;
        *"Permission denied"*)
            echo "🔴 Error: Permiso denegado. Asignando permisos..."
            chmod +x "$GESTOR"
            ;;
        *)
            echo "⚠️ Error desconocido. Se recomienda revisión manual."
            ;;
    esac
}

# Bucle hasta que el gestor funcione sin errores
while true; do
    echo "🚀 Ejecutando el Gestor de Proyectos..."
    OUTPUT=$("$GESTOR" 2>&1)

    if echo "$OUTPUT" | grep -qi "error"; then
        echo "🔴 Se detectó un error. Intentando corregir..."
        echo "$OUTPUT" >> "$LOG_ERRORES"
        corregir_errores "$OUTPUT"
        sleep 2  # Pausa para aplicar cambios antes de reintentar
    else
        echo "✅ El gestor se ejecutó sin errores. ¡Todo funciona bien!"
        break
    fi
done
