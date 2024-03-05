FROM php:8.3-alpine3.19 as base

RUN apk add libstdc++

WORKDIR /app

EXPOSE 9501


FROM php:8.3-alpine3.19 as build

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
# Extensiosa are saved /usr/local/lib
RUN install-php-extensions swoole pcntl

# Instala dependencias do projeto
# As dependencias do projeto são coladas numa pasta chamada
COPY hyperf-skeleton/composer.* ./
RUN composer install --no-dev

FROM base as development

# Composer continua sendo necessário para ambiente de desenvolvimento
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Copia as exetensões do PHP
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /app/vendor /app/vendor

# Ativar as extensões do PHP
RUN docker-php-ext-enable swoole pcntl

COPY hyperf-skeleton/composer.* ./
RUN composer install

# Comando para iniciar o servidor
CMD ["php", "hyperf-skeleton/bin/hyperf.php", "start"]

FROM base as production

# Copia as exetensões do PHP
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /app/vendor /app/vendor

# Ativar as extensões do PHP
RUN docker-php-ext-enable swoole pcntl

# Comando para iniciar o servidor
CMD ["php", "hyperf-skeleton/bin/hyperf.php", "start"]
