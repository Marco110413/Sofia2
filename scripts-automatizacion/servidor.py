from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Servidor Flask en Termux está corriendo correctamente."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
