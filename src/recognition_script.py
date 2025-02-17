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
