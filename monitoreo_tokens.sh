monitorear_tokens() {
    clear
    echo "🔹 Monitoreo de tokens activo. (Presiona Ctrl + C para salir)"
    
    # Obtener tokens iniciales
    tokens_anteriores=$(grep "^$usuario_email:" tokens.txt | cut -d':' -f2)

    while true; do
        # Obtener tokens actuales
        tokens_actuales=$(grep "^$usuario_email:" tokens.txt | cut -d':' -f2)

        # Verificar si hubo cambios
        if [ "$tokens_actuales" != "$tokens_anteriores" ]; then
            tput cup 2 0
            echo "🔄 Tokens acumulados: $tokens_actuales  "
            echo "✅ Cambio detectado: Se han actualizado los tokens."
            
            # Actualizar la variable de comparación
            tokens_anteriores=$tokens_actuales
        else
            tput cup 2 0
            echo "🔄 Tokens acumulados: $tokens_actuales  "
        fi

        # Esperar 1 segundo antes de actualizar
        sleep 1
    done
}
