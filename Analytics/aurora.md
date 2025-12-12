# Amazon Aurora
Se trata de um serviço que é um database completamente gerenciado pela AWS

É, basicamente, uma engine que performa as operações em nosso database para nós

Se responsabiliza por:
+ Manter os dados disponíveis
+ Manter os dados seguros
+ Performar de forma mais próxima do ótimo

![](aurora-images/Pasted-image-1.png)

É compatível com:
+ MySQL 
+ PostgreSQL
+ MariaDB
+ Oracle
+ MS SQL Server
+ IBM Db2

## Usos Comuns
+ OLTP
+ Aplicações Web
+ SaaS
+ Databases empresariais usando Fleet Manager
+ Plataformas de e-commerce
+ Sistemas de gerenciamento de conteúdo

Possui uma engine de armazenamento de logs estruturados que aumenta sua performance se comparado a engines tradicionais de databases

## Benefícios de Uso 
+ Elimina a necessidade de gerenciarmos a infraestrutura do database 
+ Fornece alta disponibilidade e escalabilidade global
+ Garante durabilidade de dados
+ Seu log estruturado faz com que tenhamos um alto throughput e baixa latência 

## Características
+ Até 15 replicas de leitura por cluster com baixa latência
+ Armazenamento escala de modo automático de 10 GB ate 128 TB
+ Se recupera sozinho de falhas de hardware
+ Dados são criptografados no tráfego e no rest se integrado com AWS KMS
+ Fornece a API do Amazon RDS para uma interface segura
+ Não possui integração com ETL, se integrarmos com o Amazon Redshift podemos performar ETL sem a necesidade de um pipeline complexo e tradicional em NRT
+ Realiza backups com point-in-time
+ Possiblita clonar a database de forma rápida
+ Se usado MySQL podemos realizar backtracking
+ Nos permite de forma nativa criar réplicas em Availability Zones (AZ)

## Pricing
Pay-as-you-go

Fatores que influenciam:
+ Tipo de instância escolhida
+ Quantidade de armazenamento necessário
+ Quantidade de operações I/O que são performadas

## Conceitos
### Aurora DB cluster
É a principal unidade de arquitetura do Aurora 

Composto de:

#### Primary (Writer) Instance
Lida com todas as operações de escrita e lê requests feitos ao cluster do database 

Podemos ter somente um por cluster

#### Secondary (Reader) Instance
Performa operações de leitura de modo escalável

Podemos ter até 15 replicads dessa instância para otimizar a performance

#### Cluster Volume
Se trata do armazenamento virtual da databases

Há manutenção contínua do seu armazenamento no Amazon S3

![](aurora-images/Pasted-image-2.png)

Pode ser expandido para varias AZ, cada um contendo uma copia dos dados do cluster do database 

### Endpoints
Se tratam de pontos de conexão de nosso cluster 

#### Cluster Endpoint 
Permite a conexão com a Primary Instance para performar operações de leitura e escrita 

#### Reader Endpoint 
Realiza operações de Load Balancer de modo a gerenciar o tráfego de requests entre as Secondary Instances

#### Instance Endpoint
Permite a conexão em uma instancia de database específica

#### Custom Endpoint
Uma forma de customizarmos a conexão com um grupo seleto de instancias

#### Aurora Global Database Endpoint
Realiza a conexão, em situações de deploy global, à Primary Instance

### Quorum Model
Abordagem de verificar a consistencia ao longo de multiplas copias do database 

Requer de um "acordo" com a maioria dos nodes de armazenamento que contem os Cluster Volumes

### Aurora Serverless
Opera de modo Serverless dessa forma não precisamos nos preocupar com dimensionamento de recursos

### Aurora Global Database
Permite que uma única database possa ser replicada em múltipĺas regiões tornando mais resiliente e tolerante a falhas

## Levar em Conta ao Implementar
### Segurança e Gerenciamento
Faz uso de VPC para trafegar os dados via rede 

Podemos integrar com IAM para termos controle granular de acessos

É recomendado o uso de Amazon GuardDuty para identificar potenciais ameaças de forma inteligente

### Monitoramento e Logging 
Devemos monitorar suas métricas e Logs para termos uma visibilidade ampla de como e quem está acessando a database  

### Gerenciamento Operacional
Devemos nos atentar a:
+ Entender o backup automatico e features de recovery
+ Opções de oint-in-time recovery
+ Habilidade de criação de replicas de leitura para melhorar a escalabilidade e recuperação de desastres

## Integração
### AWS Lambda
Podemos invocar eventos que realizam a execução de procedures e triggers

### Amazon S3
Podemos carregar e armazenar snapshots e backups no S3

### AWS IAM
Podemos controlar o acesso ao database 

### Amazon CloudWatch 
Podemos fazer upload de métricas e auditar seus logs 

### Amazon Sagemaker, Amazon Comprehend e Amazon Bedrock
Podemos fazer inferencia nesses serviços diretamente dos dados armazenados no database
