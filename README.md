# Kafka--conector-with-localstack
projeto de estudo para utilizar o kafka conector e o S3 Sink connector apontando para o localstack simulando um s3

Será necessário a criação de um arquivo com o nome "aws_credentials" que será utilizado pelo docker-compose.yaml para poder cria o S3 Sink Connector no ambiente da AWS. Abaixo a estrutura desse arquivo S3 Sink Connector:
```
[default]
aws_access_key_id = <acess_key_id>
aws_secret_access_key = <acess_secret_key>
```

Essas credenciais são obtidas com comandos listados no arquivo 'comandos a ser executado.sh', onde é necessário criar um usuario IAM na aws e criar uma secret-key para esse usuario.

A estrutura de pastas devem ficar conforme o exemplo abaixo:

```
.
├── aws_credentials
├── comandos  a ser executado.sh
├── connectors
├── create-sink.json
├── docker-compose.yaml
├── LICENSE
├── list-connectors.json
└── README.md

```

Tambem será necessário instalar o a biblioteca Python fastAvro para realizar a leitura do arquivo avro e validar se os campos estão corretos:

```
pip install fastavro
```
Ao baixar o arquivo abro, para validar se o avro está correto e printa-lo via terminal, utilize o comando abaixo:
```
fastavro nome_do_arquivo_avro.avro
```
