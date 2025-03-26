#!/bin/bash

# 📌 Archivo donde se guardará la información
INFO_FILE="$HOME/.mis_datos"

# 📌 Solicitar información con cuadros de entrada usando `whiptail`
nombre=$(whiptail --inputbox "Introduce tu nombre:" 8 40 --title "Datos Personales" 3>&1 1>&2 2>&3)
correo=$(whiptail --inputbox "Introduce tu correo electrónico:" 8 40 --title "Datos Personales" 3>&1 1>&2 2>&3)
telefono=$(whiptail --inputbox "Introduce tu número de teléfono:" 8 40 --title "Datos Personales" 3>&1 1>&2 2>&3)
empresa=$(whiptail --inputbox "Introduce el nombre de tu empresa (si aplica):" 8 40 --title "Datos Personales" 3>&1 1>&2 2>&3)

# 📌 Guardar los datos en un archivo oculto
echo "NOMBRE=$nombre" > "$INFO_FILE"
echo "CORREO=$correo" >> "$INFO_FILE"
echo "TELEFONO=$telefono" >> "$INFO_FILE"
echo "EMPRESA=$empresa" >> "$INFO_FILE"

echo -e "\n✅ Datos guardados en $INFO_FILE"
