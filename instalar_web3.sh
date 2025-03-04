#!/bin/bash

echo "🔄 Actualizando paquetes y Termux..."
pkg update -y && pkg upgrade -y

echo "📦 Instalando dependencias necesarias..."
pkg install -y python rust clang python-dev libffi-dev openssl-dev cargo

echo "📌 Actualizando pip y setuptools..."
pip install --upgrade pip setuptools

echo "🛠 Instalando Web3..."
pip install web3

echo "✅ Instalación completada. Verifica con: python -c 'import web3; print(web3.__version__)'"
