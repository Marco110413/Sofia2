#!/bin/bash

echo "🔄 Iniciando pruebas automáticas del Gestor de Proyectos..."

# Ejecutar el gestor en segundo plano y enviar comandos automáticamente
{
    echo "1"  # Crear un proyecto
    echo "Proyecto_Prueba"  # Nombre del proyecto
    sleep 2  

    echo "2"  # Ir a "Gestionar proyectos"
    sleep 2  

    echo "21"  # Mostrar proyectos disponibles
    sleep 2  

    echo "25"  # Buscar un proyecto
    echo "Proyecto_Prueba"  # Buscar proyecto creado
    sleep 2  

    echo "24"  # Renombrar proyecto
    echo "Proyecto_Prueba"  # Nombre actual
    echo "Proyecto_Renombrado"  # Nuevo nombre
    sleep 2  

    echo "25"  # Buscar proyecto renombrado
    echo "Proyecto_Renombrado"
    sleep 2  

    echo "23"  # Eliminar proyecto
    echo "Proyecto_Renombrado"
    sleep 2  

    echo "21"  # Mostrar proyectos después de eliminar
    sleep 2  

    echo "0"  # Salir del gestor
} | ./gestor_proyectos.sh  

echo "✅ Pruebas completadas. Verifica los resultados en pantalla."
