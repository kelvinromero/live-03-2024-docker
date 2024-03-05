# Imagem base
FROM php:8.3-alpine3.19

# Copiar o binário do composer para meu container
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Adicional script instalador de extensões do PHP
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Workdir - Diretório de onde começo os trabalhos
WORKDIR /app

# instala extensões do PHP
# Bibliotecas de build + Arquivos Build
# SO + Runetime Deps
# No php as extensões são arquivos .so
RUN install-php-extensions swoole pcntl

# Instala dependencias do projeto
COPY hyperf-skeleton/composer.* ./
RUN composer install --no-dev

# Expoe a porta 9501
EXPOSE 9501

# Comando para iniciar o servidor
CMD ["php", "hyperf-skeleton/bin/hyperf.php", "start"]
