#!/bin/bash

# Definir directorios
PROJECT_DIR=$(pwd)

# Paso 1: Crear o actualizar el README.md
echo "Creando o actualizando el archivo README.md..."
cat <<EOL > "$PROJECT_DIR/README.md"
# SOFIA2

**SOFIA2** es un proyecto que implementa un sistema de reconocimiento de voz para ejecutar comandos. 

## Requisitos

- Python 3.x
- Las siguientes dependencias:

\`\`\`bash
pip install SpeechRecognition pyaudio
\`\`\`

## Instrucciones de uso

1. Clona este repositorio en tu máquina local:
   
   \`\`\`bash
   git clone https://github.com/marco110413/Sofia2.git
   \`\`\`

2. Accede a la carpeta del proyecto:

   \`\`\`bash
   cd Sofia2
   \`\`\`

3. Instala las dependencias necesarias:

   \`\`\`bash
   pip install -r requirements.txt
   \`\`\`

4. Ejecuta el script para iniciar el reconocimiento de voz:

   \`\`\`bash
   python src/recognition_script.py
   \`\`\`

5. El sistema estará escuchando y reconociendo comandos de voz.
EOL

# Paso 2: Crear o actualizar el requirements.txt
echo "Creando o actualizando el archivo requirements.txt..."
cat <<EOL > "$PROJECT_DIR/requirements.txt"
SpeechRecognition==3.14.1
pyaudio==0.2.14
EOL

# Paso 3: Asegurarse de que el script de reconocimiento de voz esté optimizado
echo "Verificando el script de reconocimiento de voz..."
cat <<EOL > "$PROJECT_DIR/src/recognition_script.py"
import speech_recognition as sr

# Función para escuchar y reconocer el comando de voz
def escuchar_comando():
    # Usamos el micrófono como fuente de audio
    with sr.Microphone() as source:
        print("Escuchando... di algo:")
        recognizer = sr.Recognizer()
        # Ajustar ruido ambiente
        recognizer.adjust_for_ambient_noise(source)
        # Escuchar el comando
        audio = recognizer.listen(source)

    # Intentamos reconocer el comando
    try:
        print("Reconociendo...")
        comando = recognizer.recognize_google(audio, language='es-ES')
        print(f"Comando reconocido: {comando}")
        return comando
    except sr.UnknownValueError:
        print("No pude entender lo que dijiste.")
        return ""
    except sr.RequestError:
        print("No hay conexión con el servicio de reconocimiento.")
        return ""

# Función principal
if __name__ == "__main__":
    while True:
        comando = escuchar_comando()
        if comando:
            print(f"Comando recibido: {comando}")
        if 'salir' in comando.lower():
            print("¡Adiós!")
            break
EOL

# Paso 4: Realizar git add, commit y push
echo "Agregando, haciendo commit y subiendo los cambios al repositorio..."

# Agregar cambios al repositorio
git add .

# Hacer commit con un mensaje
git commit -m "Actualización del README, requirements.txt y mejoras en el script de reconocimiento de voz"

# Subir cambios al repositorio
git push -u origin main

echo "Proceso completado con éxito."
