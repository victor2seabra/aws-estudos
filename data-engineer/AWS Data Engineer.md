# Fundamentos
## Tipos de Dados
### Estruturados
São dados organizados de certa forma, como por exemplo, um schema

São fáceis de performar queries

São organizados em colunas e linhas

Tem uma estrutura consistente
### Semi-estruturados
São dados com um certo grau de organização mas não tão bem definido quanto dados estruturados

Podemos ter elementos com tags ou categorizações

Como exemplo temos:
+ XML
+ JSON
+ Logs
### Não-estruturados
São dados que não possui uma estrutura bem definida, como por exemplo imagens e áudios

É difícil performar queries neles sem antes realizar um pré-processamento

Possuem uma grande variedade de formatos (mp4, png, jpeg, ...)
## Propriedades dos dados
### Velocidade
Taxa de velocidade que os dados são criados
### Variedade
Diversidade de arquivos e formatos de dados que estão sendo criados
### Volume
Quantidade/tamanho dos dados que estão sendo lidados (GB, MB, TB)
## Data Warehouses
Se trata de uma forma de armazenar os dados com uma estrutura rígida e bem definida com o intuito de serem utilizados para análises

Geralmente mais caros que Data Lakes 

**Schema-on-write**

![[Pasted image 20251126113921.png]]

Dados de diferentes fontes são armazenados

Tem como características:
+ Realização de queries complexas
+ O dado passa por um ETL
+ Normalmente é usado um modelo Star ou Snowflake
+ Otimizado para operações de leituras

Temos como exemplo:
+ Amazon Redshift
## Data Lakes
Se trata de uma forma de armazenamento de diversos formatos de dados, sejam eles estruturados, semi-estruturados ou não-estruturados

**Schema-on-read**

Podemos construir um Data Lake usando:
+ S3
+ Glue
+ Athena

Dados em um Data Lake são armazenados sem modificação alguma, podemos serem refinados em camadas seguintes de modo a atender o objetivo final (ELT)
## Data Lakehouses
Combina as qualidades de um DW com as do DL fazendo com que a performance, confiabilidade e capacidades do DW sejam aproveitadas junto à flexibilidade, escalabilidade e baixo custo do DL

Podemos construir um Data Lakehouse usando:
+ LakeFormation
+ S3
+ Redshift Spectrum
## Data Mesh
Uma forma de organização e gerenciamento descentralizada de dados que pode ser feita, por exemplo, separando acesso de times a dados específicos

![[Pasted image 20251126115120.png]]

**Seu gerenciamento é realizado via domínios**

Podemos construir um Data Mesh usando:
+ LakeFormation
+ Glue
+ S3
## JDBC x ODBC
São formas de nos conectar à Databases

JDBC (Java Database Connectivity) tem como características:
+ Ser agnóstico quanto à plataforma;
+ Ser dependente de linguagem que está usando (Java).

ODBC (Open Database Connectivity) tem como características:
+ Ser agnóstico quanto à linguagem;
+ Ser dependente da plataforma a ser usada.
## Data Sampling
## Data Skew
## Data Validation
# Armazenamento
## S3
## EBS
## EFS
## Backup
# Databases
# Migração e Transferência
# Computação
# Containers
# Analytics
# Integração de Aplicações
# Segurança, Identidade e Compliance
# Redes e Content Delivery
# Gerenciamento e Governança
# Machine Learning
# Ferramentas de Desenvolvimento