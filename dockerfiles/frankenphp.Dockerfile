
# 1. FrankenPHP image'dan foydalanamiz (PHP + Caddy + Fast server)
FROM dunglas/frankenphp:latest

# 2. Sistemani yangilaymiz va kerakli kutubxonalarni o‘rnatamiz
RUN apt-get update && apt-get install -y \
    libpq-dev \
    zip unzip \
    git curl \
    libzip-dev \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
    libfreetype6-dev \
    libicu-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install gd \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && docker-php-ext-install intl

# Ishlashini tezlashtirgani 
RUN docker-php-ext-install opcache \
    && echo "opcache.enable=1\nopcache.enable_cli=1\nopcache.memory_consumption=128\nopcache.validate_timestamps=0" > /usr/local/etc/php/conf.d/opcache.ini

# 3. Composer o‘rnatish (alohida image'dan nusxalash orqali)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY ./Caddyfile /etc/frankenphp/Caddyfile

# 4. Ishchi katalog
WORKDIR /app

# 5. Laravel uchun qo‘shimcha extensionlar (ixtiyoriy)
# RUN docker-php-ext-install bcmath mbstring

# 6. Timezone o‘rnatish (ixtiyoriy, foydali cron va log uchun)
ENV TZ=Asia/Tashkent

# 7. Laravel fayllarini konteynerga ko‘chirish (docker-compose'da bind mount qilinsa bu qadam shart emas)
# COPY . .

# 8. Tarmoq portlarini ochish (HTTP, HTTPS, WebSocket)
EXPOSE 80 443 6001
