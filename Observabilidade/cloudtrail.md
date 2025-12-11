# AWS CloudTrail
Uma ferramenta de governança, auditoria de riscos e compliance que nos permite rastrear:

+ ações feitas por um usuário
+ ações feitas por um IAM Role  
+ execuções de um serviço

O CloudTrail é integrado com o CloudWatch o que nos permite consultar de forma rápida os logs de rastreio

## Para que usar?
Rastrear ações e atividades performadas no ambiente AWS das seguintes maneiras:

+ via AWS Management Console
+ via CLI's
+ outros serviços AWS como por exemplo StepFunctions

## Trails
**Podemos registrar os logs originados pelo CloudTrail no CloudWatch Logs dessa forma podemos integrar as features do Amazon CloudWatch com os logs do CloudTrail e tomar ações baseadas em eventos usando o Amazon EventBridge Event Pattern**

A criação de trails permite fazer com que determinados CloudWatch Logs sejam automaticamente armazenados em um bucket, facilitando:
+ Fazer queries 
+ Rastrear ações
+ Receber notificações em casos de atividades específicas

## CloudTrail Insights
Torna mais fácil indentificar e responder a atividades consideradas anormais e que podem comprometer a segurança e custos do ambiente
