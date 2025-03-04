#!/bin/bash

# Registro de errores
ERROR_LOG="error_log.txt"
echo "🛠️ Iniciando proceso de solución de errores..." | tee $ERROR_LOG

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 🔄 1. Eliminar configuraciones antiguas
echo "🔄 Eliminando configuraciones antiguas..." | tee -a $ERROR_LOG
rm -rf ~/.cargo ~/.rustup ~/.local/lib/python*/site-packages/web3*

# 🔄 2. Actualizar paquetes
echo "🔄 Actualizando paquetes..." | tee -a $ERROR_LOG
apt update && apt upgrade -y

# 🔄 3. Instalar dependencias necesarias
echo "🔄 Instalando Python, Rust, Cargo y Clang..." | tee -a $ERROR_LOG
apt install -y python python-pip rust clang || echo "❌ Error instalando dependencias" | tee -a $ERROR_LOG

# 🔄 4. Configurar Rust si no está instalado
if ! command_exists rustc; then
    echo "🔄 Instalando Rust..." | tee -a $ERROR_LOG
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
fi

# 🔄 5. Instalar Web3 con diferentes métodos hasta que funcione
install_web3() {
    echo "🔄 Intentando instalar Web3..." | tee -a $ERROR_LOG
    for attempt in {1..5}; do
        echo "🌀 Intento #$attempt de instalación de Web3..." | tee -a $ERROR_LOG
        if pip install web3; then
            echo "✅ Web3 instalado correctamente." | tee -a $ERROR_LOG
            return 0
        else
            echo "❌ Error en la instalación de Web3. Revisando logs..." | tee -a $ERROR_LOG
            sleep 3  # Pequeña pausa antes de reintentar
        fi
    done

    # Intento alternativo si pip falla
    echo "⚡ Intentando instalar Web3 desde GitHub..." | tee -a $ERROR_LOG
    pip install git+https://github.com/ethereum/web3.py.git || echo "❌ Error con instalación desde GitHub." | tee -a $ERROR_LOG
}

install_web3

echo "🎯 Proceso finalizado. Revisa $ERROR_LOG si persisten errores."
