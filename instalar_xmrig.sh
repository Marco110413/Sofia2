#!/bin/bash

# 🚀 Script de instalación automática de XMRig en Termux

# 📌 Dirección del monedero (Cámbialo por el tuyo)
WALLET="TU_DIRECCION_DE_MONEDERO"

# 📌 Configuración del pool (Cámbialo por el que uses)
POOL="pool.minexmr.com:4444"

# 📌 Directorio de trabajo
WORKDIR="$HOME/xmrig"

# 📌 Número de intentos
MAX_INTENTOS=3
INTENTO=1
DESCARGA_EXITOSA=0

# 📌 URLs de descarga alternativas
URLS=(
    "https://github.com/xmrig/xmrig/releases/latest/download/xmrig-linux-static.tar.gz"
    "https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/config/xmrig-aarch64-linux-gnu.tar.gz"
    "https://mirror.example.com/xmrig-linux.tar.gz"
)

# 🔄 Paso 1: Actualizar Termux y paquetes
echo "🔄 Actualizando Termux..."
pkg update && pkg upgrade -y

# 🔧 Paso 2: Instalar dependencias necesarias
echo "🔧 Instalando dependencias..."
pkg install git cmake build-essential libuv openssl curl tar -y

# 📂 Paso 3: Crear directorio de trabajo
mkdir -p "$WORKDIR"
cd "$WORKDIR" || { echo "❌ Error: No se pudo acceder al directorio de trabajo."; exit 1; }

# 🌍 Paso 4: Descargar XMRig con múltiples intentos
while [ $INTENTO -le $MAX_INTENTOS ] && [ $DESCARGA_EXITOSA -eq 0 ]; do
    for URL in "${URLS[@]}"; do
        echo "🌍 Intento $INTENTO: Descargando desde $URL"
        curl -L -o xmrig.tar.gz "$URL" && DESCARGA_EXITOSA=1 && break
        echo "⚠️ Descarga fallida. Probando otra fuente..."
    done
    ((INTENTO++))
    sleep 5
done

# ❌ Verificar si la descarga falló
if [ $DESCARGA_EXITOSA -eq 0 ]; then
    echo "❌ Error: No se pudo descargar XMRig después de $MAX_INTENTOS intentos."
    exit 1
fi

# 📂 Paso 5: Extraer el archivo descargado
echo "📂 Extrayendo XMRig..."
tar -xvf xmrig.tar.gz || { echo "❌ Error: No se pudo extraer XMRig."; exit 1; }

# 📁 Paso 6: Acceder a la carpeta extraída
cd xmrig-* || { echo "❌ Error: No se encontró la carpeta extraída."; exit 1; }

# 🔧 Paso 7: Compilar XMRig (si no hay ejecutable)
if [ ! -f "xmrig" ]; then
    echo "⚙️ Compilando XMRig..."
    mkdir build && cd build
    cmake ..
    make -j$(nproc) || { echo "❌ Error en la compilación."; exit 1; }
fi

# 🚀 Paso 8: Ejecutar XMRig
echo "🚀 Iniciando minería..."
./xmrig -o "$POOL" -u "$WALLET" --tls --rig-id TermuxMiner
