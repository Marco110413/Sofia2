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
            analizar_proyecto
            return
        else
            echo "❌ Opción inválida. Intenta de nuevo."
        fi
    done
}

# Función para analizar errores en scripts dentro del proyecto seleccionado
analizar_proyecto() {
    if [[ -z "$PROYECTO" ]]; then
        echo "❌ No hay un proyecto seleccionado."
        return
    fi

    cd "$PROYECTO" || { echo "❌ No se pudo acceder a '$PROYECTO'."; return; }

    while true; do
        scripts=($(find . -maxdepth 1 -name "*.sh" 2>/dev/null))
        if [[ ${#scripts[@]} -eq 0 ]]; then
            echo "⚠️ No hay scripts en '$PROYECTO'."
            cd ..
            seleccionar_proyecto  # Regresar a la selección de proyecto en vez de salir
            return
        fi

        echo "🔹 Selecciona un script para analizar:"
        echo "0) ⬅️ Volver"
        for i in "${!scripts[@]}"; do
            echo "$((i + 1))) ${scripts[i]}"
        done

        read -p "#? " opcion_script
        if [[ "$opcion_script" == "0" ]]; then
            cd ..
            seleccionar_proyecto  # Regresar a la selección de proyecto en vez de salir
            return
        elif [[ "$opcion_script" -gt 0 && "$opcion_script" -le ${#scripts[@]} ]]; then
            SCRIPT="${scripts[$((opcion_script - 1))]}"
            echo "📜 Analizando: $SCRIPT"
            break
        else
            echo "❌ Opción inválida."
        fi
    done

    # Verificar permisos de ejecución
    if [[ ! -x "$SCRIPT" ]]; then
        echo "⚠️ '$SCRIPT' no tiene permisos de ejecución. Corrigiendo..."
        chmod +x "$SCRIPT" || { echo "❌ No se pudo corregir permisos."; return; }
        echo "✅ Permisos corregidos."
    fi

    # Verificar errores de sintaxis
    echo "🔍 Verificando sintaxis..."
    bash -n "$SCRIPT" 2>> "$LOG"
    if [[ $? -ne 0 ]]; then
        echo "❌ Errores de sintaxis en '$SCRIPT'. Revisa '$LOG'."
        return
    fi
    echo "✅ Sintaxis correcta."

    # Ejecutar el script con debug
    echo "🔍 Ejecutando '$SCRIPT' en modo debug..."
    bash -x "$SCRIPT" 2>> "$LOG"
    if [[ $? -ne 0 ]]; then
        echo "❌ Errores en ejecución. Revisa '$LOG'."
        return
    fi
    echo "✅ Script ejecutado correctamente."
}

# Ejecutar funciones
seleccionar_proyecto
