# Projeto feito utilizando Golang, Github Actions, Terraform e AWS Lambda

Esse projeto foi criando apenas com o intuito de estudos.

## Qual a idéia? 🤯
Criar uma Lambda utilizando Golang e a arquitetura ARM64. Como a AWS está depreciando o runtime go1.x, decidir fazer o teste utilizando provided.al2 com a arquitetura ARM64.

## Compilando a Lambda para o runtime provided.al2 e a arquitetura ARM64
Como foi utilizando o runtime provided.al2 e a arquitetura ARM64, o build do Go tem que ser feito utilizando os seguintes parametros:
```
env GOOS=linux GOARCH=arm64 go build -o bootstrap main.go
```

## Provisionando a Lambda com Terraform
Foi criado a pasta /terraform para todas as configurações de infra, no arquivo main.tf tem tudo necessário para fazer o provisionamento de uma Lambda em Go, utilizando ARM64.

## Test, build, provisionamento e deploy da Lambda
Foi utilizando o Github Actions para fazer todos esses passos.
Basicamente ficou dividido em:
- test
- build
- deploy 

Todos os pushs iram iniciar a esteira mas apenas os pushs na branch de main e develop irão rodar o terraform apply.