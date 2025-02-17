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
