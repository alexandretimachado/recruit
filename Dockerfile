# Usar uma imagem base com PHP e Composer
FROM php:8.1-fpm

# Define o diretório de trabalho
WORKDIR /var/www/html

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libicu-dev \ 
    libzip-dev    # Necessário para a extensão zip

# Limpa o cache do apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala extensões do PHP necessárias para o Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd intl zip

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia os arquivos do projeto para o container
COPY . .

# Configura o Git para ignorar problemas de permissão
RUN git config --global --add safe.directory /var/www/html

# Instala as dependências do Composer
RUN composer install --optimize-autoloader --no-dev

# Expõe a porta 9000 (porta padrão do PHP-FPM)
EXPOSE 9000

# Comando para rodar o servidor PHP-FPM
CMD ["php-fpm"]