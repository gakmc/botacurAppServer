# Usa una imagen base oficial de PHP con FPM
FROM php:7.3-apache

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

# Copia los archivos de la app
COPY . /var/www/html

# Habilita mod_rewrite
RUN a2enmod rewrite

# Copiar todos los archivos del proyecto al contenedor
COPY . .

# Crear un archivo .env temporal para Composer
RUN cp .env.example .env

# Establece el directorio de trabajo
WORKDIR /var/www/html
RUN php artisan key:generate

# Otorgar permisos a las carpetas necesarias para Laravel
RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Instalar dependencias de Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Eliminar el archivo .env temporal
RUN rm .env

# Exponer el puerto 9000 para PHP-FPM
EXPOSE 80
