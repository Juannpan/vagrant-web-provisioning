#!/usr/bin/env bash

# provision-db.sh - Script para provisionar PostgreSQL con schema incluido

# Verificar que se proporcionen todos los parámetros necesarios
if [ $# -lt 3 ]; then
    echo "Error: Debes proporcionar todos los parámetros requeridos"
    echo "Uso: $0 <nombre_bd> <usuario> <contraseña>"
    echo "Ejemplo: ./provision-db.sh mi_bd mi_usuario mi_contraseña"
    exit 1
fi

# Parámetros requeridos
DB_NAME=$1
DB_USER=$2
DB_PASS=$3

echo "=========================================="
echo "Configurando PostgreSQL con:"
echo "Base de datos: $DB_NAME"
echo "Usuario: $DB_USER"
echo "=========================================="

# Actualizar paquetes
sudo apt-get update -y

# Instalar PostgreSQL
sudo apt-get install -y postgresql postgresql-contrib

# Habilitar e iniciar PostgreSQL
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Crear base de datos y usuario
sudo -u postgres psql -c "CREATE DATABASE $DB_NAME;"
sudo -u postgres psql -c "CREATE USER $DB_USER WITH PASSWORD '$DB_PASS';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;"

# Configurar PostgreSQL para aceptar conexiones
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf
echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf

# Reiniciar PostgreSQL para aplicar cambios
sudo systemctl restart postgresql

# ==========================================
# CREAR SCHEMA Y TABLAS
# ==========================================
echo "Creando schema y tablas..."

export PGPASSWORD=$DB_PASS

# Crear tabla e insertar datos
sudo -u postgres psql -d $DB_NAME << EOF
-- Crear tabla de usuarios básica
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro DATE DEFAULT CURRENT_DATE
);

-- Insertar datos de ejemplo
INSERT INTO usuarios (nombre, email) VALUES
    ('Juan Pérez', 'juan.perez@ejemplo.com'),
    ('María García', 'maria.garcia@ejemplo.com'),
    ('Carlos López', 'carlos.lopez@ejemplo.com'),
    ('Ana Martínez', 'ana.martinez@ejemplo.com'),
    ('Pedro Rodríguez', 'pedro.rodriguez@ejemplo.com')
ON CONFLICT (email) DO NOTHING;

-- OTORGAR PERMISOS EXPLÍCITOS EN LAS TABLAS
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $DB_USER;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $DB_USER;
GRANT USAGE ON SCHEMA public TO $DB_USER;

-- Configurar permisos por defecto para futuras tablas
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO $DB_USER;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO $DB_USER;

-- Mostrar los datos insertados
SELECT 'Tabla creada exitosamente' as mensaje;
SELECT COUNT(*) as total_usuarios FROM usuarios;
EOF

unset PGPASSWORD

# Mostrar información final
echo "=========================================="
echo "PostgreSQL instalado y configurado"
echo "Schema y tablas creados"
echo "Permisos otorgados al usuario"
echo "Base de datos: $DB_NAME"
echo "Usuario: $DB_USER"
echo "Password: $DB_PASS"
echo "Tabla creada: usuarios (con 5 registros de ejemplo)"
echo "=========================================="
