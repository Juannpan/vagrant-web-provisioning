#!/usr/bin/env bash

# Actualizar paquetes
sudo apt-get update -y

# Instalar Apache, PHP y el driver de PostgreSQL para PHP
sudo apt-get install -y apache2 php libapache2-mod-php php-pgsql

# Habilitar Apache al inicio
sudo systemctl enable apache2
sudo systemctl start apache2

# Copiar archivos del proyecto (carpeta compartida Vagrant)
sudo cp -r /vagrant/www/* /var/www/html/

# Dar permisos
sudo chown -R www-data:www-data /var/www/html

# Reiniciar Apache para cargar el módulo PostgreSQL
sudo systemctl restart apache2

# Verificar que el módulo PostgreSQL está cargado
echo "Verificando instalación de php-pgsql:"
php -m | grep pgsql || echo "ADVERTENCIA: php-pgsql no se cargó correctamente"
