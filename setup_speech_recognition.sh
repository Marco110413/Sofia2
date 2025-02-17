#!/bin/bash

# Paso 1: Instalar dependencias necesarias
echo "Instalando dependencias necesarias..."
pip install SpeechRecognition
pip install pyaudio  # Para manejar entrada de micrófono

# Paso 2: Crear el archivo 'speech_recognition.py' si no existe
echo "Creando el script para reconocimiento de voz..."

cat > src/speech_recognition.py <<EOL
import speech_recognition as sr

def escuchar_comando():
    # Inicializamos el reconocedor
    recognizer = sr.Recognizer()

    # Usamos el micrófono como fuente
    with sr.Microphone() as source:
        print("Escuchando... di algo:")
        recognizer.adjust_for_ambient_noise(source)  # Ajuste de ruido ambiental
        audio = recognizer.listen(source)

    # Intentamos reconocer lo que se dijo
    try:
        print("Reconociendo...")
        comando = recognizer.recognize_google(audio, language="es-ES")  # Usamos Google para reconocer
        print("Comando reconocido: ", comando)
        return comando
    except sr.UnknownValueError:
        print("No pude entender lo que dijiste.")
    except sr.RequestError:
        print("Error con el servicio de Google.")
   
if __name__ == "__main__":
    while True:
        comando = escuchar_comando()
        if comando:
            print(f"Comando recibido: {comando}")
        else:
            break
EOL

echo "El script 'speech_recognition.py' ha sido creado en la carpeta 'src'."

# Paso 3: Ejecutar el script de reconocimiento de voz
echo "Ejecutando el script para probar el reconocimiento de voz..."
python src/speech_recognition.py
