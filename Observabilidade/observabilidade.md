# Implementando Observabilidade
Devemos pontuar **o que nos é de interesse e prioridade** nos fazendo a seguinte pergunta:
+ O que queremos identificar e otimizar com uso de observabilidade?

Após a identificação do que temos interesse em observar, **definimos como esses dados necessários para nossa observabilidade serão ingeridos e quais dados são necessários para atingir a meta definida**, evitando ingerir dados desnecessários, que podem comprometer no custo

No processo de ingestão devemos **ponderar se o dado será ingerido via Logs ou via Metrics**

Devemos criar Alarms somente para o que realmente é necessário e urgente

**Devemos mascarar dados sensiveis presentes nos logs antes de exportá-los para o CloudWatch Logs**

# Monitoramento vs Observabilidade
Monitoramento se trata de uma porção do que chamamos de observabilidade

Observabilidade é composto de 3 pilares:
+ **Tracing**
    + Nos auxilia a **identificar a causa-raíz** de forma rápida e eficiente
    + Podemos fazer uso de X-Ray
+ **Monitoramento**
    + Nos permite ter **informações de uma aplicação** que não está funcionando adequadamente
    + Podemos fazer uso de CloudWatch Metrics, CloudWatch Contributor Insights
+ **Logging**
    + Nos dá **informações mais descritivas** do motivo da anomalia
    + Podemos fazer uso de CloudWatch Logs

# Melhores práticas de Logging
Devemos registrar em logs a disponibilidade e latência de todas as dependências, nos ajudando a entender o motivo de um request falhar ou demorar

1. Segmentar métricas de dependências por chamada, recurso ou status code facilitando tirar conclusões 
2. Em situações que operamos usando filas é recomendado que, quando colocamos ou tiramos um objeto da fila, registremos isso via log 
3. Adicionar um contador de erros para todas situações de requests que falharam, incluindo mensagens do motivo do erro de forma detalhada
4. Organizar erros em categorias de causas que levaram a eles

**Logs devem conter metadados determinantes para a identificação da causa-raíz do problema**. É recomendado ter dados como quem realizou o request e o que o request tentou executar

**É importante termos um Trace ID e propagá-lo nas chamadas de backend**, principalmente em sistemas distribuídos e de microsserviços, implementando essa prática podemos alinhar os logs de varios sistemas e identificar falhas que ocorreram 

![](images/Pasted-image-1.png)

![](images/Pasted-image-2.png)

![](images/Pasted-image-3.png)

![](images/Pasted-image-4.png)
