#!/data/data/com.termux/files/usr/bin/bash

echo "Configurando inicio automático en Termux..."

# Comando o script que deseas ejecutar al inicio
AUTOSTART_COMMAND='echo "Bienvenido a Termux - Inicio automático activado"'

# Configurar ~/.bashrc
echo -e "\n# Ejecutar comando al iniciar Termux" >> ~/.bashrc
echo "$AUTOSTART_COMMAND" >> ~/.bashrc

# Configurar ~/.profile (como respaldo)
echo -e "\n# Ejecutar comando al iniciar Termux" >> ~/.profile
echo "$AUTOSTART_COMMAND" >> ~/.profile

# Configurar Termux:Boot si está instalado
mkdir -p ~/.termux/boot
echo -e "#!/data/data/com.termux/files/usr/bin/bash\n$AUTOSTART_COMMAND" > ~/.termux/boot/start.sh
chmod +x ~/.termux/boot/start.sh

echo "✅ Configuración completada. Cierra y abre Termux para probar."
