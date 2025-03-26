#!/bin/bash

GESTOR="./gestor_proyectos.sh"  # Ruta del script principal
LOG_ERRORES="$HOME/.errores_gestor"  # Archivo de errores detectados
LOG_CORREGIDOS="$HOME/.correcciones_gestor"  # Archivo de correcciones aplicadas
MAX_INTENTOS=5  # Número máximo de intentos para corregir errores

# Función para mostrar información en pantalla
mostrar_info() {
    echo -e "🔹 $1"
}

# Función para registrar errores en el log
registrar_error() {
    echo "[ERROR] $(date): $1" | tee -a "$LOG_ERRORES"
}

# Función para registrar correcciones aplicadas
registrar_correccion() {
    echo "[CORREGIDO] $(date): $1" | tee -a "$LOG_CORREGIDOS"
}

# Función para probar el gestor creando proyectos de prueba
probar_funcionalidades() {
    mostrar_info "🔍 Probando funcionalidades..."

    # Comprobamos si el archivo principal del gestor existe
    if [[ ! -f "$GESTOR" ]]; then
        registrar_error "El archivo $GESTOR no existe. ¿Se ha eliminado?"
        return 1
    fi

    # Intentar crear un proyecto ficticio
    mostrar_info "🛠️ Creando proyecto de prueba..."
    echo "1" | bash "$GESTOR" 2>&1 | tee -a "$LOG_ERRORES"

    # Intentar mostrar proyectos
    mostrar_info "🛠️ Mostrando proyectos..."
    echo "2" | bash "$GESTOR" 2>&1 | tee -a "$LOG_ERRORES"

    # Intentar editar un archivo en el proyecto ficticio
    mostrar_info "🛠️ Editando archivos en el proyecto de prueba..."
    echo -e "3\n1\nprueba.txt" | bash "$GESTOR" 2>&1 | tee -a "$LOG_ERRORES"

    # Intentar ejecutar un script dentro del proyecto ficticio
    mostrar_info "🛠️ Ejecutando script de prueba..."
    echo -e "5\n1\nprueba.sh" | bash "$GESTOR" 2>&1 | tee -a "$LOG_ERRORES"

    # Intentar eliminar el proyecto ficticio
    mostrar_info "🛠️ Eliminando proyecto de prueba..."
    echo -e "4\n1" | bash "$GESTOR" 2>&1 | tee -a "$LOG_ERRORES"

    mostrar_info "✅ Pruebas completadas. Revisa el log para más detalles."
}

# Función para corregir errores detectados
corregir_errores() {
    local intentos=0

    while [[ $intentos -lt $MAX_INTENTOS ]]; do
        mostrar_info "🔍 Buscando errores... (Intento $((intentos+1))/$MAX_INTENTOS)"
        
        ERRORES=$(bash "$GESTOR" 2>&1)
        echo "$ERRORES" | tee -a "$LOG_ERRORES"  # Guardar errores en log

        if [[ -z "$ERRORES" ]]; then
            mostrar_info "✅ No se detectaron errores. Todo funciona bien."
            break
        fi

        echo "🚨 Se encontraron errores:"
        echo "$ERRORES"

        # Corrección automática de errores
        if echo "$ERRORES" | grep -q "command not found"; then
            COMANDO_FALTANTE=$(echo "$ERRORES" | grep "command not found" | awk '{print $1}')
            mostrar_info "🔧 Instalando: $COMANDO_FALTANTE"
            apt-get install -y "$COMANDO_FALTANTE" 2>/dev/null && registrar_correccion "Instalado $COMANDO_FALTANTE"
        fi

        if echo "$ERRORES" | grep -q "Permission denied"; then
            mostrar_info "🔧 Corrigiendo permisos..."
            chmod +x "$GESTOR"
            registrar_correccion "Permisos corregidos en $GESTOR"
        fi

        if echo "$ERRORES" | grep -q "No such file or directory"; then
            ARCHIVO_FALTANTE=$(echo "$ERRORES" | grep "No such file" | awk -F"'" '{print $2}')
            mostrar_info "🔧 Creando archivo faltante: $ARCHIVO_FALTANTE"
            touch "$ARCHIVO_FALTANTE"
            registrar_correccion "Archivo $ARCHIVO_FALTANTE creado"
        fi

        if echo "$ERRORES" | grep -q "syntax error"; then
            registrar_error "⚠️ Error de sintaxis detectado en $GESTOR. Revisión manual necesaria."
        fi

        intentos=$((intentos+1))
        sleep 2
    done
}

# Función principal
main() {
    mostrar_info "🔄 Iniciando el Gestor de Proyectos con corrección automática..."
    
    if [[ ! -f "$GESTOR" ]]; then
        mostrar_info "⚠️ El script principal no existe. Creándolo..."
        echo -e "#!/bin/bash\necho 'Gestor de Proyectos (temporal)'" > "$GESTOR"
        chmod +x "$GESTOR"
        registrar_correccion "Se creó un script de prueba para el gestor."
    fi

    corregir_errores
    probar_funcionalidades
    mostrar_info "🚀 Ejecutando Gestor de Proyectos después de correcciones..."
    bash "$GESTOR"
}

# Ejecutar el script principal
main
