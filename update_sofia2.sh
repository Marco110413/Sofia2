#!/bin/bash

# Función para actualizar el archivo README.md
actualizar_readme() {
    echo "Actualizando el archivo README.md..."
    cat <<EOF > README.md
# Sofia2 - Proyecto de inteligencia artificial y reconocimiento de voz

Este proyecto tiene como objetivo crear una aplicación que implemente un sistema de reconocimiento de voz y otras funcionalidades de inteligencia artificial.

## Requisitos

- Python 3.x
- SpeechRecognition
- PyAudio

## Instalación

1. Clona este repositorio
2. Instala las dependencias con `pip install -r requirements.txt`
3. Ejecuta el script `src/recognition_script.py` para probar el reconocimiento de voz.

EOF
    echo "README.md actualizado."
}

# Función para actualizar el archivo requirements.txt
actualizar_requisitos() {
    echo "Actualizando el archivo requirements.txt..."
    cat <<EOF > requirements.txt
SpeechRecognition==3.14.1
PyAudio==0.2.14
EOF
    echo "requirements.txt actualizado."
}

# Función para verificar y actualizar el script de reconocimiento de voz
actualizar_script_reconocimiento() {
    echo "Actualizando el script de reconocimiento de voz..."
    cat <<EOF > src/recognition_script.py
import speech_recognition as sr

def escuchar_comando():
    recognizer = sr.Recognizer()
    with sr.Microphone() as source:
        print("Escuchando... di algo:")
        audio = recognizer.listen(source)
        print("Reconociendo...")
        try:
            comando = recognizer.recognize_google(audio, language="es-ES")
            print(f"Comando reconocido: {comando}")
            return comando
        except sr.UnknownValueError:
            print("No pude entender lo que dijiste.")
            return None
        except sr.RequestError:
            print("Error al conectar con el servicio de reconocimiento de voz.")
            return None

if __name__ == "__main__":
    while True:
        comando = escuchar_comando()
        if comando:
            print(f"Comando recibido: {comando}")
EOF
    echo "script de reconocimiento de voz actualizado."
}

# Llamando las funciones para actualizar los archivos
actualizar_readme
actualizar_requisitos
actualizar_script_reconocimiento

# Commit y push al repositorio de GitHub
echo "Agregando, haciendo commit y subiendo los cambios al repositorio..."
git add .
git commit -m "Actualización de README, requirements.txt y script de reconocimiento de voz"
git push origin main

echo "Proceso completado con éxito."
