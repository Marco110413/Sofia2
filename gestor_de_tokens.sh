#!/bin/bash

# ==============================
# 🎟️ GESTOR DE TOKENS CON BINANCE (BASH)
# ==============================

CONFIG_FILE="config.cfg"

# 🔹 Cargar configuración
cargar_configuracion() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "⚠️ No se encontró $CONFIG_FILE. Creándolo ahora..."
        configurar_datos
    fi
    source "$CONFIG_FILE"
}

# 🔹 Configurar API Key y Wallet
configurar_datos() {
    echo "Ingrese su API Key de Binance:"
    read API_BINANCE
    echo "Ingrese su Secret Key de Binance:"
    read SECRET_BINANCE
    echo "Ingrese su dirección de wallet USDT:"
    read WALLET

    cat <<EOF > $CONFIG_FILE
API_BINANCE="$API_BINANCE"
SECRET_BINANCE="$SECRET_BINANCE"
WALLET="$WALLET"
EOF

    echo "✅ Configuración guardada en $CONFIG_FILE."
}

# 🔹 Ver saldo en Binance
ver_balance() {
    cargar_configuracion
    TIMESTAMP=$(date +%s000)

    BALANCE_USDT=$(curl -s -H "X-MBX-APIKEY: $API_BINANCE" "https://api.binance.com/api/v3/account" | jq '.balances[] | select(.asset=="USDT") | .free')
    BALANCE_BNB=$(curl -s -H "X-MBX-APIKEY: $API_BINANCE" "https://api.binance.com/api/v3/account" | jq '.balances[] | select(.asset=="BNB") | .free')

    echo "=============================="
    echo "💰 Balance USDT: $BALANCE_USDT USDT"
    echo "🎟️ Balance Tokens: $BALANCE_BNB BNB"
    echo "=============================="
}

# 🔹 Convertir Tokens a USDT
convertir_tokens() {
    cargar_configuracion
    echo "Ingrese la cantidad de BNB a convertir:"
    read CANTIDAD
    SYMBOL="BNBUSDT"

    TIMESTAMP=$(date +%s000)
    QUERY_STRING="symbol=$SYMBOL&side=SELL&type=MARKET&quantity=$CANTIDAD&timestamp=$TIMESTAMP"
    SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$SECRET_BINANCE" | awk '{print $2}')
    
    RESPONSE=$(curl -s -H "X-MBX-APIKEY: $API_BINANCE" -X POST "https://api.binance.com/api/v3/order?${QUERY_STRING}&signature=${SIGNATURE}")

    echo "✅ Conversión realizada con éxito:"
    echo "$RESPONSE"
}

# 🔹 Retirar USDT a una wallet externa
retirar_usdt() {
    cargar_configuracion
    echo "Ingrese la cantidad de USDT a retirar:"
    read CANTIDAD

    TIMESTAMP=$(date +%s000)
    QUERY_STRING="asset=USDT&address=$WALLET&amount=$CANTIDAD&timestamp=$TIMESTAMP"
    SIGNATURE=$(echo -n "$QUERY_STRING" | openssl dgst -sha256 -hmac "$SECRET_BINANCE" | awk '{print $2}')

    RESPONSE=$(curl -s -H "X-MBX-APIKEY: $API_BINANCE" -X POST "https://api.binance.com/wapi/v3/withdraw.html?${QUERY_STRING}&signature=${SIGNATURE}")

    echo "✅ Retiro realizado con éxito:"
    echo "$RESPONSE"
}

# 🔹 Menú Principal
menu() {
    while true; do
        echo "🎟️ GESTOR DE TOKENS"
        echo "1️⃣  Ver balance"
        echo "2️⃣  Convertir tokens a USDT"
        echo "3️⃣  Retirar USDT"
        echo "4️⃣  Configurar API Binance"
        echo "5️⃣  Salir"
        read -p "Seleccione una opción: " opcion

        case $opcion in
            1) ver_balance ;;
            2) convertir_tokens ;;
            3) retirar_usdt ;;
            4) configurar_datos ;;
            5) exit ;;
            *) echo "❌ Opción no válida." ;;
        esac
    done
}

# 🔹 Ejecutar menú
menu
