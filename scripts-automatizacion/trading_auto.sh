#!/bin/bash

# 📌 Configuración de API
API_KEY="TU_API_KEY"
SECRET_KEY="TU_SECRET_KEY"
BASE_URL="https://api.binance.com"

# 📌 Configuración de trading
TOKEN="BTCUSDT"  # Cambia por el token que quieras manejar
VENTA_MAX=65000  # Precio objetivo de venta
REINVERSION=70   # % a reinvertir
RETIRO=30        # % a retirar
WALLET_ADDRESS="TU_DIRECCION_DE_WALLET"

# 📌 Obtener saldo del token
get_balance() {
    curl -s -H "X-MBX-APIKEY: $API_KEY" "$BASE_URL/api/v3/account" | jq -r '.balances[] | select(.asset=="BTC") | .free'
}

# 📌 Obtener precio actual del token
get_price() {
    curl -s "$BASE_URL/api/v3/ticker/price?symbol=$TOKEN" | jq -r '.price'
}

# 📌 Función para vender cuando el precio alcance el máximo
sell_token() {
    local balance=$(get_balance)
    local price=$(get_price)

    if (( $(echo "$price >= $VENTA_MAX" | bc -l) )); then
        echo "🚀 Precio alcanzado ($price USD). Vendiendo $balance BTC..."
        # Simulación de venta
        echo "✅ Venta realizada: $balance BTC a $price USD"

        # Distribución de fondos
        reinvertir=$(echo "$balance * $REINVERSION / 100" | bc -l)
        retirar=$(echo "$balance * $RETIRO / 100" | bc -l)

        echo "🔄 Reinvirtiendo $reinvertir BTC y retirando $retirar BTC"
        withdraw_token "$retirar"
    else
        echo "❌ Precio actual ($price USD) aún no ha alcanzado el máximo de venta ($VENTA_MAX USD)."
    fi
}

# 📌 Retirar fondos a una wallet externa
withdraw_token() {
    local amount=$1
    echo "📤 Enviando $amount BTC a $WALLET_ADDRESS..."
    # Simulación de retiro
    echo "✅ Retiro exitoso de $amount BTC a $WALLET_ADDRESS"
}

# 📌 Loop infinito que revisa el precio cada minuto
while true; do
    echo "📡 Verificando precio de $TOKEN..."
    sell_token
    sleep 60  # Esperar 1 minuto antes de la siguiente verificación
done
