#Iniciar o LocalStack
╰─ localstack start -d

#Criar usuario IAM
╰─ awslocal iam create-user --user-name somnus

#Criar acess-key do usuario IAM - Adicionar os campos secret-acess-key e acess-key-id no arquivo aws_credentials
╰─ awslocal iam create-access-key --user-name somnus

#Criar s3 rmoff-voluble-test - é possivel usar o proprio aws cli no localstack, apenas sendo necessário passar o endpoint do localstack com a tag --endpoint
╰─ aws --endpoint-url=http://localhost:4566 s3 mb s3://rmoff-voluble-test

#Comando para acessar ksql
╰─ docker exec -it ksqldb ksql http://ksqldb:8088

#Comando para criar Voluble Source Connector para gerar dados para o tópico
ksql>CREATE SOURCE CONNECTOR s WITH (
  'connector.class' = 'io.mdrogalis.voluble.VolubleSourceConnector',

  'genkp.owners.with' = '#{Internet.uuid}',
  'genv.owners.name->full.with' = '#{Name.full_name}',
  'genv.owners.creditCardNumber.with' = '#{Finance.credit_card}',

  'genk.cats.name.with' = '#{FunnyName.name}',
  'genv.cats.owner.matching' = 'owners.key',

  'genk.diets.catName.matching' = 'cats.key.name',
  'genv.diets.dish.with' = '#{Food.vegetables}',
  'genv.diets.measurement.with' = '#{Food.measurements}',
  'genv.diets.size.with' = '#{Food.measurement_sizes}',

  'genk.adopters.name.sometimes.with' = '#{Name.full_name}',
  'genk.adopters.name.sometimes.matching' = 'adopters.key.name',
  'genv.adopters.jobTitle.with' = '#{Job.title}',
  'attrk.adopters.name.matching.rate' = '0.05',
  'topic.adopters.tombstone.rate' = '0.10',

  'global.throttle.ms' = '500',
  'global.history.records.max' = '100000'
);


#Para verificar se as credenciais da aws criadas foram importadas corretamente
╰─ docker exec kafka-connect ls -l /root/.aws/credentials

#Para verificar se os campos das credenciais da aws estão corretos
╰─ docker exec kafka-connect cat /root/.aws/credentials  

#Necessário instalar o jq para poder executar o curl do arquivo "list-connectors.json"
╰─ sudo apt-get install -y jq






