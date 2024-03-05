# Live 04/03/2024 - Dúvidas sobre Docker
## Do básico a otimiações na construção de imagens

### Básico
- Como que eu starto um projeto sem precisar instalar nada na minha máquina?

### Exemplo HyperF
```bash
docker run --name hyperf \
-v ${PWD}:/data/project \
-p 9501:9501 -it \
--privileged -u root \
--entrypoint /bin/sh \
hyperf/hyperf:8.1-alpine-v3.18-swoole
```

### Multi-stage build

- O que é?
- As principais vantagens

### Otimizando as imagens para produção

- O que a imagem de produção precisa ter?

### Melhorando a vida do Dev
- Makefile