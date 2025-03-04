#!/bin/bash

# 📌 Definir variables
REPO_DIR="$HOME/scripts-automatizacion"
GITIGNORE_FILE="$REPO_DIR/.gitignore"

# 📌 Crear el archivo .gitignore si no existe
echo "➜ Configurando .gitignore..."
cat <<EOF > "$GITIGNORE_FILE"
# Ignorar archivos y carpetas del sistema
.bash_history
.bashrc
.cache/
.cargo/
.git_private_logs/
.gitconfig
.lesshst
.termux/
.wget-hsts

# Ignorar archivos innecesarios
*.log
*.txt
*.tar.gz
*.json

# Ignorar otras carpetas que no son scripts
Sofia4/
Termux-DeepSpeech/
llama.cpp/
portaudio/
vosk-api/
xmrig/
EOF

echo "✅ .gitignore configurado correctamente."

# 📌 Limpiar archivos no rastreados
echo "➜ Eliminando archivos innecesarios del historial de Git..."
cd "$REPO_DIR"
git rm -r --cached . 2>/dev/null
echo "✅ Repositorio limpiado."

# 📌 Añadir archivos relevantes
echo "➜ Añadiendo scripts al repositorio..."
git add .
git commit -m "🔥 Limpieza: Solo scripts necesarios serán rastreados" 2>/dev/null
echo "✅ Cambios preparados para subir."

# 📌 Subir cambios a GitHub
echo "➜ Subiendo cambios a GitHub..."
git push origin main 2>/dev/null
echo "✅ Scripts subidos correctamente."
