#!/bin/bash

echo "🔄 Actualizando Termux..."
pkg update && pkg upgrade -y

echo "📦 Instalando dependencias..."
pkg install python sqlite -y
pip install --upgrade pip
pip install cryptography --no-build-isolation --no-binary cryptography

echo "📂 Creando archivo gestor_proyectos.py..."
cat > gestor_proyectos.py << 'EOF'
# 📌 Aquí pega TODO tu código en Python (las 13 funciones)
EOF

echo "✅ Script creado con éxito."
chmod +x gestor_proyectos.py

echo "🚀 Ejecutando gestor_proyectos.py..."
python gestor_proyectos.py#!/bin/bash

echo "🔄 Actualizando Termux..."
pkg update && pkg upgrade -y

echo "📦 Instalando dependencias..."
pkg install python sqlite -y
pip install --upgrade pip
pip install cryptography --no-build-isolation --no-binary cryptography

echo "📂 Creando archivo gestor_proyectos.py..."
cat > gestor_proyectos.py << 'EOF'
# 📌 Aquí pega TODO tu código en Python (las 13 funciones)
EOF

echo "✅ Script creado con éxito."
chmod +x gestor_proyectos.py

echo "🚀 Ejecutando gestor_proyectos.py..."
python gestor_proyectos.py
