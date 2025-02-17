# Sofia2 - Proyecto de inteligencia artificial y reconocimiento de voz

Este proyecto tiene como objetivo crear una aplicación que implemente un sistema de reconocimiento de voz y otras funcionalidades de inteligencia artificial.

## Requisitos

- Python 3.x
- SpeechRecognition
- PyAudio

## Instalación

1. Clona este repositorio
2. Instala las dependencias con Requirement already satisfied: SpeechRecognition==3.14.1 in /data/data/com.termux/files/usr/lib/python3.12/site-packages (from -r requirements.txt (line 1)) (3.14.1)
Requirement already satisfied: pyaudio==0.2.14 in /data/data/com.termux/files/usr/lib/python3.12/site-packages (from -r requirements.txt (line 2)) (0.2.14)
Collecting pyttsx3==2.90 (from -r requirements.txt (line 4))
  Downloading pyttsx3-2.90-py3-none-any.whl.metadata (3.6 kB)
Collecting requests==2.28.2 (from -r requirements.txt (line 5))
  Downloading requests-2.28.2-py3-none-any.whl.metadata (4.6 kB)
Requirement already satisfied: typing-extensions in /data/data/com.termux/files/usr/lib/python3.12/site-packages (from SpeechRecognition==3.14.1->-r requirements.txt (line 1)) (4.12.2)
Requirement already satisfied: charset-normalizer<4,>=2 in /data/data/com.termux/files/usr/lib/python3.12/site-packages (from requests==2.28.2->-r requirements.txt (line 5)) (3.4.1)
Requirement already satisfied: idna<4,>=2.5 in /data/data/com.termux/files/usr/lib/python3.12/site-packages (from requests==2.28.2->-r requirements.txt (line 5)) (3.10)
Collecting urllib3<1.27,>=1.21.1 (from requests==2.28.2->-r requirements.txt (line 5))
  Downloading urllib3-1.26.20-py2.py3-none-any.whl.metadata (50 kB)
Requirement already satisfied: certifi>=2017.4.17 in /data/data/com.termux/files/usr/lib/python3.12/site-packages (from requests==2.28.2->-r requirements.txt (line 5)) (2025.1.31)
Downloading pyttsx3-2.90-py3-none-any.whl (39 kB)
Downloading requests-2.28.2-py3-none-any.whl (62 kB)
Downloading urllib3-1.26.20-py2.py3-none-any.whl (144 kB)
Installing collected packages: pyttsx3, urllib3, requests
  Attempting uninstall: urllib3
    Found existing installation: urllib3 2.3.0
    Uninstalling urllib3-2.3.0:
      Successfully uninstalled urllib3-2.3.0
  Attempting uninstall: requests
    Found existing installation: requests 2.32.3
    Uninstalling requests-2.32.3:
      Successfully uninstalled requests-2.32.3
Successfully installed pyttsx3-2.90 requests-2.28.2 urllib3-1.26.20
3. Ejecuta el script  para probar el reconocimiento de voz.

