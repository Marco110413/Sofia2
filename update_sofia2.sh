#!/bin/bash

# Actualización de archivos de proyecto en Sofia2

# 1. Actualizar el archivo README.md
echo "Actualizando el archivo README.md..."
cat <<EOF > README.md
# Sofia2
Proyecto de desarrollo de un asistente inteligente.

## Descripción
SOFIA es un asistente que usa reconocimiento de voz para ejecutar comandos y tareas.

## Funcionalidades
- Reconocimiento de voz
- Ejecución de comandos de voz

EOF

echo "README.md actualizado."

# 2. Actualizar requirements.txt
echo "Actualizando el archivo requirements.txt..."
cat <<EOF > requirements.txt
SpeechRecognition
PyAudio
EOF

echo "requirements.txt actualizado."

# 3. Actualizar el script de reconocimiento de voz
echo "Actualizando el script de reconocimiento de voz..."
cat <<EOF > src/recognition_script.py
import speech_recognition as sr

def escuchar_comando():
    recognizer = sr.Recognizer()
    with sr.Microphone() as source:
        print("Escuchando... di algo:")
        audio = recognizer.listen(source)

    try:
        print("Reconociendo...")
        comando = recognizer.recognize_google(audio, language="es-ES")
        print(f"Comando reconocido: {comando}")
        return comando
    except sr.UnknownValueError:
        print("No pude entender lo que dijiste.")
        return ""
    except sr.RequestError as e:
        print(f"No se pudo conectar con el servicio de Google: {e}")
        return ""

if __name__ == "__main__":
    while True:
        comando = escuchar_comando()
        if comando:
            print(f"Comando recibido: {comando}")
EOF

echo "script de reconocimiento de voz actualizado."

# 4. Agregar, hacer commit y subir los cambios al repositorio
echo "Agregando, haciendo commit y subiendo los cambios al repositorio..."
git add .
git commit -m "Actualización de README, requirements.txt y script de reconocimiento de voz"
git push origin main

echo "Proceso completado con éxito."
