#!/bin/bash

# Mueve a la carpeta del repositorio
cd ~/ruta/del/repositorio || exit

# Agrega todos los cambios
git add .

# Genera un mensaje de commit con la fecha y hora actuales
git commit -m "Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"

# Sube los cambios a GitHub
git push origin main
