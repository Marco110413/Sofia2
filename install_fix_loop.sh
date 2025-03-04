#!/bin/bash

LOG_FILE="install_errors.log"
SUCCESS_FILE="install_success.log"

# Función para registrar errores y evitar repetirlos
log_error() {
    echo "$1" >> $LOG_FILE
}

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" &>/dev/null
}

echo "🔄 Actualizando Termux..."
pkg update -y && pkg upgrade -y

echo "📦 Instalando Rust y Cargo..."
pkg install rust -y 2>&1 | tee -a $LOG_FILE
if ! command_exists cargo; then
    echo "⚠️ Cargo no se instaló correctamente. Intentando con rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi

echo "📦 Instalando Python..."
pkg install python -y 2>&1 | tee -a $LOG_FILE

echo "📦 Instalando Web3.py..."
pip install web3 2>&1 | tee -a $LOG_FILE

# Verificar si Web3.py está funcionando
if python -c "import web3" 2>/dev/null; then
    echo "✅ Web3 instalado correctamente." | tee -a $SUCCESS_FILE
else
    echo "❌ Error en la instalación de Web3. Aplicando soluciones..." | tee -a $LOG_FILE
    pip install --upgrade pip setuptools
    pip install web3
fi

echo "✅ Proceso completado."
