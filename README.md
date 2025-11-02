# Taller Vagrant + Provisionamiento con Shell

## Pasos
1. Clonar este repositorio.  
2. Ejecutar `vagrant up` para levantar las máquinas.  
3. Acceder a la máquina web en: http://192.168.56.10  
4. Verificar `index.html` y `info.php`.  

## Reto
- Completar `provision-db.sh` para instalar PostgreSQL.  
- Crear una base de datos y tabla.  
- Conectar la página PHP a la base de datos y mostrar datos.  

## Scripts de Provisionamiento

### Orden de Ejecución
Ejecutar los scripts en el siguiente orden:

1. **provision-web.sh** - Servidor web  
2. **provision-db.sh** - Base de datos  
3. **setup-simple-table.sh** - Estructura de datos  

### Scripts Disponibles

#### 1. provision-web.sh
**Propósito:** Configura el servidor web con Apache y PHP.  

**Funcionalidades:**
- Actualiza los paquetes del sistema.  
- Instala Apache y PHP.  
- Habilita e inicia el servicio Apache.  
- Copia archivos del proyecto al directorio web.  
- Configura permisos adecuados.  

**Uso:**
```bash
chmod +x provision-web.sh
sudo ./provision-web.sh
```

#### 2. provision-db.sh
**Propósito:** Instala y configura PostgreSQL.  

**Funcionalidades:**
- Instala PostgreSQL y componentes adicionales.  
- Configura el servicio para inicio automático.  
- Crea base de datos y usuario personalizados.  
- Configura acceso remoto.  
- Abre puerto 5432 en el firewall.  

**Uso:**
```bash
chmod +x provision-db.sh
sudo ./provision-db.sh <nombre_bd> <usuario> <contraseña>
```

**Ejemplo:**
```bash
sudo ./provision-db.sh mi_proyecto admin_proyecto ContraseñaSegura123
```

**Parámetros requeridos:**
- nombre_bd: Nombre de la base de datos.  
- usuario: Usuario de la base de datos.  
- contraseña: Contraseña del usuario.  

#### 3. setup-simple-table.sh
**Propósito:** Crea estructura básica de datos con tabla de ejemplo.  

**Funcionalidades:**
- Crea tabla `usuarios` con estructura básica.  
- Inserta datos genéricos de ejemplo.  
- Muestra confirmación de los datos insertados.  

**Uso:**
```bash
chmod +x setup-simple-table.sh
sudo ./setup-simple-table.sh <nombre_bd> <usuario> <contraseña>
```

**Ejemplo:**
```bash
sudo ./setup-simple-table.sh mi_proyecto admin_proyecto ContraseñaSegura123
```

**Parámetros requeridos:**
- nombre_bd: Mismo nombre usado en `provision-db.sh`.  
- usuario: Mismo usuario usado en `provision-db.sh`.  
- contraseña: Misma contraseña usada en `provision-db.sh`.  

### Flujo Completo de Ejecución
```bash
# 1. Configurar servidor web
sudo ./provision-web.sh

# 2. Configurar base de datos
sudo ./provision-db.sh mi_proyecto admin_proyecto MiContraseñaSegura

# 3. Crear estructura de datos
sudo ./setup-simple-table.sh mi_proyecto admin_proyecto MiContraseñaSegura
```

### Notas Importantes
- Ejecutar los scripts en orden secuencial.  
- No hay valores por defecto para contraseñas.  
- Usar los mismos credenciales en `provision-db.sh` y `setup-simple-table.sh`.  
- Los scripts requieren permisos de superusuario (`sudo`).  
