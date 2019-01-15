# c3270 Web

Este projeto permite acessar o terminal c3270 por uma interface web.

Baseado no projeto Wetty https://github.com/krishnasrinivas/wetty

## FAQ
### Como posso testar?

Use o Docker para baixar a imagem e executar um container para testes.

- Baixe a imagem executando o docker pull:
```shell
docker pull seniocaires/c3270-web
```
- Para iniciar um container da imagem recém baixada:
```shell
docker run --rm -e USUARIO=usuario -e SENHA=senha -e HOST=host.acesso.com.br -e PORTA=12789 -e CONTEXTO=/terminal seniocaires/c3270-web
```

### Quais parâmetros são necessários (variáveis de ambiente)?
 - USUARIO : Nome do usuário que será criado para executar o c3270.
 - SENHA : Senha do usuário.
 - HOST : Host que o c3270 irá acessar.
 - PORTA : Porta do Host que o c3270 irá acessar.
 - CONTEXTO: Context Path da aplicação