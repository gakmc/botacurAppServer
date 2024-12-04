# Usa una imagen base oficial de PHP con FPM
FROM php:7.3.20-fpm

# Instalar dependencias del sistema, Nginx y otros paquetes
RUN apt-get update && apt-get install -y \
    nginx \
    libpng-dev \
    zip \
    unzip \
    git \
    curl \
    supervisor

# Instalar Node.js (versión LTS, actualmente v18)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Verificar la instalación de Node.js y npm
RUN node -v && npm -v

# Configurar Nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Establecer el directorio de trabajo en el contenedor
WORKDIR /var/www

# Copiar todos los archivos del proyecto al contenedor
COPY . .

# Otorgar permisos a las carpetas necesarias para Laravel
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Instalar dependencias de Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Instalar dependencias de npm
RUN npm install

# Compilar los assets con Laravel Mix (modo producción)
RUN npm run production

# Copiar el archivo de configuración de supervisord
COPY supervisord.conf /etc/supervisord.conf

# Exponer el puerto 80 para Nginx
EXPOSE 9000

# Ejecutar Supervisor para manejar Nginx y PHP-FPM
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
