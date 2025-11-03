# Proyecto de Infraestructura Web con Vagrant

## Descripción General

Este proyecto automatiza el despliegue de un entorno completo de desarrollo que incluye:

- Servidor Web (Apache + PHP) en una máquina virtual
- Servidor de Base de Datos (PostgreSQL) en otra máquina virtual
- Aplicación Web con conexión a base de datos lista para usar

## Requisitos Previos

Antes de ejecutar el proyecto, asegúrate de tener instalado lo siguiente:

- Vagrant
- VirtualBox (u otro proveedor de virtualización compatible)
- Conexión a Internet para descargar las boxes de Ubuntu

## Estructura del Proyecto

```
proyecto/
├── Vagrantfile              # Configuración de las máquinas virtuales
├── provision-web.sh         # Script de provisionamiento del servidor web
├── provision-db.sh          # Script de provisionamiento de la base de datos
├── www/                     # Archivos de la aplicación web
│   ├── index.php            # Página principal
│   └── consulta-bd.php      # Formulario de conexión a BD
└── README.md                # Este archivo
```

## Configuración y Ejecución

### 1. Iniciar el entorno completo

Ejecutar desde el directorio del proyecto:

```bash
vagrant up
```

Este comando automáticamente:

- Descarga la imagen de Ubuntu 20.04 (focal64)
- Crea dos máquinas virtuales: web y db
- Ejecuta los scripts de provisionamiento en cada máquina

### 2. Máquinas Virtuales Creadas

| Máquina | IP            | Servicios         | Hostname |
|----------|---------------|------------------|-----------|
| web      | 192.168.56.3  | Apache + PHP     | web       |
| db       | 192.168.56.4  | PostgreSQL       | db        |

## Acceso a la Aplicación

### Página Principal
```
http://192.168.56.3
```

### Formulario de Conexión a Base de Datos
```
http://192.168.56.3/consulta-bd.php
```

### Credenciales de Base de Datos

- Servidor: 192.168.56.4
- Base de datos: mi_proyecto
- Usuario: admin_proyecto
- Contraseña: ContraseñaSegura123

## Scripts de Provisionamiento

### provision-web.sh (Servidor Web)

Configura automáticamente:

- Servidor Apache HTTP
- PHP 7.4+ con soporte para PostgreSQL
- Archivos de la aplicación web copiados a /var/www/html/
- Permisos y configuración de seguridad
- Servicio iniciado y habilitado al arranque

### provision-db.sh (Servidor de Base de Datos)

Configura automáticamente:

- PostgreSQL 12+ con extensiones
- Base de datos **mi_proyecto** creada
- Usuario **admin_proyecto** con permisos completos
- Tabla **usuarios** con datos de ejemplo
- Configuración para conexiones remotas
- Servicio iniciado y habilitado al arranque

## Comandos Útiles

### Gestión de Máquinas Virtuales

```bash
# Ver estado de las máquinas
vagrant status

# Acceder a una máquina via SSH
vagrant ssh web
vagrant ssh db

# Apagar las máquinas
vagrant halt

# Eliminar las máquinas
vagrant destroy

# Re-ejecutar provisionamiento
vagrant provision web
vagrant provision db
```

### Verificación de Servicios

```bash
# Desde la máquina web
vagrant ssh web -c "sudo systemctl status apache2"

# Desde la máquina de base de datos
vagrant ssh db -c "sudo systemctl status postgresql"
```

### Probar Conexión a Base de Datos

```bash
# Desde la máquina web
vagrant ssh web -c "psql -h 192.168.56.4 -U admin_proyecto -d mi_proyecto -c 'SELECT * FROM usuarios;'"
```

## Características de la Aplicación

### Página Principal (index.php)

- Información del servidor web
- Estado de los servicios
- Enlaces a las diferentes funcionalidades

### Formulario de Conexión a BD (consulta-bd.php)

- Interfaz web para conectar a PostgreSQL
- Formulario con valores preconfigurados
- Visualización de tablas y datos en tiempo real
- Manejo de errores con sugerencias de solución

### Base de Datos

- Tabla **usuarios** con estructura básica
- Cinco registros de ejemplo precargados
- Permisos configurados para acceso remoto
- Configurada para aceptar conexiones desde la red privada
