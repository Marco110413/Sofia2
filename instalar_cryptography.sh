#!/bin/bash

echo "🔄 Actualizando Termux..."
pkg update && pkg upgrade -y

echo "🔧 Instalando dependencias necesarias..."
pkg install python python-dev rust cargo clang libffi -y

echo "🔄 Actualizando pip..."
pip install --upgrade pip

echo "🚀 Instalando cryptography sin maturin..."
pip install --no-binary :all: --no-use-pep517 cryptography

echo "✅ Instalación completada. Verificando..."
python -c "from cryptography.fernet import Fernet; print(Fernet.generate_key())" && echo "🎉 Cryptography instalado correctamente!" || echo "❌ Error en la instalación."
