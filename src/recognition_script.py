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
