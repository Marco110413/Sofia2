#!/bin/bash

# Archivo de log para registrar los errores
LOG_FILE="install_log.txt"

# Función para verificar si un comando está disponible
command_exists() {
    command -v "$1" &>/dev/null
}

# Función para instalar paquetes de Termux con reintentos
install_package() {
    local package="$1"
    local retries=5

    for ((i=1; i<=retries; i++)); do
        echo "📦 Instalando $package (Intento $i/$retries)..."
        pkg install "$package" -y 2>&1 | tee -a $LOG_FILE

        if command_exists "$package"; then
            echo "✅ $package instalado correctamente."
            return 0
        fi

        echo "❌ Error instalando $package. Reintentando en 5 segundos..."
        sleep 5
    done

    echo "🚨 No se pudo instalar $package después de $retries intentos."
    return 1
}

# 1️⃣ Actualizar Termux
echo "🔄 Actualizando Termux..."
pkg update -y && pkg upgrade -y

# 2️⃣ Instalar dependencias
install_package python
install_package rust

# 3️⃣ Verificar Cargo y Rust
if ! command_exists cargo; then
    echo "⚠️ Cargo no se instaló correctamente. Intentando con rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
fi

# 4️⃣ Instalar Web3.py con reintentos
for ((i=1; i<=5; i++)); do
    echo "📦 Instalando Web3.py (Intento $i/5)..."
    pip install --no-cache-dir web3 2>&1 | tee -a $LOG_FILE

    if python -c "import web3" 2>/dev/null; then
        echo "✅ Web3.py instalado correctamente."
        break
    fi

    echo "❌ Error instalando Web3.py. Reintentando en 5 segundos..."
    sleep 5
done

# 5️⃣ Mostrar versiones finales
echo "🚀 Instalación finalizada. Verificando versiones..."
cargo --version
python -c "import web3; print(web3.__version__)"

echo "✅ Proceso completado."
