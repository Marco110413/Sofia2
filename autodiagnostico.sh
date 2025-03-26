#!/bin/bash

GESTOR="$HOME/gestor_proyectos.sh"
CONFIG_GLOBAL="$HOME/.config_gestor"
DATOS_PERSONALES="$HOME/.datos_personales"
LOG_ERRORES="$HOME/.errores_gestor"

# Función para verificar archivos esenciales
verificar_archivos() {
    echo "🔍 Verificando archivos esenciales..."
    
    if [[ ! -f "$GESTOR" ]]; then
        echo "⚠️ Error: No se encontró $GESTOR. Verifica la instalación." | tee -a "$LOG_ERRORES"
        exit 1
    fi

    if [[ ! -f "$CONFIG_GLOBAL" ]]; then
        echo "⚠️ Configuración global no encontrada. Creando..."
        echo "DIR_PROYECTOS=$HOME/proyectos" > "$CONFIG_GLOBAL"
        echo "PERMISOS_DEFECTO=755" >> "$CONFIG_GLOBAL"
    fi

    if [[ ! -f "$DATOS_PERSONALES" ]]; then
        echo "⚠️ No se encontró información personal. Creando archivo vacío..."
        touch "$DATOS_PERSONALES"
    fi

    echo "✅ Archivos esenciales verificados."
}

# Función para corregir permisos
corregir_permisos() {
    echo "🔍 Corrigiendo permisos..."

    chmod +x "$GESTOR"
    chmod 600 "$CONFIG_GLOBAL" "$DATOS_PERSONALES"

    if [[ -d "$HOME/proyectos" ]]; then
        chmod -R 755 "$HOME/proyectos"
    fi

    echo "✅ Permisos corregidos."
}

# Función para verificar comandos faltantes
verificar_comandos() {
    echo "🔍 Verificando dependencias..."
    for cmd in bash chmod nano; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "❌ Falta el comando: $cmd" | tee -a "$LOG_ERRORES"
            exit 1
        fi
    done
    echo "✅ Dependencias verificadas."
}

# Función para ejecutar pruebas automáticas
pruebas_automaticas() {
    echo "🔍 Ejecutando pruebas automáticas..."

    # Crear un proyecto de prueba
    echo "➤ Creando proyecto de prueba..."
    echo "1" | bash "$GESTOR"

    # Mostrar proyectos
    echo "➤ Listando proyectos..."
    echo "2" | bash "$GESTOR"

    # Editar archivos de un proyecto (crear archivo temporal)
    echo "➤ Creando archivo de prueba..."
    echo "3" | bash "$GESTOR" <<< "1
nuevo_script.sh"

    # Asignar permisos y ejecutar script
    echo "➤ Probando ejecución de script..."
    echo "5" | bash "$GESTOR" <<< "1
1"

    echo "✅ Pruebas automáticas completadas."
}

# Ejecutar las funciones en un bucle hasta corregir errores
while true; do
    verificar_archivos
    corregir_permisos
    verificar_comandos
    pruebas_automaticas

    if [[ -s "$LOG_ERRORES" ]]; then
        echo "❌ Se encontraron errores. Revisando el log..."
        cat "$LOG_ERRORES"
        > "$LOG_ERRORES"  # Limpiar log después de cada corrección
    else
        echo "✅ No se encontraron errores. Ejecutando el Gestor de Proyectos..."
        bash "$GESTOR"
        break
    fi
done
