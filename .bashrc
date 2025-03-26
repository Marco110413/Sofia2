# Mensaje de bienvenida
echo "Bienvenido a Termux - Configuración limpia y optimizada"

# Configurar variables de entorno desde un archivo separado
if [ -f ~/.env ]; then
  source ~/.env
fi

# Configurar Pyenv si está instalado
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"

# Ejecutar scripts de automatización (descomentar si es necesario)
# bash ~/scripts-automatizacion/subir_scripts.sh
# bash ~/subir_todo_git.sh
# bash ~/gestor_proyectos.sh

# Mantener activo un script en segundo plano si es necesario
# nohup bash ~/monitor.sh & disown
# Restaurar automatización de scripts
bash ~/scripts-automatizacion/subir_scripts.sh
bash ~/subir_todo_git.sh
nohup bash ~/monitor.sh & disown
