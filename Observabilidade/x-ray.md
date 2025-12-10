# O que é?
Se trata de um serviço que **provê observabilidade** ao usuários a respeito de chamadas de API (requests) **permitindo identificar gargalos, latência e possíveis otimizações**

Os serviços da Amazon funcionam, basicamente, via requests 

Exemplo: StepFunctions, onde cada State chama um serviço da AWS via API

![[Pasted image 20251104122112.png]]
```json
"StartIcebergJob": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "gruposaga-nonprod-elt-raw-stage-pond",
        "Arguments": {
          "--load_mode.$": "$.migration_type",
          "--days.$": "States.Format('{}', $.days)",
          "--data_source.$": "$.database_name",
          "--data_source_key.$": "$.data_source_key",
          "--table_name.$": "$.table_name",
          "--first_load_date_json_path.$": "States.Format('s3://gruposaga-nonprod-assets/json/{}/first_load_date.json', $.data_source_key)"
        }
      },
```

# Vantagens
Podemos fazer o rastreio dessas chamadas, bem como **obter metadados delas de forma clara e simples**

Com o uso de X-Ray podemos observar:
+ O **serviço** que fez o request
+ O **status** do request
+ A **duração** da chamada de API
+ Um **gráfico de Gantt** que nos permite acompanhar o **fluxo do seu funcionamento**

Outras vantagens do seu uso são: 
+ **Integração nativa com o CloudWatch** permitindo acesso aos logs e outras features num só lugar
+ **Baixo custo**
	+ USD 5,00 a cada 1 milhão de traces salvos
	+ USD 0,50 a cada 1 milhão de traces extraídos, e.g. via queries
	+ USD 0,50 a cada 1 milhão de traces scaneados
	+ USD 1,00 a cada traces salvos no X-Ray Insights
+ **Facilidade de implementação** (Boto3, AWS Powertools por exemplo)

![[Pasted image 20251104123045.png]]
# Usos
Monitoramento e otimizações de:
+ Arquitetura de microsserviços
+ Arquitetura orientada a eventos
+ Queries em Databases
+ Requests em API's
+ Orquestrações
+ Dentre outros

# Funcionamento

**O X-Ray atua recebendo Traces** de nossas aplicações e serviços que nossas aplicações chamam que estão integradas ao X-Ray

**Traces** são os **traços do grafo** que representam as chamadas de API
![[Pasted image 20251104123100.png]]

Ao instrumentalizar nossas ferramentas com X-Ray **nós temos registros de tráfego interno e externo** (inbound e outbound, respectivamente) **de cada request**

**Os dados de cada Trace não são enviados diretamente ao X-Ray**, eles seguem o seguinte fluxo:
1. Cada cliente/serviço emite **dados JSON via seu SDK**
2. Tais dados tem como **primeiro destino o Daemon do X-Ray** (**protocolo** de rede **UDP**) 
3. O **Daemon** atua como um **buffer enviando os dados a uma fila** que faz o **upload dos dados no X-Ray** em bateladas (batches)

O Daemon do X-Ray é disponível no Linux, macOS, Windows e é incluso no AWS Elastic Beanstalk e AWS Lambda

**Obs.: Em 25/02/2027 o Daemon e a SDK serão descontinuados, sendo recomendado o uso de OpenTelemetry. O Daemon vai ser, pelo que entendi, substituído pelo CloudWatch Agent**

![[Pasted image 20251104130351.png]]

Podemos customizar nossos Traces adicionando campos como Headers
# Implementação
Podemos fazer via:
+ Console (mais limitado em customização)
+ SDK (AWS Powertools)
+ OpenTelemetry (ADOT)
+ API do X-Ray

![[Pasted image 20251106164159.png]]

A forma com que será usado o X-Ray pode afetar seu modo de implementação

![[Pasted image 20251106164415.png]]

O uso de SDK's (ADOT ou AWS Powertools) permite uma maior customização que não é disponivel via Console, como por exemplo:
+ Publicação de métricas customizaveis
+ Customização do mecanismo de coleta de Traces (collector)
+ Criação e atualização de amostragem de regras de forma programática
+ Customização da intrumentação, como por exemplo, atributos chave-valor (key-value)

Para fazermos uso do X-Ray as ferramentas que serão envolvidas na implementação devem ter as seguintes permissões

+ [xray:PutTraceSegments](https://docs.aws.amazon.com/xray/latest/api/API_PutTraceSegments.html)
+ [xray:PutTelemetryRecords](https://docs.aws.amazon.com/xray/latest/api/API_PutTelemetryRecords.html)
## AWS Powertools e o X-Ray (SDK)
É um conjunto de API's open source, bibliotecas e agentes que enviam dados ao backend dos serviços AWS

Podemos coletar logs, metadados, métricas e traces

![[Pasted image 20251106171409.png]]

Podemos implementar **Annotations**
```python
from aws_lambda_powertools import Tracer
from aws_lambda_powertools.utilities.typing import LambdaContext

tracer = Tracer() # Objeto responsável pelo comportamento do X-Ray


def collect_payment(charge_id: str) -> str:
    tracer.put_annotation(key="PaymentId", value=charge_id)
    return f"dummy payment collected for charge: {charge_id}"


@tracer.capture_lambda_handler
def lambda_handler(event: dict, context: LambdaContext) -> str:
    charge_id = event.get("charge_id", "")
    return collect_payment(charge_id=charge_id)
```

Podemos implementar **Metadata**
```python
from aws_lambda_powertools import Tracer
from aws_lambda_powertools.utilities.typing import LambdaContext

tracer = Tracer() # Objeto responsável pelo comportamento do X-Ray


def collect_payment(charge_id: str) -> str:
    return f"dummy payment collected for charge: {charge_id}"


@tracer.capture_lambda_handler
def lambda_handler(event: dict, context: LambdaContext) -> str:
    payment_context = {
        "charge_id": event.get("charge_id", ""),
        "merchant_id": event.get("merchant_id", ""),
        "request_id": context.aws_request_id,
    }
    payment_context["receipt_id"] = collect_payment(charge_id=payment_context["charge_id"])
    tracer.put_metadata(key="payment_response", value=payment_context)

    return payment_context["receipt_id"]
```

**A diferença entre Annotations e Metadata é que o primeiro é indexado pelo X-Ray enquanto o segundo, não**

Usamos Metadata para adicionar contexto em uma operação usando um objeto nativo
## OpenTelemetry e o X-Ray (ADOT)
É um conjunto de API's open source, bibliotecas e agentes que enviam dados ao backend dos serviços

É **cloud-agnostic**

Podemos coletar logs, metadados, métricas e traces

![[Pasted image 20251106171229.png]]

```python
# pip install opentelemetry-api
# pip install opentelemetry-sdk
```

[OpenTelemetry Traces Docs](https://opentelemetry-python.readthedocs.io/en/stable/api/trace.html) 

```python
from opentelemetry import trace

tracer = trace.get_tracer(__name__)

# Create a new root span, set it as the current span in context
with tracer.start_as_current_span("parent"):
    # Attach a new child and update the current span
    with tracer.start_as_current_span("child"):
        do_work():
    # Close child span, set parent as current
# Close parent span, set default span as current
```