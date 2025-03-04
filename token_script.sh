#!/bin/bash

# Archivo donde se guardan los tokens
TOKEN_FILE="tokens.dat"

# Función para registrar usuario
registrar_usuario() {
    read -p "Ingrese su nombre de usuario: " usuario
    echo "$usuario 0" >> "$TOKEN_FILE"
    echo "✅ Usuario $usuario registrado correctamente."
}

# Función para ver tokens ganados
ver_tokens() {
    if [[ ! -f "$TOKEN_FILE" ]]; then
        echo "🚫 No hay usuarios registrados aún."
        return
    fi
    echo "📊 Tokens acumulados:"
    cat "$TOKEN_FILE"
}

# Función para obtener la interfaz de red activa
obtener_interfaz() {
    ip addr show | awk '/state UP/ {print $2}' | sed 's/://g' | head -n 1
}

# Función para calcular el consumo de datos
calcular_consumo() {
    local INTERFAZ=$(obtener_interfaz)
    if [[ -z "$INTERFAZ" ]]; then
        echo "🚫 No se encontró una interfaz de red activa."
        return
    fi
    local DATOS=$(grep "$INTERFAZ" /proc/net/dev | awk '{print $2}')
    echo "$DATOS"
}

# Función para iniciar el monitoreo automático
monitoreo() {
    echo "✅ Monitoreo iniciado en segundo plano."
    while true; do
        CONSUMO=$(calcular_consumo)
        echo "🔄 Monitoreando el uso de datos... Bytes usados: $CONSUMO"
        sleep 10  # Verifica cada 10 segundos
    done
}

# Menú de opciones
while true; do
    clear
    echo "🎯 OPCIONES:"
    echo "1️⃣ Registrar usuario"
    echo "2️⃣ Ver tokens ganados"
    echo "3️⃣ Iniciar monitoreo automático"
    echo "4️⃣ Salir"
    read -p "Selecciona una opción: " opcion

    case $opcion in
        1) registrar_usuario ;;
        2) ver_tokens ;;
        3) monitoreo ;;
        4) echo "👋 Saliendo..."; exit ;;
        *) echo "❌ Opción inválida. Intenta de nuevo." ;;
    esac
done
