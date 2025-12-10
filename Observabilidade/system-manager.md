# AWS Systems Manager

## State Manager
É um serviço seguro e escalável de realizar configurações de gerenciamento de serviços, como por exemplo, EC2

**Realiza o deploy de um CloudWatch Agent**

**Atua fazendo com que nossos EC2 estejam no estado que definimos em sua configuração**

Podemos definir:
+ Configurações de servidor
+ Definição de antivirus
+ Configurações de firewall
+ Dentre outros

Quando é recomendado o uso de CloudWatch Agents?

**Situações que Exigem o Agente CloudWatch**
Situação	Tipo de Dado Coletado	Detalhes / Exemplos
Monitoramento de Servidores AWS EC2 (Métricas In-Guest)	Métricas de Desempenho do Sistema Operacional (OS)	Uso de Memória (RAM), Uso de Espaço em Disco (percentual), Métrica de Swap, Métricas de Processos.
Coleta de Logs de Aplicações e Sistema	Logs Customizados de Arquivos (Application Logs)	Logs de aplicações web (/var/log/httpd/access_log), logs de containers (quando não configurados via drivers nativos), logs de firewalls locais, etc.
Coleta de Métricas Personalizadas	Métricas de Aplicação/Negócio (via StatsD ou collectd)	Tempo de processamento de transações, contagem de usuários ativos em tempo real, métricas de um daemon personalizado, métricas de host via collectd.
Monitoramento de Ambientes Híbridos	Logs e Métricas de Servidores On-Premises	Servidores rodando no seu data center local ou em outra nuvem que precisam enviar dados de desempenho e logs para o CloudWatch.

**Serviços AWS com Logs e Métricas Automáticas**
Serviço AWS	Logs / Métricas Gerenciadas Automaticamente
AWS Lambda	Métricas básicas (Invocações, Duração, Erros, Throttles) e todos os logs de saída padrão enviados para o CloudWatch Logs.
Amazon S3	Métricas de solicitação (via S3 Inventory), logs (via S3 Server Access Logging ou CloudTrail).
Amazon DynamoDB	Métricas de capacidade e taxa de transferência (throughput).
Amazon RDS	Métricas de CPU, Armazenamento, Rede e específicas do Banco de Dados.
Amazon API Gateway	Métricas de API e logs de acesso/execução configurados no stage.
AWS Load Balancers (ALB, NLB)

