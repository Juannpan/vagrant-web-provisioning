#!/usr/bin/env bash

# provision-db.sh - Script con valores por defecto y parámetros opcionales

# Valores por defecto
DB_NAME=${1:-mi_app_db}
DB_USER=${2:-mi_app_user}
DB_PASS=${3:-$(openssl rand -base64 12)}

echo "=========================================="
echo "Configurando PostgreSQL con:"
echo "Base de datos: $DB_NAME"
echo "Usuario: $DB_USER"
echo "=========================================="

# Resto del script igual...
sudo apt-get update -y
sudo apt-get install -y postgresql postgresql-contrib

sudo systemctl enable postgresql
sudo systemctl start postgresql

sudo -u postgres psql -c "CREATE DATABASE $DB_NAME;"
sudo -u postgres psql -c "CREATE USER $DB_USER WITH PASSWORD '$DB_PASS';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;"

sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf
echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf

sudo systemctl restart postgresql

echo "=========================================="
echo "PostgreSQL instalado y configurado"
echo "Base de datos: $DB_NAME"
echo "Usuario: $DB_USER"
echo "Password: $DB_PASS"
echo "=========================================="
