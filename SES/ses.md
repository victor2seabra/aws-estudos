Se trata de um serviço de envios de emails onde não precisamos nos preocupar com:
+ Gerenciamento de servidores de email
+ Configuração de rede

Com ele podemos promover envio de emails de marketing ou transacionais, sempre tomando cuidado com suas métricas de **Bouce, Complaint e Reject**, pois podemos perder a funcionalidade do domínio naquela região se atingir o limiar permitido pela AWS
# Funcionamento

![[Pasted image 20251014153523.png]]

1. Um dado usuário faz um request ao SES para que seja enviado o email
2. Se o request é válido, o SES aceita o request
3. O email é então disparado aos receptores
4. Nesta etapa podemos ter 3 cenários distintos:
	*a.* A mensagem é entregue com sucesso (**Delivery**) via SMTP sempre escaneando a respeito de ameças antes de seu envio;
	*b.* A mensagem não chega ao destinatário, retornando um **Bounce** ao SES que repassa tal informação ao usuário. O email que falhou é descartado;
	*c.* A pessoa recebe a mensagem mas a marca como spam e registra uma queixa (**Complaint**) retornando a Complaint ao SES que a passa ao usuário.

## Delivery

![[Pasted image 20251014155517.png]]

É um evento que retorna que a mensagem foi enviada com sucesso

Ele é composto de um ID da mensagem

Podemos fazer uso desse identificador da mensagem para identificar o email enviado e/ou rastrear problemas que ocorrerão durante seu envio

## Bounce

Bounce ocorre quando o serviço de emails interno falha em enviar o email ao destinatário.

Podemos ter 2 tipos de Bounce:

+ Hard Bounce
![[Pasted image 20251014155534.png]]


+ Soft Bounce
![[Pasted image 20251014155545.png]]

## Complaint
![[Pasted image 20251014155607.png]]

## Auto response
![[Pasted image 20251014155623.png]]

# Configuração

Para enviarmos emails para outras pessoas devemos desabilitar o modo sandbox, o que demanda de envio de email à AWS reportando como serão lidadas as metricas obtidas

Para lidarmos com tais problemas podemos setar diversos diversos serviços para agirem, por exemplo, removendo a pessoa da lista de emails a serem enviados

Ao enviar um email, o SES pode receber uma resposta, sendo esta um evento que deve ser direcionado a outro serviço. Nesta resposta podemos ter Bounce, Complaint e Delivery