# Usa una imagen base de PHP 7.3 con Apache
FROM php:7.3-apache

# Instala extensiones requeridas por Laravel
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    curl \
    git \
    && docker-php-ext-install zip pdo pdo_mysql

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia los archivos de la aplicación
COPY . /var/www/html

# Establece permisos
RUN chown -R www-data:www-data /var/www/html

# Habilita mod_rewrite para Laravel
RUN a2enmod rewrite

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Instala dependencias de Composer
RUN composer install --no-dev --optimize-autoloader


# Establece los permisos para las carpetas de almacenamiento y caché
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Otorgar permisos a las carpetas necesarias para Laravel
RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

# Instalar dependencias de Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Eliminar el archivo .env temporal
# RUN rm .env

# Exponer puerto 80
EXPOSE 80

# Comando de inicio
CMD ["apache2-foreground"]