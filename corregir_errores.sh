#!/bin/bash

# 📌 Carpeta donde están los proyectos
CARPETA_PROYECTOS="$HOME/proyectos"

# 📌 Verifica si 'shellcheck' está instalado
if ! command -v shellcheck &>/dev/null; then
  echo "❌ 'shellcheck' no está instalado. Instálalo con:"
  echo "   pkg install shellcheck"
  exit 1
fi

# 📌 Listar proyectos disponibles
echo "🔹 Proyectos disponibles:"
proyectos=()
i=1

for proyecto in "$CARPETA_PROYECTOS"/*; do
  if [[ -d "$proyecto" ]]; then
    proyectos[$i]=$(basename "$proyecto")
    echo "$i) ${proyectos[$i]}"
    ((i++))
  fi
done

# 📌 Si no hay proyectos, salir
if [[ ${#proyectos[@]} -eq 0 ]]; then
  echo "⚠️ No hay proyectos disponibles."
  exit 1
fi

# 📌 Seleccionar un proyecto
read -p "📌 Seleccione un proyecto para analizar: " seleccion

# 📌 Validar que la selección sea un número válido dentro del rango
if ! [[ "$seleccion" =~ ^[0-9]+$ ]] || (( seleccion < 1 || seleccion >= i )); then
  echo "⚠️ Selección inválida."
  exit 1
fi

# 📌 Obtener el nombre del proyecto seleccionado
PROYECTO="${proyectos[$seleccion]}"
ARCHIVO="$CARPETA_PROYECTOS/$PROYECTO/main.sh"

# 📌 Verificar si el archivo existe
if [[ ! -f "$ARCHIVO" ]]; then
  echo "❌ El archivo '$ARCHIVO' no existe."
  exit 1
fi

# 📌 Analizar el script con 'shellcheck'
echo "🔍 Analizando '$ARCHIVO' en busca de errores..."
shellcheck "$ARCHIVO"

# 📌 Sugerencia para editar el archivo
echo "💡 Revise las sugerencias anteriores y corrija los errores."
echo "Puede editar el script con: nano '$ARCHIVO'"

# 📌 Salida sin errores
exit 0#!/bin/bash

# 📌 Carpeta donde están los proyectos
CARPETA_PROYECTOS="$HOME/proyectos"

# 📌 Verifica si 'shellcheck' está instalado
if ! command -v shellcheck &>/dev/null; then
  echo "❌ 'shellcheck' no está instalado. Instálalo con:"
  echo "   pkg install shellcheck"
  exit 1
fi

# 📌 Listar proyectos disponibles
echo "🔹 Proyectos disponibles:"
proyectos=()
i=1

for proyecto in "$CARPETA_PROYECTOS"/*; do
  if [[ -d "$proyecto" ]]; then
    proyectos[$i]=$(basename "$proyecto")
    echo "$i) ${proyectos[$i]}"
    ((i++))
  fi
done

# 📌 Si no hay proyectos, salir
if [[ ${#proyectos[@]} -eq 0 ]]; then
  echo "⚠️ No hay proyectos disponibles."
  exit 1
fi

# 📌 Seleccionar un proyecto
read -p "📌 Seleccione un proyecto para analizar: " seleccion

# 📌 Validar que la selección sea un número válido dentro del rango
if ! [[ "$seleccion" =~ ^[0-9]+$ ]] || (( seleccion < 1 || seleccion >= i )); then
  echo "⚠️ Selección inválida."
  exit 1
fi

# 📌 Obtener el nombre del proyecto seleccionado
PROYECTO="${proyectos[$seleccion]}"
ARCHIVO="$CARPETA_PROYECTOS/$PROYECTO/main.sh"

# 📌 Verificar si el archivo existe
if [[ ! -f "$ARCHIVO" ]]; then
  echo "❌ El archivo '$ARCHIVO' no existe."
  exit 1
fi

# 📌 Analizar el script con 'shellcheck'
echo "🔍 Analizando '$ARCHIVO' en busca de errores..."
shellcheck "$ARCHIVO"

# 📌 Sugerencia para editar el archivo
echo "💡 Revise las sugerencias anteriores y corrija los errores."
echo "Puede editar el script con: nano '$ARCHIVO'"

# 📌 Cierre correcto del script
exit 0#!/bin/bash

# 📌 Carpeta donde están los proyectos
CARPETA_PROYECTOS="$HOME/proyectos"

# 📌 Verifica si 'shellcheck' está instalado
if ! command -v shellcheck &>/dev/null; then
  echo "❌ 'shellcheck' no está instalado. Instálalo con:"
  echo "   pkg install shellcheck"
  exit 1
fi

# 📌 Listar proyectos disponibles
echo "🔹 Proyectos disponibles:"
proyectos=()
i=1

for proyecto in "$CARPETA_PROYECTOS"/*; do
  if [[ -d "$proyecto" ]]; then
    proyectos[$i]=$(basename "$proyecto")
    echo "$i) ${proyectos[$i]}"
    ((i++))
  fi
done

# 📌 Si no hay proyectos, salir
if [[ ${#proyectos[@]} -eq 0 ]]; then
  echo "⚠️ No hay proyectos disponibles."
  exit 1
fi

# 📌 Seleccionar un proyecto
read -p "📌 Seleccione un proyecto para analizar: " seleccion

# 📌 Validar selección
if [[ -z "${proyectos[$seleccion]}" || ! "${proyectos[$seleccion]}" =~ ^[0-9]+$ ]]; then
  echo "⚠️ Selección inválida."
  exit 1
fi

PROYECTO="${proyectos[$seleccion]}"
ARCHIVO="$CARPETA_PROYECTOS/$PROYECTO/main.sh"

# 📌 Verificar si el archivo existe
if [[ ! -f "$ARCHIVO" ]]; then
  echo "❌ El archivo '$ARCHIVO' no existe."
  exit 1
fi

# 📌 Analizar el script con 'shellcheck'
echo "🔍 Analizando '$ARCHIVO' en busca de errores..."
shellcheck "$ARCHIVO"

# 📌 Sugerencia para editar el archivo
echo "💡 Revise las sugerencias anteriores y corrija los errores."
echo "Puede editar el script con: nano '$ARCHIVO'"

# 📌 Asegurar un cierre correcto
exit 0#!/bin/bash

# 📌 Carpeta donde están los proyectos
CARPETA_PROYECTOS="$HOME/proyectos"

# 📌 Verifica si 'shellcheck' está instalado
if ! command -v shellcheck &>/dev/null; then
  echo "❌ 'shellcheck' no está instalado. Instálalo con:"
  echo "   pkg install shellcheck"
  exit 1
fi

# 📌 Listar proyectos disponibles
echo "🔹 Proyectos disponibles:"
proyectos=()
i=1

for proyecto in "$CARPETA_PROYECTOS"/*; do
  if [[ -d "$proyecto" ]]; then
    proyectos[$i]=$(basename "$proyecto")
    echo "$i) ${proyectos[$i]}"
    ((i++))
  fi
done

# 📌 Si no hay proyectos, salir
if [[ ${#proyectos[@]} -eq 0 ]]; then
  echo "⚠️ No hay proyectos disponibles."
  exit 1
fi

# 📌 Seleccionar un proyecto
read -p "📌 Seleccione un proyecto para analizar: " seleccion

if [[ -z "${proyectos[$seleccion]}" ]]; then
  echo "⚠️ Selección inválida."
  exit 1
fi

PROYECTO="${proyectos[$seleccion]}"
ARCHIVO="$CARPETA_PROYECTOS/$PROYECTO/main.sh"

# 📌 Verificar si el archivo existe
if [[ ! -f "$ARCHIVO" ]]; then
  echo "❌ El archivo '$ARCHIVO' no existe."
  exit 1
fi

# 📌 Analizar el script con 'shellcheck'
echo "🔍 Analizando '$ARCHIVO' en busca de errores..."
shellcheck "$ARCHIVO"

# 📌 Sugerencia para editar el archivo
echo "💡 Revise las sugerencias anteriores y corrija los errores."
echo "Puede editar el script con: nano '$ARCHIVO'"

exit 0#!/bin/bash

# 📌 Carpeta donde están los proyectos
CARPETA_PROYECTOS="$HOME/proyectos"

# 📌 Verifica si hay proyectos
if [ ! -d "$CARPETA_PROYECTOS" ]; then
    echo "❌ No se encontró la carpeta de proyectos en '$CARPETA_PROYECTOS'."
    exit 1
fi

# 📌 Lista los proyectos disponibles
echo "🔹 Proyectos disponibles:"
proyectos=()
i=1
for proyecto in "$CARPETA_PROYECTOS"/*; do
    if [[ -d "$proyecto" ]]; then
        proyectos[$i]=$(basename "$proyecto")
        echo "$i) ${proyectos[$i]}"
        ((i++))
    fi
done

# 📌 Verifica si hay proyectos
if [[ ${#proyectos[@]} -eq 0 ]]; then
    echo "⚠️ No hay proyectos disponibles."
    exit 1
fi

# 📌 Selección del usuario
read -p "📌 Seleccione un proyecto para analizar: " seleccion
if [[ -z "${proyectos[$seleccion]}" ]]; then
    echo "⚠️ Opción inválida."
    exit 1
fi

PROYECTO="${proyectos[$seleccion]}"
ARCHIVO="$CARPETA_PROYECTOS/$PROYECTO/main.sh"

# 📌 Verifica si el archivo existe
if [[ ! -f "$ARCHIVO" ]]; then
    echo "❌ El archivo '$ARCHIVO' no existe."
    exit 1
fi

# 📌 Analiza el script con `shellcheck`
echo "🔍 Analizando '$ARCHIVO' en busca de errores..."
shellcheck "$ARCHIVO"

# 📌 Indica cómo corregir los errores
echo "💡 Revise las sugerencias anteriores y corrija los errores."
echo "Puede editar el script con: nano '$ARCHIVO'"

exit 0#!/bin/bash

# 📌 Corrector de errores para scripts en Bash
# Autor: Sofía 😁

# Verifica si se pasó un archivo como argumento
if [[ -z "$1" ]]; then
    echo "⚠️ Uso: ./corregir_errores.sh <script_a_analizar.sh>"
    exit 1
fi

SCRIPT="$1"

# 📌 Verifica si el archivo existe y es un script de Bash
if [[ ! -f "$SCRIPT" ]]; then
    echo "❌ El archivo '$SCRIPT' no existe."
    exit 1
fi

if [[ ! -x "$SCRIPT" ]]; then
    echo "⚠️ El archivo no es ejecutable. Agregando permisos..."
    chmod +x "$SCRIPT"
fi

# 📌 Analiza errores de sintaxis con 'bash -n'
echo "🔎 Analizando errores de sintaxis..."
bash -n "$SCRIPT"
if [[ $? -ne 0 ]]; then
    echo "❌ Se encontraron errores de sintaxis en '$SCRIPT'. Revísalos antes de continuar."
    exit 1
else
    echo "✅ No se encontraron errores de sintaxis."
fi

# 📌 Ejecuta el script en modo de prueba
echo "🔎 Ejecutando el script en modo de prueba..."
bash -x "$SCRIPT" 2> errores.log

# 📌 Verifica si hubo errores durante la ejecución
if [[ -s errores.log ]]; then
    echo "❌ Se detectaron errores en la ejecución:"
    cat errores.log

    # 📌 Intentar corregir errores comunes
    echo "🛠️ Intentando corregir errores automáticamente..."
    sed -i 's/\r$//' "$SCRIPT" # Eliminar caracteres de Windows (\r)
    sed -i 's/read -p /read -r -p /g' "$SCRIPT" # Corregir 'read -p' en algunos sistemas

    echo "✅ Se aplicaron correcciones básicas. Vuelve a ejecutar el script para verificar."
else
    echo "✅ No se encontraron errores de ejecución."
fi

# 📌 Limpieza
rm -f errores.log
