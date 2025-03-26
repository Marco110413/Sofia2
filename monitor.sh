#!/data/data/com.termux/files/usr/bin/bash
LOG_FILE="termux_monitor.log"

log_event() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

send_notification() {
    termux-notification --title "Monitor de Termux" --content "$1"
}

handle_error() {
    ERROR_MSG="$1"

    if echo "$ERROR_MSG" | grep -q "command not found"; then
        MSG="❌ Comando no encontrado. ¿Instalarlo?"
        send_notification "$MSG"
        echo "$MSG (s/n)?"
        read RESPUESTA
        if [ "$RESPUESTA" == "s" ]; then
            PKG=$(echo "$CMD" | awk '{print $1}')
            pkg install "$PKG"
        fi
    elif echo "$ERROR_MSG" | grep -q "Permission denied"; then
        MSG="❌ Permiso denegado. ¿Corregir permisos?"
        send_notification "$MSG"
        echo "$MSG (s/n)?"
        read RESPUESTA
        if [ "$RESPUESTA" == "s" ]; then
            chmod +x "$CMD"
            echo "✅ Permisos corregidos."
        fi
    elif echo "$ERROR_MSG" | grep -q "No such file or directory"; then
        MSG="❌ Archivo no encontrado. ¿Buscar en el sistema?"
        send_notification "$MSG"
        echo "$MSG (s/n)?"
        read RESPUESTA
        if [ "$RESPUESTA" == "s" ]; then
            find / -name "$CMD" 2>/dev/null
        fi
    elif echo "$ERROR_MSG" | grep -q "Network is unreachable"; then
        MSG="❌ No hay conexión a Internet."
        send_notification "$MSG"
        echo "$MSG"
    else
        send_notification "⚠ Error detectado: $ERROR_MSG"
        echo "⚠ No se encontró una solución automática."
    fi
}

send_notification "📢 Monitor de Termux activo."

while true; do
    read -p "$ " CMD
    if [ "$CMD" == "salir" ]; then
        send_notification "Monitor detenido."
        exit 0
    fi
    OUTPUT=$(eval "$CMD" 2>&1)
    STATUS=$?
    log_event "Comando: $CMD"
    if [ $STATUS -ne 0 ]; then
        log_event "Error: $OUTPUT"
        handle_error "$OUTPUT"
    else
        echo "$OUTPUT"
    fi
done
