#!/bin/bash

# 🚀 Configuración inicial
WALLET="TU_DIRECCION_DE_WALLET"
WORKDIR="$HOME/xmrig"
URLS=(
    "https://github.com/xmrig/xmrig/releases/latest/download/xmrig-linux-static-aarch64.tar.gz"
    "https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/config/xmrig-aarch64-linux-gnu.tar.gz"
    "https://github.com/xmrig/xmrig.git"
)
POOL="pool.minexmr.com:4444"

# 📌 Paso 1: Eliminar archivos previos
echo "🗑 Eliminando archivos anteriores..."
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"
cd "$WORKDIR" || { echo "❌ Error: No se pudo acceder al directorio de trabajo."; exit 1; }

# 📥 Paso 2: Intentar descargar XMRig desde varias fuentes
DESCARGA_EXITOSA=0
for URL in "${URLS[@]}"; do
    echo "🌍 Intentando descargar XMRig desde: $URL"
    
    if [[ $URL == *.git ]]; then
        git clone "$URL" xmrig && DESCARGA_EXITOSA=1
    else
        wget "$URL" -O xmrig.tar.gz && DESCARGA_EXITOSA=1
    fi

    if [[ $DESCARGA_EXITOSA -eq 1 ]]; then
        echo "✅ Descarga exitosa desde: $URL"
        break
    else
        echo "⚠️ Falló la descarga. Probando otra fuente..."
    fi
done

if [[ $DESCARGA_EXITOSA -eq 0 ]]; then
    echo "❌ Error: No se pudo descargar XMRig después de varios intentos."
    exit 1
fi

# 📂 Paso 3: Extraer y compilar si es necesario
if [[ -f "xmrig.tar.gz" ]]; then
    echo "📂 Extrayendo XMRig..."
    tar -xvf xmrig.tar.gz && cd xmrig-*
elif [[ -d "xmrig" ]]; then
    echo "🔨 Compilando XMRig..."
    cd xmrig
    mkdir build && cd build
    cmake ..
    make -j$(nproc)
fi

# 🚀 Paso 4: Ejecutar el minero
if [[ -f "./xmrig" ]]; then
    chmod +x ./xmrig
    echo "🚀 Iniciando minería..."
    ./xmrig -o "$POOL" -u "$WALLET" --cpu-priority=5
else
    echo "❌ Error: No se encontró el ejecutable de XMRig."
    exit 1
fi
