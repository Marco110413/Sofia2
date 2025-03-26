        mkdir -p "$ruta_proyecto"
        dialog --msgbox "Proyecto '$nombre_proyecto' creado en '$ruta_proyecto'." 6 40
    fi
}

# Función para listar proyectos existentes
listar_proyectos() {
    proyectos=$(ls "$BASE_DIR")
    if [ -z "$proyectos" ]; then
        dialog --msgbox "No hay proyectos disponibles." 6 40
    else
        dialog --title "Proyectos Existentes" --msgbox "$proyectos" 15 50
    fi
}

# Función para seleccionar un proyecto
seleccionar_proyecto() {
    proyectos=$(ls "$BASE_DIR")
    if [ -z "$proyectos" ]; then
        dialog --msgbox "No hay proyectos disponibles para seleccionar." 6 40
    else
        dialog --title "Seleccionar Proyecto" \
               --menu "Elija un proyecto:" 15 50 10 $(echo "$proyectos" | nl -w2 -s' ') 2> proyecto_seleccionado.txt
        seleccion=$(<proyecto_seleccionado.txt)
        rm -f proyecto_seleccionado.txt
        nombre_proyecto=$(echo "$proyectos" | sed -n33
#!/bin/bash
# Archivo para almacenar las credenciales de GitHub
CREDENTIALS_FILE="$HOME/.github_credentials"
# Directorio base de proyectos
BASE_DIR="$HOME/proyectos"
# Asegura que el directorio base exista
mkdir -p "$BASE_DIR"
# Función para solicitar y almacenar credenciales de GitHub
solicitar_credenciales() {
    dialog --title "Nombre de usuario de GitHub"            --inputbox "Por favor, ingrese su nombre de usuario de GitHub:" 8 40 2> nombre_usuario.txt;     NOMBRE_USUARIO=$(<nombre_usuario.txt);     rm -f nombre_usuario.txt; 
    dialog --title "Token Personal de Acceso de GitHub"            --inputbox "Por favor, ingrese su token personal de acceso de GitHub:" 8 40 2> token_acceso.txt;     TOKEN_ACCESO=$(<token_acceso.txt);     rm -f token_acceso.txt; 
    echo "$NOMBRE_USUARIO:$TOKEN_ACCESO" > "$CREDENTIALS_FILE";     chmod 600 "$CREDENTIALS_FILE"; }
# Función para cargar credenciales de GitHub
cargar_credenciales() {     if [ -f "$CREDENTIALS_FILE" ]; then         IFS=':' read -r NOMBRE_USUARIO TOKEN_ACCESO < "$CREDENTIALS_FILE";     else         solicitar_credenciales;     fi; }
# Función para crear un nuevo proyecto
crear_proyecto() {     dialog --title "Crear Nuevo Proyecto"            --inputbox "Ingrese el nombre del nuevo proyecto:" 8 40 2> nombre_proyecto.txt;     nombre_proyecto=$(<nombre_proyecto.txt);     rm -f nombre_proyecto.txt; 
    nombre_proyecto=${nombre_proyecto// /_};     ruta_proyecto="$BASE_DIR/$nombre_proyecto";      if [ -d "$ruta_proyecto" ]; then         dialog --msgbox "El proyecto '$nombre_proyecto' ya existe." 6 40;     else         mkdir -p "$ruta_proyecto";         dialog --msgbox "Proyecto '$nombre_proyecto' creado en '$ruta_proyecto'." 6 40;     fi; }
# Función para listar proyectos existentes
listar_proyectos() {     proyectos=$(ls "$BASE_DIR");     if [ -z "$proyectos" ]; then         dialog --msgbox "No hay proyectos disponibles." 6 40;     else         dialog --title "Proyectos Existentes" --msgbox "$proyectos" 15 50;     fi; }
# Función para seleccionar un proyecto
seleccionar_proyecto() {     proyectos=$(ls "$BASE_DIR");     if [ -z "$proyectos" ]; then         dialog --msgbox "No hay proyectos disponibles para seleccionar." 6 40;     else         dialog --title "Seleccionar Proyecto"                --menu "Elija un proyecto:" 15 50 10 $(echo "$proyectos" | nl -w2 -s' ') 2> proyecto_seleccionado.txt;         seleccion=$(<proyecto_seleccionado.txt);         rm -f proyecto_seleccionado.txt;         nombre_proyecto=$(echo "$proyectos" | sed -n33
#!/bin/bash
# Archivo para almacenar las credenciales de GitHub
CREDENTIALS_FILE="$HOME/.github_credentials"
# Directorio base de proyectos
BASE_DIR="$HOME/proyectos"
# Asegura que el directorio base exista
mkdir -p "$BASE_DIR"
# Función para solicitar y almacenar credenciales de GitHub
solicitar_credenciales() {
    dialog --title "Nombre de usuario de GitHub"            --inputbox "Por favor, ingrese su nombre de usuario de GitHub:" 8 40 2> nombre_usuario.txt;     NOMBRE_USUARIO=$(<nombre_usuario.txt);     rm -f nombre_usuario.txt; 
    dialog --title "Token Personal de Acceso de GitHub"            --inputbox "Por favor, ingrese su token personal de acceso de GitHub:" 8 40 2> token_acceso.txt;     TOKEN_ACCESO=$(<token_acceso.txt);     rm -f token_acceso.txt; 
    echo "$NOMBRE_USUARIO:$TOKEN_ACCESO" > "$CREDENTIALS_FILE";     chmod 600 "$CREDENTIALS_FILE"; }
# Función para cargar credenciales de GitHub
cargar_credenciales() {     if [ -f "$CREDENTIALS_FILE" ]; then         IFS=':' read -r NOMBRE_USUARIO TOKEN_ACCESO < "$CREDENTIALS_FILE";     else         solicitar_credenciales;     fi; }
# Función para crear un nuevo proyecto
crear_proyecto() {     dialog --title "Crear Nuevo Proyecto"            --inputbox "Ingrese el nombre del nuevo proyecto:" 8 40 2> nombre_proyecto.txt;     nombre_proyecto=$(<nombre_proyecto.txt);     rm -f nombre_proyecto.txt; 
    nombre_proyecto=${nombre_proyecto// /_};     ruta_proyecto="$BASE_DIR/$nombre_proyecto";      if [ -d "$ruta_proyecto" ]; then         dialog --msgbox "El proyecto '$nombre_proyecto' ya existe." 6 40;     else         mkdir -p "$ruta_proyecto";         dialog --msgbox "Proyecto '$nombre_proyecto' creado en '$ruta_proyecto'." 6 40;     fi; }
# Función para listar proyectos existentes
listar_proyectos() {     proyectos=$(ls "$BASE_DIR");     if [ -z "$proyectos" ]; then         dialog --msgbox "No hay proyectos disponibles." 6 40;     else         dialog --title "Proyectos Existentes" --msgbox "$proyectos" 15 50;     fi; }
# Función para seleccionar un proyecto
seleccionar_proyecto() {     proyectos=$(ls "$BASE_DIR");     if [ -z "$proyectos" ]; then         dialog --msgbox "No hay proyectos disponibles para seleccionar." 6 40;     else         dialog --title "Seleccionar Proyecto"                --menu "Elija un proyecto:" 15 50 10 $(echo "$proyectos" | nl -w2 -s' ') 2> proyecto_seleccionado.txt;         seleccion=$(<proyecto_seleccionado.txt);         rm -f proyecto_seleccionado.txt;         nombre_proyecto=$(echo "$proyectos" | sed -n "${seleccion}p");         ruta_proyecto="$BASE_DIR/$nombre_proyecto";         dialog --msgbox "Proyecto seleccionado: $nombre_proyecto" 6 40;     fi; }
# Función para eliminar un proyecto
eliminar_proyecto() {     proyectos=$(ls "$BASE_DIR");     if [ -z "$proyectos" ]; then         dialog --msgbox "No hay proyectos disponibles para eliminar." 6 40;     else         dialog --title "Eliminar Proyecto"                --menu "Elija un proyecto para eliminar:" 15 50 10 $(echo "$proyectos" | nl -w2 -s' ') 2> proyecto_eliminar.txt;         seleccion=$(<proyecto_eliminar.txt);         rm -f proyecto_eliminar.txt;         nombre_proyecto=$(echo "$proyectos" | sed -n "${seleccion}p");         ruta_proyecto="$BASE_DIR/$nombre_proyecto";         rm -rf "$ruta_proyecto";         dialog --msgbox "Proyecto '$nombre_proyecto' eliminado." 6 40;     fi; }
# Función para crear un APK de un proyecto seleccionado
crear_apk() {     if [ -z "$ruta_proyecto" ]; then         dialog --msgbox "Primero seleccione un proyecto." 6 40;         return;     fi; 
    apk_file="$ruta_proyecto/$nombre_proyecto.apk";     touch "$apk_file"; 
    zipalign -v -p 4 "$apk_file" "$apk_file.aligned";     mv "$apk_file.aligned" "$apk_file";     apksigner sign --ks my-release-key.jks --out "$apk_file.signed" "$apk_file";     mv "$apk_file.signed" "$apk_file";      dialog --msgbox "APK creado y firmado: $apk_file" 6 40; }
# Cargar credenciales al inicio
cargar_credenciales
# Menú principal
while true; do     dialog --title "Gestor de Proyectos"            --menu "Seleccione una opción:" 15 50 6            1 "Crear un nuevo proyecto"            2 "Listar proyectos existentes"            3 "Seleccionar un proyecto"            4 "Eliminar un proyecto"            5 "Crear APK del proyecto seleccionado"            6 "Salir" 2> menu_opcion.txt;      opcion=$(<menu_opcion.txt);     rm -18;  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
bash gestor_proyectos.sh
ls -l $HOME/gestor_proyectos.sh
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
nano $HOME/gestor_proyectos.sh
rm -f $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -f $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
echo "bash $HOME/gestor_proyectos.sh" >> $HOME/.bashrc
bash $HOME/gestor_proyectos.sh
rm -f $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -f $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -f $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -f $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -f $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
rm -f $HOME/gestor_proyectos.sh
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
rm -f $HOME/gestor_proyectos.sh
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -f $HOME/gestor_proyectos.sh
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -f $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -f $HOME/gestor_proyectos.sh
rm -rf $HOME/proyectos
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/gestor_proyectos.sh
rm -rf ~/proyectos
rm -f gestor_proyectos.sh
bash gestor_proyectos.sh      # Iniciar el gestor de proyectos  
chmod +x gestor_proyectos.sh  # Dar permisos de ejecución  
nano gestor_proyectos.sh      # Editar el script  
rm -rf ~/proyectos            # Eliminar todos los proyectos  
ls ~/proyectos                # Listar proyectos disponibles
rm -rf ~/proyectos            # Eliminar todos los proyectos  
nano gestor_proyectos.sh
rm -f gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash gestor_proyectos.sh
rm -rf ~/proyectos    # Eliminar proyectos antiguos  
rm -f gestor_proyectos.sh  # Eliminar script anterior  
nano gestor_proyectos.sh  # Crear un nuevo script
chmod +x gestor_proyectos.sh
bash gestor_proyectos.sh
rm -f gestor_proyectos.sh  # Eliminar script anterior  
bash gestor_proyectos.sh
nano gestor_proyectos.sh  # Crear un nuevo script
chmod +x ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
nano ~/proyectos/tu_proyecto/archivo.sh
rm -f gestor_proyectos.sh  # Eliminar script anterior  
nano ~/proyectos/tu_proyecto/archivo.sh
rm -f gestor_proyectos.sh  # Eliminar script anterior  
nano ~/proyectos/tu_proyecto/archivo.sh
rm -rf ~/proyectos
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -rf ~/proyectos
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -rf ~/proyectos
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh

bash ~/gestor_proyectos.sh
export BINANCE_API_KEY=xFXov9gttcxNEXtLwJ5LMkz7kGci7vEpQR841XlfUgwAXSLwPd2dOX4UH11CIc0X
export BINANCE_SECRET_KEY=TIRPvXfyBhAtPv4YV23CoxUcLAG4apUocRgJohbdNevJFExmZLQNRsxHYRiAqiHK
bash
bash
ls
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
5
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
2
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
./main.sh
ls -l ~/proyectos/gestor_de_tokens
bash ~/proyectos/gestor_de_tokens/main.sh
rm -rf ~/proyectos/gestor_de_tokens
nano ~/gestor_proyectos.sh
rm -rf ~/proyectos/gestor_de_tokens
nano ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
bash ~/proyectos/gestor_de_tokens/main.sh
rm -f ~/gestor_proyectos.sh
rm -rf ~/proyectos/gestor_de_tokens
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -rf ~/proyectos/gestor_de_tokens
nano ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash ~/gestor_proyectos.sh


chmod +x gestor_proyectos.sh
bash ~/gestor_proyectos.sh777
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano ~/gestor_proyectos.sh
bash ~/gestor_proyectos.sh
#!/bin/bash
# Ruta del gestor de proyectos
GESTOR="$HOME/gestor_proyectos.sh"
LOG_ERRORES="$HOME/.errores_gestor"
CONFIG_GLOBAL="$HOME/.config_gestor"
# Función para corregir errores automáticamente
corregir_errores() {     ERROR="$1";      case "$ERROR" in         *"command not found"*)             echo "🔴 Error: Comando no encontrado. Verificando permisos...";             chmod +x "$GESTOR";             ;;         *"No such file or directory"*)             echo "🔴 Error: Archivo no encontrado. Restaurando configuración...";             touch "$CONFIG_GLOBAL";             echo "DIR_PROYECTOS=$HOME/proyectos" > "$CONFIG_GLOBAL";             echo "PERMISOS_DEFECTO=755" >> "$CONFIG_GLOBAL";             ;;         *"Permission denied"*)             echo "🔴 Error: Permiso denegado. Asignando permisos...";             chmod +x "$GESTOR";             ;;         *"No projects found"*)             echo "🔴 Error: No hay proyectos. Creando uno de prueba...";             mkdir -p "$HOME/proyectos/prueba";             touch "$HOME/proyectos/prueba/main.sh";             chmod +x "$HOME/proyectos/prueba/main.sh";             ;;         *)             echo "⚠️ Error desconocido. Se recomienda revisión manual.";             ;;     esac; }
# Bucle hasta que el gestor funcione sin errores
while true; do     echo "🚀 Ejecutando el Gestor de Proyectos...";     OUTPUT=$("$GESTOR" 2>&1);      if echo "$OUTPUT" | grep -qi "error"; then         echo "🔴 Se detectó un error. Intentando corregir...";         echo "$OUTPUT" >> "$LOG_ERRORES";         corregir_errores "$OUTPUT";         sleep 2  # Pausa para aplicar cambios antes de reintentar
    else         echo "✅ El gestor se ejecutó sin errores. ¡Todo funciona bien!";         break;     fi; done
nano gestor_auto.sh
chmod +x gestor_auto.sh
./gestor_auto.sh
bash ~/gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
bash fix_gestor.sh
nano $HOME/corregir_gestor.sh
chmod +x $HOME/corregir_gestor.sh
bash $HOME/corregir_gestor.sh
nano $HOME/gestor_proyectos.sh
chmod +x $HOME/gestor_proyectos.sh
bash $HOME/corregir_gestor.sh
nano $HOME/corregir_gestor.sh
chmod +x $HOME/corregir_gestor.sh
bash $HOME/corregir_gestor.sh
bash autodiagnostico.sh
nano autodiagnostico.sh
chmod +x autodiagnostico.sh
bash autodiagnostico.sh
nano autodiagnostico.sh
chmod +x autodiagnostico.sh
bash autodiagnostico.sh
rm -f gestor_autofix.sh
nano gestor_autofix.sh
chmod +x gestor_autofix.sh
./gestor_autofix.sh
rm -f gestor_autofix.sh
nano gestor_autofix.sh
chmod +x gestor_autofix.sh
./gestor_autofix.sh
rm -f gestor_autofix.sh
nano gestor_autofix.sh
chmod +x gestor_autofix.sh
./gestor_autofix.sh
rm -f gestor_autofix.sh
nano gestor_autofix.sh
chmod +x gestor_autofix.sh
./gestor_autofix.sh
bash gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano gestor_proyectos.sh
bash gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano gestor_proyectos.sh
bash gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash gestor_proyectos.sh
rm -f ~/gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash gestor_proyectos.sh
read -p "Prueba de entrada: " prueba; echo "Ingresaste: $prueba"
rm -rf ~/gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -rf gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -rf gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash gestor_proyectos.sh
rm -rf gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash gestor_proyectos.sh
rm -rf gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -rf gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
bash gestor_proyectos.sh
nano datos.env
EMAIL="usuario@example.com"
USUARIO="mi_usuario"
CONTRASEÑA="mi_contraseña_segura"
API_KEY="clave_secreta"
rm -rf gestor_proyectos.sh
nano gestor_proyectos.sh
bash gestor_proyectos.sh
pkg update && pkg upgrade -y
pkg install python -y
pip install cryptography
pkg install nano -y  # Editor de texto para editar archivos
nano instalar_cryptography.sh
chmod +x instalar_cryptography.sh
./instalar_cryptography.sh
# 1️⃣ Actualizar paquetes
pkg update && pkg upgrade -y
# 2️⃣ Instalar Python y herramientas necesarias
pkg install python clang libffi openssl rust -y
# 3️⃣ Configurar variables de entorno para Rust (si no se reconocen los comandos)
export CARGO_HOME=$HOME/.cargo
export PATH=$CARGO_HOME/bin:$PATH
# 4️⃣ Instalar cryptography usando pip sin PEP 517
pip install --upgrade setuptools wheel
pip install cryptography
python -c "from cryptography.fernet import Fernet; print(Fernet.generate_key())"
nano setup.sh
chmod +x setup.sh
./setup.sh
python gestor_proyectos.py
nano llenar_info.sh
chmod +x llenar_info.sh
./llenar_info.sh
pkg update && pkg install whiptail -y
./llenar_info.sh
pkg update && pkg upgrade -y
pkg install nano openssl git -y
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -rf ~/gestor_proyectos.sh ~/proyectos
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f gestor_proyectos.sh
touch gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
nano prueba_gestor.sh
chmod +x prueba_gestor.sh
./prueba_gestor.sh
exit
0
./gestor_proyectos.sh
rm -f gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
rm -f gestor_proyectos.sh
nano gestor_proyectos.sh
chmod +x gestor_proyectos.sh
./gestor_proyectos.sh
exit
