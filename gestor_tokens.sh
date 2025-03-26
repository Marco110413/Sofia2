#!/bin/bash

# Archivo de base de datos
DB="tokens_db.json"

# Verificar si la base de datos existe, si no, crearla
if [ ! -f "$DB" ]; then
    echo "[]" > "$DB"
fi

# Función para registrar usuario
registrar_usuario() {
    echo "🔹 Registro de usuario"
    read -p "Nombre de usuario: " usuario
    read -s -p "Contraseña: " contraseña
    echo ""

    # Verificar si el usuario ya existe
    if grep -q "\"usuario\": \"$usuario\"" "$DB"; then
        echo "❌ El usuario ya existe. Intenta con otro nombre."
        return
    fi

    # Agregar usuario con tokens iniciales
    echo "{\"usuario\": \"$usuario\", \"contraseña\": \"$contraseña\", \"tokens\": 10}" >> "$DB"
    echo "✅ Registro exitoso. Comenzando a ganar tokens..."
}

# Función para iniciar sesión
iniciar_sesion() {
    echo "🔹 Iniciar sesión"
    read -p "Nombre de usuario: " usuario
    read -s -p "Contraseña: " contraseña
    echo ""

    if grep -q "\"usuario\": \"$usuario\"" "$DB"; then
        echo "✅ Inicio de sesión exitoso."
    else
        echo "❌ Usuario o contraseña incorrectos."
    fi
}

# Función para ver tokens
ver_tokens() {
    tokens=$(grep "\"tokens\":" "$DB" | awk -F'"tokens": ' '{print $2}' | tr -d '},')
    echo "🔹 Tokens acumulados: $tokens"
}

# Función para monitorear tokens en tiempo real
monitorear_tokens() {
    echo "🔹 Monitoreo de tokens activo. (Presiona Ctrl + C para salir)"
    while true; do
        tokens=$(grep "\"tokens\":" "$DB" | awk -F'"tokens": ' '{print $2}' | tr -d '},')
        nuevos_tokens=$((tokens + 10))
        sed -i "s/\"tokens\": $tokens/\"tokens\": $nuevos_tokens/" "$DB"
        echo "🔄 Tokens acumulados: $nuevos_tokens"
        sleep 1
    done
}

# Función para convertir tokens a criptomonedas
convertir_a_cripto() {
    echo "🔹 Convertir tokens a criptomonedas"
    echo "Opciones disponibles: 1) USDT  2) BNB  3) ETH  4) BTC"
    read -p "Selecciona una opción: " opcion

    case $opcion in
        1) cripto="USDT";;
        2) cripto="BNB";;
        3) cripto="ETH";;
        4) cripto="BTC";;
        *) echo "❌ Opción no válida"; return;;
    esac

    read -p "Cantidad de tokens a convertir: " cantidad
    echo "✅ Has convertido $cantidad tokens a $cripto"
}

# Función para gestionar el token propio
gestionar_token_propio() {
    echo "🔹 Gestión del token propio"
    echo "Opciones: 1) Comprar tokens  2) Vender tokens"
    read -p "Selecciona una opción: " opcion

    case $opcion in
        1) read -p "Cantidad a comprar: " cantidad; echo "✅ Compraste $cantidad tokens";;
        2) read -p "Cantidad a vender: " cantidad; echo "✅ Vendiste $cantidad tokens";;
        *) echo "❌ Opción no válida"; return;;
    esac
}

# Menú principal
while true; do
    echo "----------------------------------"
    echo "📌 MENÚ PRINCIPAL"
    echo "1️⃣ Registrar usuario"
    echo "2️⃣ Iniciar sesión"
    echo "3️⃣ Ver tokens ganados"
    echo "4️⃣ Convertir tokens a criptomonedas"
    echo "5️⃣ Monitorear tokens"
    echo "6️⃣ Gestionar token propio"
    echo "7️⃣ Salir"
    echo "----------------------------------"
    read -p "Selecciona una opción: " opcion

    case $opcion in
        1) registrar_usuario;;
        2) iniciar_sesion;;
        3) ver_tokens;;
        4) convertir_a_cripto;;
        5) monitorear_tokens;;
        6) gestionar_token_propio;;
        7) echo "👋 Saliendo..."; exit;;
        *) echo "❌ Opción no válida";;
    esac
done
