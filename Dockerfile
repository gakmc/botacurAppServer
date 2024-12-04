# Usa una imagen base oficial de PHP con FPM (para Laravel)
FROM php:7.3.20-fpm

# Instalar las dependencias necesarias del sistema operativo
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl

# Instalar extensiones de PHP necesarias para Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Composer (copiarlo desde la imagen oficial de Composer)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Establecer el directorio de trabajo en el contenedor
WORKDIR /var/www

# Copiar todos los archivos de tu proyecto al contenedor
COPY . .

# Copiar el archivo de ejemplo .env como .env
COPY .env.example .env

# Dar permisos a las carpetas storage y bootstrap/cache (necesarias para Laravel)
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Instalar las dependencias de Composer (sin scripts para evitar errores)
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Generar la clave de la aplicación Laravel
RUN php artisan key:generate

# Exponer el puerto para la aplicación (PHP-FPM usa 9000)
EXPOSE 9000

# Iniciar el servidor PHP-FPM
CMD ["php-fpm"]
