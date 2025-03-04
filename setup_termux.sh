#!/bin/bash

# Función para verificar si un comando está instalado
check_command() {
    command -v "$1" &>/dev/null
}

# Limpiar Termux
echo "🧹 Eliminando paquetes antiguos..."
pkg uninstall python git nano vim wget tar x11-repo -y
rm -rf $PREFIX/bin/xmrig xmrig*
apt autoremove -y
apt clean

# Actualizar Termux
echo "🔄 Actualizando Termux..."
pkg update -y && pkg upgrade -y

# Instalar herramientas principales con reintentos
for pkg in python git nano vim wget tar x11-repo; do
    for i in {1..5}; do
        echo "⚙️ Instalando $pkg (Intento $i)..."
        pkg install -y "$pkg" && break
        sleep 2
    done
done

# Instalar librerías de Python
echo "🐍 Instalando librerías de Python..."
pip install --upgrade pip
pip install requests psutil speedtest-cli flask fastapi websockets qrcode || pip install requests psutil speedtest-cli flask fastapi websockets qrcode

# Descargar XMRig con reintentos
echo "⛏️ Descargando XMRig..."
XMRIG_URLS=(
    "https://github.com/xmrig/xmrig/releases/latest/download/xmrig-6.20.0-linux-static-x64.tar.gz"
    "https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-linux-static-x64.tar.gz"
)

for url in "${XMRIG_URLS[@]}"; do
    echo "🔗 Intentando descargar XMRig desde: $url"
    wget -q --show-progress "$url" && break
    sleep 2
done

# Verificar descarga
if [ ! -f xmrig-6.20.0-linux-static-x64.tar.gz ]; then
    echo "❌ No se pudo descargar XMRig. Verifica tu conexión a Internet."
    exit 1
fi

# Extraer y mover XMRig
echo "📦 Instalando XMRig..."
tar -xvf xmrig-6.20.0-linux-static-x64.tar.gz
mv xmrig-6.20.0/xmrig $PREFIX/bin/
chmod +x $PREFIX/bin/xmrig

# Verificación final
echo "✅ Verificación final:"
for cmd in python git nano vim wget tar xmrig; do
    check_command $cmd && echo "✔️ $cmd instalado" || echo "❌ $cmd no encontrado"
done

echo "🎉 Configuración completada. ¡Ya puedes empezar!"
