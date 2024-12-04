# Usa una imagen base oficial de PHP con FPM
FROM php:7.3.20-fpm

# Instalar dependencias del sistema y extensiones PHP necesarias para Laravel
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    zip \
    unzip \
    git \
    curl \
    nginx

# Configurar Nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Establecer el directorio de trabajo
WORKDIR /var/www

# Copiar los archivos del proyecto al contenedor
COPY . .

# Otorgar permisos a las carpetas necesarias para Laravel
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Instalar dependencias de Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Generar la clave de la aplicación Laravel
RUN php artisan key:generate

# Exponer el puerto 80 para Nginx
EXPOSE 80

# Ejecutar Nginx y PHP-FPM en primer plano
CMD service nginx start && php-fpm
