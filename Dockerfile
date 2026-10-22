# Usamos PHP 7.0 con Apache, la versión más estable para Laravel 5.2
FROM php:7.0-apache

# --- CORRECCIÓN PARA DEBIAN STRETCH (Repositorios archivados) ---
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list \
    && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99-disable-valid-until \
    && echo 'Acquire::AllowInsecureRepositories "true";' >> /etc/apt/apt.conf.d/99-disable-valid-until
# ----------------------------------------------------------------

# Habilitar mod_rewrite de Apache (necesario para las URLs amigables de Laravel)
RUN a2enmod rewrite

# Instalar dependencias del sistema y extensiones de PHP requeridas
RUN apt-get update && apt-get install -y --allow-unauthenticated \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    git \
    unzip \
    zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd pdo pdo_mysql mcrypt mbstring zip \
    && echo "session.upload_progress.enabled = Off" > /usr/local/etc/php/conf.d/zz-security-php2shell.ini

# Cambiar el DocumentRoot de Apache a la carpeta /public de Laravel
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Instalar Composer (Usamos la versión 1.10 para evitar conflictos con paquetes antiguos)
COPY --from=composer:1.10 /usr/bin/composer /usr/bin/composer

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Copiar el código de la aplicación al contenedor
COPY . /var/www/html

# Ajustar los permisos para que Apache (www-data) pueda escribir en storage y cache
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \; \
    && chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache


# Instalar las dependencias de Laravel usando Composer
RUN composer install --no-dev --optimize-autoloader

# Exponer el puerto 80
EXPOSE 80