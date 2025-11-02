#!/usr/bin/env bash

# setup-simple-table.sh - Script para crear tabla básica con datos genéricos

# Verificar que se proporcionen todos los parámetros necesarios
if [ $# -lt 3 ]; then
    echo "Error: Debes proporcionar todos los parámetros requeridos"
    echo "Uso: $0 <nombre_bd> <usuario> <contraseña>"
    echo "Ejemplo: ./setup-simple-table.sh mi_bd mi_usuario mi_contraseña"
    exit 1
fi

# Parámetros requeridos
DB_NAME=$1
DB_USER=$2
DB_PASS=$3

echo "=========================================="
echo "Creando tabla básica en: $DB_NAME"
echo "=========================================="

# Exportar contraseña para psql
export PGPASSWORD=$DB_PASS

# Crear tabla e insertar datos
sudo -u postgres psql -d $DB_NAME -U $DB_USER << EOF
-- Crear tabla de usuarios básica
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro DATE DEFAULT CURRENT_DATE
);

-- Insertar datos de ejemplo
INSERT INTO usuarios (nombre, email) VALUES
    ('Usuario Ejemplo 1', 'usuario1@ejemplo.com'),
    ('Usuario Ejemplo 2', 'usuario2@ejemplo.com'),
    ('Usuario Ejemplo 3', 'usuario3@ejemplo.com')
ON CONFLICT (email) DO NOTHING;

-- Mostrar los datos insertados
SELECT * FROM usuarios;
EOF

# Limpiar variable de entorno
unset PGPASSWORD

echo "=========================================="
echo "Tabla básica creada exitosamente"
echo "Base de datos: $DB_NAME"
echo "Tabla: usuarios"
echo "=========================================="
