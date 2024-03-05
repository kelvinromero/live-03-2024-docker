# Live 04/03/2024 - Dúvidas sobre Docker
## Do básico a otimiações na construção de imagens

### Básico
- Como que eu iniciar um projeto do zero sem precisar instalar nada na minha máquina?

#### Docker Run
A primeira forma que você pode fazer é utilizando um container qualquer da linguagem desejada
Mapeando um volume do diretório corrente para dentro do container:
```bash
docker run --name hyperf \
-v ${PWD}:/data/project \
-p 9501:9501 -it \
--privileged -u root \
--entrypoint /bin/sh \
hyperf/hyperf:8.1-alpine-v3.18-swoole
```
Esse comando acima ele cria o projeto e por utilizar um volume, todos os arquivos vão ser copiados para seu host.


#### Docker Compose
Ou melhor ainda, usando um docker-compose e depois executando um comando:
```
docker compose run --rm app sh
```
Com base no docker-compose.yml a gente consegue mapear os parametros que antes precisaríoamos digitar.

### Multi-stage build

- O que é?
- As principais vantagens

### Otimizando as imagens para produção

- O que a imagem de produção precisa ter?

### Melhorando a vida do Dev
- Makefile