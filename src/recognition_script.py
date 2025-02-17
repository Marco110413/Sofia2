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
