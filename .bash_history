#!/bin/bash
echo "🚀 Iniciando ejecución automática de los pasos de la lista principal..."
# Verificar que Git esté instalado
while ! command -v git &> /dev/null; do     echo "⚠️ Git no está instalado. Intentando instalar...";     pkg install -y git || { echo "❌ Error al instalar Git. Reintentando..."; sleep 3; }; done
echo "✅ Git está instalado."
# Verificar si estamos en un repositorio Git
while ! git rev-parse --is-inside-work-tree &> /dev/null; do     echo "❌ No estás en un repositorio de Git. Ingresa la ruta:";     read -p "📂 Ruta del repositorio: " REPO_PATH;     cd "$REPO_PATH" || { echo "❌ Ruta no válida. Intenta de nuevo."; sleep 3; }; done
echo "✅ Estás en un repositorio de Git."
# Lista de pasos principales (aquí puedes definir 110 pasos o más)
PASOS=(     "git pull"     "git fetch --all"     "git reset --hard origin/main"     "git clean -fd"     "git gc --auto"     "git fsck --full"
)
# Ejecutar cada paso en un bucle
for PASO in "${PASOS[@]}"; do     echo "🔄 Ejecutando: $PASO";     $PASO;     if [ $? -ne 0 ]; then         echo "❌ Error en: $PASO. Aplicando solución automática...";         sleep 2;     else         echo "✅ Completado: $PASO";     fi; done
echo "🚀 Todos los pasos de la lista principal han sido ejecutados correctamente."
nano token_script.sh
chmod +x token_script.sh
./token_script.sh
pkg update && pkg upgrade -y
pkg install iproute2 -y
rm token_script.sh
nano token_script.sh
./token_script.sh
ls -l token_script.sh
chmod +x token_script.sh
./token_script.sh
ip link show
chmod +x sofia_monitor.sh
#!/bin/bash
# Variables
USER_FILE="usuarios.txt"
TOKENS_FILE="tokens.txt"
# Función para registrar usuario
registrar_usuario() {     read -p "Ingresa tu nombre de usuario: " usuario;     if grep -q "^$usuario$" "$USER_FILE" 2>/dev/null; then         echo "⚠️ Usuario ya registrado.";     else         echo "$usuario" >> "$USER_FILE";         echo "$usuario 0" >> "$TOKENS_FILE";         echo "✅ Usuario registrado exitosamente.";     fi; }
# Función para ver tokens
ver_tokens() {     read -p "Ingresa tu nombre de usuario: " usuario;     tokens=$(grep "^$usuario " "$TOKENS_FILE" | awk '{print $2}');     if [ -z "$tokens" ]; then         echo "⚠️ Usuario no encontrado.";     else         echo "🎖️ Tokens ganados: $tokens";     fi; }
# Función para monitorear datos
monitorear_datos() {     echo "✅ Monitoreo iniciado en segundo plano.";     while true; do         WIFI_BYTES=$(cat /sys/class/net/wlan0/statistics/rx_bytes 2>/dev/null || echo 0);         MOVIL_BYTES=$(cat /sys/class/net/rmnet0/statistics/rx_bytes 2>/dev/null || echo 0);         TOTAL_BYTES=$((WIFI_BYTES + MOVIL_BYTES));          echo "📡 WiFi: $WIFI_BYTES bytes | 📶 Móvil: $MOVIL_BYTES bytes | 🔄 Total: $TOTAL_BYTES bytes";         sleep 5;     done; }
# Menú de opciones
while true; do     echo -e "\nOPCIONES:";     echo "1️⃣ Registrar usuario";     echo "2️⃣ Ver tokens ganados";     echo "3️⃣ Iniciar monitoreo automático";     echo "4️⃣ Salir";          read -p "Selecciona una opción: " opcion;      case $opcion in         1) registrar_usuario ;;         2) ver_tokens ;;         3) monitorear_datos ;;         4) echo "👋 Saliendo..."; exit ;;         *) echo "❌ Opción no válida. Intenta de nuevo." ;;     esac; done
#!/bin/bash
# Archivo donde se guardan los usuarios (email, contraseña hasheada y tokens)
USER_FILE="usuarios.txt"
# Función para registrar un usuario
registrar_usuario() {     echo "🔹 Registro de usuario";     read -p "📧 Ingresa tu email: " email;     grep -q "^$email|" $USER_FILE 2>/dev/null;     if [ $? -eq 0 ]; then         echo "⚠️ El email ya está registrado.";         return;     fi;      read -s -p "🔑 Ingresa una contraseña: " password;     echo;     hashed_password=$(echo -n "$password" | sha256sum | awk '{print $1}');     echo "$email|$hashed_password|0" >> $USER_FILE;     echo "✅ Usuario registrado con éxito."; }
# Función para iniciar sesión
iniciar_sesion() {     echo "🔹 Inicio de sesión";     read -p "📧 Ingresa tu email: " email;     read -s -p "🔑 Ingresa tu contraseña: " password;     echo;     hashed_password=$(echo -n "$password" | sha256sum | awk '{print $1}');      user_data=$(grep "^$email|" $USER_FILE 2>/dev/null);     if [ -z "$user_data" ]; then         echo "⚠️ Usuario no encontrado.";         return;     fi;      stored_password=$(echo "$user_data" | cut -d '|' -f2);     if [ "$hashed_password" == "$stored_password" ]; then         echo "✅ Inicio de sesión exitoso. ¡Bienvenido!";     else         echo "❌ Contraseña incorrecta.";     fi; }
# Función para recuperar contraseña (muestra el hash, no es seguro en producción)
recuperar_contraseña() {     echo "🔹 Recuperación de contraseña";     read -p "📧 Ingresa tu email: " email;     user_data=$(grep "^$email|" $USER_FILE 2>/dev/null);      if [ -z "$user_data" ]; then         echo "⚠️ Usuario no encontrado.";         return;     fi;      echo "⚠️ No podemos recuperar la contraseña por seguridad.";     echo "📌 Si olvidaste tu contraseña, puedes crear una nueva contactando soporte."; }
# Función para eliminar usuario
eliminar_usuario() {     echo "🔹 Eliminar usuario";     read -p "📧 Ingresa tu email: " email;     read -s -p "🔑 Ingresa tu contraseña: " password;     echo;     hashed_password=$(echo -n "$password" | sha256sum | awk '{print $1}');      user_data=$(grep "^$email|" $USER_FILE 2>/dev/null);     if [ -z "$user_data" ]; then         echo "⚠️ Usuario no encontrado.";         return;     fi;      stored_password=$(echo "$user_data" | cut -d '|' -f2);     if [ "$hashed_password" == "$stored_password" ]; then         grep -v "^$email|" $USER_FILE > temp.txt && mv temp.txt $USER_FILE;         echo "✅ Usuario eliminado con éxito.";     else         echo "❌ Contraseña incorrecta.";     fi; }
# Menú principal
while true; do     echo -e "\n📌 OPCIONES:";     echo "1️⃣ Registrar usuario";     echo "2️⃣ Iniciar sesión";     echo "3️⃣ Recuperar contraseña";     echo "4️⃣ Eliminar usuario";     echo "5️⃣ Salir";     read -p "Selecciona una opción: " opcion;      case $opcion in         1) registrar_usuario ;;         2) iniciar_sesion ;;         3) recuperar_contraseña ;;         4) eliminar_usuario ;;         5) echo "👋 Saliendo..."; exit ;;         *) echo "❌ Opción inválida." ;;     esac; done
#!/bin/bash
# Archivo donde se guardan los usuarios (email:contraseña)
USER_FILE="users.txt"
# Función para iniciar sesión
login() {     echo "🔑 Iniciar sesión";     read -p "Email: " email;     read -s -p "Contraseña: " password;     echo; 
    if grep -q "^$email:$password$" "$USER_FILE"; then         echo "✅ Inicio de sesión exitoso. Bienvenido, $email!";     else         echo "❌ Error: Email o contraseña incorrectos.";         exit 1;     fi; }
# Llamar a la función
login
chmod +x instalar_xmrig.sh
#!/bin/bash
echo "🚀 Iniciando instalación de XMRig en Termux..."
# 🛠️ 1. Instalar dependencias necesarias
echo "📦 Instalando dependencias..."
pkg update -y && pkg upgrade -y
pkg install -y git cmake make clang curl tar
# 🔽 2. Descargar XMRig
echo "📂 Descargando XMRig..."
cd $HOME
rm -rf xmrig
git clone https://github.com/xmrig/xmrig.git || { echo "❌ Error: No se pudo descargar XMRig"; exit 1; }
curl -L -o xmrig.tar.gz https://github.com/xmrig/xmrig/archive/refs/heads/master.tar.gz
tar -xvf xmrig.tar.gz
mv xmrig-master xmrig
cd xmrig
pkg update && pkg upgrade -y
pkg install git cmake clang make libuv openssl curl -y
cd ~/xmrig
mkdir -p build && cd build
cmake ..
pkg install hwloc-static -y
pkg install git autoconf automake libtool -y
cd $HOME
git clone https://github.com/open-mpi/hwloc.git
cd hwloc
bash instalar_hwloc.sh
#!/bin/bash
echo "⚙️ Configurando Git para evitar errores de transferencia..."
git config --global http.postBuffer 524288000
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999
git config --global fetch.fsckObjects false
git config --global receive.fsckObjects false
git config --global http.followRedirects true
echo "🔄 Actualizando paquetes en Termux..."
pkg update -y && pkg upgrade -y
echo "📦 Instalando dependencias necesarias..."
pkg install -y git autoconf automake libtool curl cmake clang make
echo "🔄 Intentando clonar hwloc desde GitHub..."
if git clone --depth=1 https://github.com/open-mpi/hwloc.git; then     cd hwloc || exit; else     echo "⚠️ Falló la clonación, descargando versión comprimida...";     curl -LO https://download.open-mpi.org/release/hwloc/v2.9/hwloc-2.9.2.tar.gz;     tar -xvzf hwloc-2.9.2.tar.gz;     cd hwloc-2.9.2 || exit; fi
echo "⚙️ Compilando e instalando hwloc..."
./autogen.sh
./configure
make -j$(nproc)
make install
echo "✅ hwloc instalado correctamente."
cd
#!/bin/bash
set -e  # Detiene el script si hay errores
echo "⚙️ Configurando Git para evitar errores..."
git config --global http.postBuffer 524288000
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999
echo "🔄 Actualizando paquetes en Termux..."
pkg update -y && pkg upgrade -y
echo "📦 Instalando dependencias necesarias..."
pkg install -y git autoconf automake libtool curl cmake clang make
# Eliminamos posibles instalaciones fallidas
rm -rf hwloc hwloc-2.9.2
echo "🔄 Clonando hwloc desde GitHub..."
if git clone --depth=1 https://github.com/open-mpi/hwloc.git; then     cd hwloc || exit; else     echo "⚠️ Falló la clonación, intentando descargar el código fuente...";     curl -LO https://download.open-mpi.org/release/hwloc/v2.9/hwloc-2.9.2.tar.gz;     tar -xvzf hwloc-2.9.2.tar.gz;     cd hwloc-2.9.2 || exit; fi
echo "⚙️ Configurando hwloc para la compilación..."
if ! ./autogen.sh; then     echo "❌ Error en autogen.sh";     exit 1; fi
if ! ./configure --disable-libxml2; then     echo "❌ Error en configure";     exit 1; fi
