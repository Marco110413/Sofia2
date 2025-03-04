#!/bin/bash

# 📌 Paso 1: Definir variables                  
REPO_DIR="$HOME/scripts-automatizacion"
LOG_DIR="$HOME/.git_private_logs"
LOG_FILE="$LOG_DIR/registro_subidas.log"
BASHRC="$HOME/.bashrc"
SCRIPT_SUBIDA="$REPO_DIR/subir_scripts.sh"      

# 📌 Paso 2: Crear carpetas necesarias
mkdir -p "$REPO_DIR"
mkdir -p "$LOG_DIR"

# 📌 Paso 3: Crear script de subida automática
cat << 'EOF' > "$SCRIPT_SUBIDA"
#!/bin/bash

# 📌 Definir rutas
REPO_DIR="$HOME/scripts-automatizacion"
LOG_FILE="$HOME/.git_private_logs/registro_subidas.log"

# 📌 Crear directorio de logs si no existe
mkdir -p "$(dirname "$LOG_FILE")"

# 📌 Mensaje de prueba
echo "Ejecutando script de subida automática" | tee -a "$LOG_FILE"
EOF

# Dar permisos de ejecución al script
chmod +x "$SCRIPT_SUBIDA"

# 📌 Paso 4: Agregar el script al inicio de Termux
if ! grep -q "bash $SCRIPT_SUBIDA" "$BASHRC"; then
    echo "bash $SCRIPT_SUBIDA" >> "$BASHRC"
fi

echo "✅ Configuración completada. Los scripts se subirán automáticamente al iniciar Termux."
