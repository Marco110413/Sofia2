#!/bin/bash

# Archivo de log de errores
LOG="errores.log"
> "$LOG"  # Limpiar el log antes de cada ejecución

# Función para mostrar proyectos disponibles
seleccionar_proyecto() {
    echo "🔹 Buscando proyectos disponibles..."
    proyectos=($(ls -d */ 2>/dev/null)) # Listar solo directorios
    if [[ ${#proyectos[@]} -eq 0 ]]; then
        echo "❌ No se encontraron proyectos en el directorio actual."
        exit 1
    fi

    while true; do
        echo "🔹 Selecciona un proyecto para analizar:"
        echo "0) ⬅️ Volver"
        for i in "${!proyectos[@]}"; do
            echo "$((i + 1))) ${proyectos[i]}"
        done

        read -p "#? " opcion
        if [[ "$opcion" == "0" ]]; then
            echo "↩️ Regresando..."
            exit 0
        elif [[ "$opcion" -gt 0 && "$opcion" -le ${#proyectos[@]} ]]; then
            PROYECTO="${proyectos[$((opcion - 1))]}"
            echo "📂 Proyecto seleccionado: $PROYECTO"
            break
        else
            echo "❌ Opción inválida. Intenta de nuevo."
        fi
    done
}

# Función para analizar errores en un script dentro del proyecto seleccionado
analizar_proyecto() {
    cd "$PROYECTO" || { echo "❌ No se pudo acceder al proyecto '$PROYECTO'."; exit 1; }
    
    while true; do
        scripts=($(find . -maxdepth 1 -name "*.sh" 2>/dev/null))
        if [[ ${#scripts[@]} -eq 0 ]]; then
            echo "❌ No se encontraron scripts en '$PROYECTO'."
            cd ..
            seleccionar_proyecto
        fi

        echo "🔹 Selecciona un script para analizar:"
        echo "0) ⬅️ Volver"
        for i in "${!scripts[@]}"; do
            echo "$((i + 1))) ${scripts[i]}"
        done

        read -p "#? " opcion_script
        if [[ "$opcion_script" == "0" ]]; then
            cd ..
            seleccionar_proyecto
        elif [[ "$opcion_script" -gt 0 && "$opcion_script" -le ${#scripts[@]} ]]; then
            SCRIPT="${scripts[$((opcion_script - 1))]}"
            echo "📜 Analizando el script: $SCRIPT"
            break
        else
            echo "❌ Opción inválida. Intenta de nuevo."
        fi
    done

    # Verificar permisos de ejecución
    if [[ ! -x "$SCRIPT" ]]; then
        echo "⚠️ El script '$SCRIPT' no tiene permisos de ejecución. Intentando corregir..."
        chmod +x "$SCRIPT"
        if [[ $? -ne 0 ]]; then
            echo "❌ No se pudieron otorgar permisos de ejecución."
            exit 1
        fi
        echo "✅ Permisos corregidos."
    fi

    # Verificar errores de sintaxis
    echo "🔍 Verificando errores de sintaxis..."
    bash -n "$SCRIPT" 2>> "$LOG"
    if [[ $? -ne 0 ]]; then
        echo "❌ Se encontraron errores de sintaxis en '$SCRIPT'. Revisa '$LOG'."
        exit 1
    fi
    echo "✅ No se encontraron errores de sintaxis."

    # Ejecutar el script en modo seguro para detectar errores en tiempo de ejecución
    echo "🔍 Ejecutando el script en modo seguro..."
    bash -x "$SCRIPT" 2>> "$LOG"
    if [[ $? -ne 0 ]]; then
        echo "❌ Se encontraron problemas al ejecutar el script. Revisa '$LOG'."
        exit 1
    fi
    echo "✅ El script se ejecutó sin errores graves."

    echo "🎯 Verificación completa. Revisa '$LOG' para más detalles."
}

# Ejecutar funciones
seleccionar_proyecto
analizar_proyecto
