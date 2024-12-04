# Usa una imagen base oficial de PHP con FPM
FROM php:7.3-fpm

# Instalar dependencias necesarias y extensiones PHP
RUN apt-get update && apt-get install -y \
    libpng-dev \
    zip \
    unzip \
    git \
    curl \
    libonig-dev \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring zip

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Establecer el directorio de trabajo en el contenedor
WORKDIR /var/www

# Copiar todos los archivos del proyecto al contenedorrr
COPY . .

# Crear un archivo .env temporal para Composer
RUN cp .env.example .env

# Otorgar permisos a las carpetas necesarias para Laravel
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Instalar dependencias de Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Eliminar el archivo .env temporal
RUN rm .env

# Exponer el puerto 9000 para PHP-FPM
EXPOSE 9000

# Ejecutar PHP-FPM
CMD ["php-fpm"]
