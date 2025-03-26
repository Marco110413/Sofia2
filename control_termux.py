import paramiko

# Configuración de conexión SSH
host = "localhost"   # Usamos localhost porque estamos en el mismo móvil
port = 8022          # Puerto SSH de Termux
username = "u0_a286" # Usuario obtenido con whoami
password = None      # Si usas clave SSH, déjalo en None

# Crear cliente SSH
client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

try:
    print("[+] Conectando a Termux...")
    client.connect(host, port=port, username=username, password=password)
    
    # Ejecutar un comando de prueba
    stdin, stdout, stderr = client.exec_command("ls ~")
    print("[+] Archivos en el home de Termux:")
    print(stdout.read().decode())

except Exception as e:
    print(f"[-] Error: {e}")

finally:
    client.close()
