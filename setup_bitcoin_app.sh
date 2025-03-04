#!/bin/bash

# Actualizar Termux
echo "🔄 Actualizando Termux..."
pkg update -y && pkg upgrade -y

# Instalar paquetes básicos
echo "⚙️ Instalando herramientas principales..."
pkg install python git nano vim x11-repo -y

# Instalar dependencias de Python
echo "🐍 Instalando librerías de Python..."
pip install --upgrade pip
pip install requests psutil speedtest-cli flask fastapi websockets qrcode

# Instalar XMRig para minería
echo "⛏️ Instalando XMRig..."
pkg install xmrig -y

# Verificar instalación de herramientas
echo "✅ Verificando instalaciones..."
command -v python &>/dev/null && echo "✔️ Python instalado" || echo "❌ Python no encontrado"
command -v git &>/dev/null && echo "✔️ Git instalado" || echo "❌ Git no encontrado"
command -v nano &>/dev/null && echo "✔️ Nano instalado" || echo "❌ Nano no encontrado"
command -v vim &>/dev/null && echo "✔️ Vim instalado" || echo "❌ Vim no encontrado"
command -v xmrig &>/dev/null && echo "✔️ XMRig instalado" || echo "❌ XMRig no encontrado"

# Mostrar mensaje final
echo "🎉 Configuración completada. ¡Ya puedes empezar a desarrollar la app!"
