import speech_recognition as sr

# Funciones de clasificación de comandos
def is_greeting(command):
    greetings = ["hola", "buenos días", "buenas tardes", "buenas noches", "hey", "¿cómo estás?"]
    for greeting in greetings:
        if greeting in command.lower():
            return True
    return False

def is_question(command):
    question_words = ["qué", "cómo", "por qué", "quién", "cuándo", "dónde", "cuál"]
    if '?' in command or any(word in command.lower() for word in question_words):
        return True
    return False

def is_conversation(command):
    if not is_greeting(command) and not is_question(command):
        return True
    return False

def process_command(command):
    if is_greeting(command):
        print("¡Hola! ¿Cómo puedo ayudarte hoy?")
    elif is_question(command):
        print("Esta es una pregunta. Respondiendo...")
        if "cómo estás" in command.lower():
            print("Estoy bien, gracias por preguntar.")
        elif "qué haces" in command.lower():
            print("Estoy aquí para ayudarte con lo que necesites.")
    elif is_conversation(command):
        print("Parece que estás hablando conmigo. ¿De qué te gustaría hablar?")
    else:
        print("No estoy seguro de lo que estás diciendo. ¿Puedes reformularlo?")

# Configuración del reconocimiento de voz
r = sr.Recognizer()
mic = sr.Microphone()

def recognize_speech():
    print("Escuchando... di algo:")
    with mic as source:
        r.adjust_for_ambient_noise(source)
        audio = r.listen(source)

    try:
        command = r.recognize_google(audio, language='es-ES')
        print(f"Comando reconocido: {command}")
        process_command(command)
    except sr.UnknownValueError:
        print("No pude entender lo que dijiste.")
    except sr.RequestError:
        print("Error al conectar con el servicio de reconocimiento de voz.")
