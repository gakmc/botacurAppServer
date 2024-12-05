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

RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia los archivos de la aplicación
WORKDIR /var/www/html
COPY . .

# Establece permisos correctos (una vez)
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 storage bootstrap/cache

# Instala dependencias de Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Habilita mod_rewrite para Laravel
RUN a2enmod rewrite


# Exponer puerto 80
EXPOSE 80

# Comando de inicio
CMD ["apache2-foreground"]