# Sistema de Gestão Clínica — Centro de Ginecologia Natural e Emocional

Projeto acadêmico de **modelagem e implementação de banco de dados relacional** para apoiar a gestão de uma clínica especializada em saúde da mulher. A solução organiza informações cadastrais, profissionais, agenda, consultas, pagamentos, prontuários, prescrições, exames e acompanhamentos em uma estrutura integrada.

> **Instituição:** Universidade Cidade de São Paulo (UNICID)  
> **Disciplina:** Modelagem de Dados  
> **Professor:** Clovis Jose  
> **Turma:** Terça-feira — 2º semestre (noturno)  
> **Grupo:** 3

---

## Sumário

1. [Integrantes](#1-integrantes)
2. [Contexto do negócio](#2-contexto-do-negócio)
3. [Processo atual e problemas identificados](#3-processo-atual-e-problemas-identificados)
4. [Solução proposta](#4-solução-proposta)
5. [Requisitos do sistema](#5-requisitos-do-sistema)
6. [Regras de negócio](#6-regras-de-negócio)
7. [Modelo entidade-relacionamento](#7-modelo-entidade-relacionamento)
8. [Modelo lógico relacional](#8-modelo-lógico-relacional)
9. [Normalização](#9-normalização)
10. [Dicionário de dados](#10-dicionário-de-dados)
11. [Implementação SQL](#11-implementação-sql)
12. [Massa de dados](#12-massa-de-dados)
13. [Consultas de gerenciamento e auditoria](#13-consultas-de-gerenciamento-e-auditoria)
14. [Indicadores, BI e possibilidades de IA](#14-indicadores-bi-e-possibilidades-de-ia)
15. [Histórico de evolução do projeto](#15-histórico-de-evolução-do-projeto)
16. [Estrutura do repositório](#16-estrutura-do-repositório)
17. [Como executar](#17-como-executar)
18. [Considerações finais](#18-considerações-finais)

---

## 1. Integrantes

- Vinícius Rodrigo Silva
- Vinicius Pina Ferreira
- Miguel Expedito Ovidio dos Santos
- Gabriel Reis Gomes de Oliveira
- Gustavo Alves Silva
- Kauã Molina
- Pedro Alexandre de Oliveira Rocha
- Ray Batista da Silva

## 2. Contexto do negócio

O **Centro de Ginecologia Natural e Emocional** atua na área de saúde da mulher, com foco em ginecologia natural e integrativa. A clínica oferece consultas e tratamentos relacionados a sintomas e condições ginecológicas.

O público principal considerado no levantamento é composto por mulheres entre 30 e 55 anos, incluindo pacientes com síndrome dos ovários policísticos (SOP), endometriose, miomas, candidíase e sintomas associados à perimenopausa.

A escolha da empresa foi viabilizada pela proximidade de um integrante do grupo com a clínica, facilitando o levantamento dos processos e das necessidades do negócio.

Entre as informações relevantes para a gestão estão:

- Queixa principal, diagnóstico e histórico de tratamentos;
- Perfil e histórico clínico das pacientes;
- Taxa de comparecimento às consultas;
- Índices de faltas, cancelamentos e remarcações;
- Situação dos pagamentos e acompanhamentos pós-consulta.

## 3. Processo atual e problemas identificados

Parte do processo já é automatizada: uma inteligência artificial realiza o agendamento, consulta a disponibilidade no Google Calendar, oferece horários, encaminha o link de pagamento e envia três lembretes. O acompanhamento após a consulta, por outro lado, é realizado manualmente.

**Fluxo resumido:**

```text
Paciente
   ↓
Agendamento pela IA
   ↓
Pagamento / confirmação do convênio
   ↓
Envio de lembretes
   ↓
Consulta
   ↓
Registro clínico
   ↓
Acompanhamento após uma semana
```

### Problemas levantados

| Problema | Impacto para a clínica |
|---|---|
| Acompanhamento pós-consulta manual | Depende da memória do profissional e pode atrasar ou deixar de acontecer. |
| Ausência de prontuário eletrônico integrado | Informações clínicas ficam dispersas e podem ser perdidas. |
| Falta de relatórios gerenciais | Dificulta acompanhar agendamentos, faltas, cancelamentos e remarcações. |
| Agendamento e pagamento em sistemas separados | Existe o risco de não relacionar corretamente o pagamento à consulta correspondente. |

## 4. Solução proposta

O projeto propõe um banco de dados relacional para centralizar as informações essenciais da operação da clínica e permitir consultas operacionais e gerenciais.

| Necessidade | Resposta do modelo |
|---|---|
| Controlar o acompanhamento pós-consulta | A tabela `ACOMPANHAMENTO` registra previsão, realização, canal, evolução dos sintomas, adesão e dúvidas. |
| Centralizar o histórico clínico | `PRONTUARIO` e `EVOLUCAO_PRONTUARIO` organizam o histórico da paciente e os registros de cada consulta. |
| Acompanhar a operação | `CONSULTA`, `AGENDA` e `LEMBRETE` permitem analisar situações de atendimento, faltas e remarcações. |
| Relacionar cobranças aos atendimentos | `PAGAMENTO` mantém vínculo com a consulta que originou a cobrança. |
| Organizar prescrições e exames | `PRESCRICAO`, `ITEM_PRESCRICAO`, `EXAME` e `RESULTADO_EXAME` estruturam essas informações. |

O escopo deste trabalho é a **modelagem e implementação da camada de dados**. A integração operacional com a IA, Google Calendar e plataforma de pagamentos é considerada no levantamento e nos requisitos, mas não deve ser interpretada como uma integração externa já implementada pelo banco de dados.

## 5. Requisitos do sistema

Os requisitos foram organizados e identificados por códigos para permitir rastreabilidade entre as necessidades do negócio e a estrutura de dados.

### 5.1 Requisitos funcionais

| Código | Área | Descrição |
|---|---|---|
| RF01 | Pessoas | Cadastrar pessoas com dados pessoais, endereços e telefones. |
| RF02 | Pacientes | Cadastrar pacientes vinculados a uma pessoa. |
| RF03 | Funcionários | Cadastrar funcionários vinculados a uma pessoa. |
| RF04 | Médicos | Cadastrar médicos vinculados a funcionários, com CRM. |
| RF05 | Especialidades | Cadastrar especialidades e o RQE do médico em cada especialidade. |
| RF06 | Salas | Cadastrar salas e suas identificações. |
| RF07 | Convênios | Cadastrar convênios e seus dados de contato e registro. |
| RF08 | Alergias | Cadastrar alergias e registrar gravidade e data de identificação por paciente. |
| RF09 | Medicamentos | Cadastrar medicamentos, princípio ativo, fabricante e tarja. |
| RF10 | Tipos de exame | Cadastrar tipos de exame, preço padrão e preparo necessário. |
| RF11 | Laboratórios | Cadastrar laboratórios externos. |
| RF12 | CID | Cadastrar códigos, descrições e categorias CID. |
| RF13 | Convênios | Vincular pacientes a convênios, com número de carteirinha e datas de vigência. |
| RF14 | Agenda | Gerenciar horários dos médicos, salas, datas, intervalos e disponibilidade. |
| RF15 | Consultas | Agendar consultas vinculando paciente, horário e, quando aplicável, convênio. |
| RF16 | Lembretes | Registrar lembretes enviados, canal, data e confirmação de presença. |
| RF17 | Acompanhamento | Registrar acompanhamento previsto para uma semana após a consulta e seus resultados. |
| RF18 | Pagamentos | Registrar valor, forma, data e situação do pagamento. |
| RF19 | Prontuário | Manter um prontuário por paciente e registrar evoluções clínicas por consulta. |
| RF20 | Prescrições | Registrar prescrições e seus itens, incluindo posologia, dosagem e duração. |
| RF21 | Exames | Solicitar exames vinculados à consulta e registrar laboratório, situação e resultado. |

### 5.2 Requisitos não funcionais

| Código | Categoria | Descrição |
|---|---|---|
| RNF01 | Segurança | Controlar acesso por perfil de usuário. |
| RNF02 | Segurança | Proteger prontuários e prescrições. |
| RNF03 | Segurança | Registrar auditoria de alterações, responsáveis e datas. |
| RNF04 | Privacidade | Tratar dados sensíveis de saúde conforme a LGPD. |
| RNF05 | Privacidade | Permitir que a paciente solicite os próprios dados. |
| RNF06 | Desempenho | Disponibilizar o histórico da paciente em tempo adequado durante o atendimento. |
| RNF07 | Desempenho | Garantir agendamento sem demora perceptível. |
| RNF08 | Disponibilidade | Manter o serviço de agendamento disponível 24 horas. |
| RNF09 | Disponibilidade | Realizar backups periódicos. |
| RNF10 | Usabilidade | Oferecer interface simples para o profissional. |
| RNF11 | Usabilidade | Facilitar a interação com a IA de agendamento. |
| RNF12 | Confiabilidade | Manter a agenda sincronizada com o Google Calendar. |
| RNF13 | Confiabilidade | Impedir duplicidade de horários. |
| RNF14 | Confiabilidade | Confirmar consulta após pagamento ou confirmação do convênio. |
| RNF15 | Integração | Integrar a agenda dos médicos ao Google Calendar. |
| RNF16 | Integração | Integrar o sistema de pagamento para geração e envio de links. |

## 6. Regras de negócio

As regras abaixo representam as condições levantadas para o funcionamento da clínica.

| Código | Regra |
|---|---|
| RN01 | Toda pessoa deve possuir CPF único. |
| RN02 | Cada paciente e cada funcionário correspondem a exatamente uma pessoa. |
| RN03 | Todo médico é um funcionário e deve possuir CRM válido e único. |
| RN04 | Um médico possui uma ou mais especialidades. |
| RN05 | Uma paciente pode possuir vários convênios, cada um com data de validade. A regra de quantidade de vínculos ativos permanece sujeita à validação registrada no material de apoio. |
| RN06 | A clínica só aceita convênios cadastrados, e o uso depende da validade da carteirinha. |
| RN07 | Uma consulta pode ou não estar vinculada a um convênio, permitindo atendimento particular. |
| RN08 | Uma paciente pode possuir várias alergias, cada uma com grau de gravidade. |
| RN09 | Toda consulta deve estar associada a uma paciente, a um médico e a uma sala disponível. |
| RN10 | Um médico não pode ter duas consultas no mesmo horário. |
| RN11 | A IA oferece três horários livres ou todos os disponíveis, caso existam menos de três. |
| RN12 | Um horário só é considerado ocupado após a confirmação do agendamento. |
| RN13 | A consulta só é confirmada após o pagamento ou a confirmação do convênio. |
| RN14 | O status do pagamento é atualizado conforme a confirmação. |
| RN15 | A paciente recebe três lembretes antes da consulta, sendo um deles de confirmação de presença. |
| RN16 | O cancelamento segue a política da clínica, com prazo mínimo e regras de reembolso; fora do prazo pode gerar cobrança. |
| RN17 | Toda paciente possui exatamente um prontuário. |
| RN18 | Toda consulta realizada gera uma evolução no prontuário. |
| RN19 | Toda prescrição está vinculada a uma consulta e contém pelo menos um item. A necessidade de validação dessa restrição foi apontada no material de apoio. |
| RN20 | Todo item de prescrição possui posologia e dosagem definidas. |
| RN21 | Todo exame está vinculado a uma consulta, da qual se obtém a paciente, e pode ser processado por laboratório externo. |
| RN22 | Todo exame realizado gera um resultado assinado por um médico. |
| RN23 | Toda consulta gera um acompanhamento uma semana depois, para verificar sintomas e adesão ao tratamento. |

### 6.1 Permissões e responsabilidades

- **Prontuário:** alteração restrita ao médico responsável.
- **Dados cadastrais:** alteração por funcionários autorizados.
- **Dados financeiros:** acesso restrito à administração.
- **Acompanhamento:** confirmação pelo profissional responsável pelo atendimento.
- **Dados pessoais:** a paciente acessa somente os próprios dados.

## 7. Modelo entidade-relacionamento

O DER representa as entidades, seus atributos, relacionamentos e cardinalidades. A versão revisada contém **29 entidades e 33 relacionamentos**.

Arquivo editável: [`DER.drawio`](DER.drawio)

O modelo contempla os seguintes domínios:

- Pessoas, pacientes, funcionários e médicos;
- Endereços, telefones, especialidades e salas;
- Convênios e alergias;
- Agenda, consultas, lembretes e pagamentos;
- Prontuários, evoluções e CID;
- Medicamentos, prescrições e itens de prescrição;
- Tipos de exame, laboratórios externos, exames e resultados;
- Acompanhamentos pós-consulta.

## 8. Modelo lógico relacional

O modelo lógico transforma as entidades e relacionamentos do DER em tabelas relacionais, com atributos, chaves e restrições.

Arquivo: [`modelo_logico.txt`](modelo_logico.txt)

O modelo possui **29 tabelas**. Entre as decisões estruturais estão:

- `PESSOA` concentra os dados comuns de pacientes e funcionários.
- `MEDICO` especializa `FUNCIONARIO`.
- `MEDICO_ESPECIALIDADE`, `PACIENTE_ALERGIA`, `EVOLUCAO_CID` e `ITEM_PRESCRICAO` representam relacionamentos muitos-para-muitos com chaves compostas.
- `CONSULTA` referencia `AGENDA` por `id_horario`.
- O vínculo com convênio em `CONSULTA` é opcional, permitindo atendimento particular.
- `EXAME` referencia `CONSULTA`; a paciente é identificada por meio dessa relação, evitando duplicação.
- `ACOMPANHAMENTO` mantém vínculo único com a consulta.
- `PRONTUARIO` mantém vínculo único com a paciente.

**Legenda:** PK = chave primária; FK = chave estrangeira; UK = valor único; NN = não nulo.

## 9. Normalização

A documentação de normalização apresenta exemplos do próprio modelo, com dependências funcionais e justificativas das decisões adotadas. O objetivo é demonstrar a aplicação das três formas normais sem inventar problemas que não foram identificados.

A análise está documentada nesta própria seção, com exemplos do modelo.

### 9.1 Primeira Forma Normal (1FN)

A 1FN exige valores atômicos e ausência de listas de valores em uma única coluna.

Exemplos no modelo:

- `TELEFONE_PESSOA` armazena cada telefone em um registro.
- `ENDERECO_PESSOA` armazena cada endereço em um registro, com seus componentes separados.
- Especialidades, alergias, convênios, CIDs e itens de prescrição são representados por registros relacionados, e não por listas dentro de um atributo.

### 9.2 Segunda Forma Normal (2FN)

A 2FN exige que os atributos não-chave dependam da chave candidata inteira, e não apenas de parte de uma chave composta.

Exemplos:

| Tabela | Chave composta | Dependência funcional |
|---|---|---|
| `MEDICO_ESPECIALIDADE` | `id_medico` + `id_especialidade` | A combinação identifica o RQE associado à especialidade daquele médico. |
| `PACIENTE_ALERGIA` | `id_paciente` + `id_alergia` | A combinação determina a gravidade e a data de identificação daquela alergia para a paciente. |
| `ITEM_PRESCRICAO` | `id_prescricao` + `id_medicamento` | A combinação determina posologia, dosagem e duração daquele medicamento naquela prescrição. |
| `EVOLUCAO_CID` | `id_evolucao` + `cod_cid` | A combinação determina as observações referentes ao CID naquela evolução. |

### 9.3 Terceira Forma Normal (3FN)

A 3FN busca evitar dependências transitivas entre atributos não-chave.

Exemplos de decisões de modelagem:

- `CONSULTA` referencia `AGENDA` por `id_horario`. Os dados do médico e da sala permanecem em `AGENDA`, evitando replicá-los em cada consulta.
- `EXAME` referencia `CONSULTA`, e a paciente é obtida por esse relacionamento. Assim, o identificador da paciente não precisa ser duplicado em `EXAME`.

Essas decisões reduzem redundância e ajudam a manter a consistência dos dados.

## 10. Dicionário de dados

O dicionário descreve as tabelas e os atributos do modelo, incluindo tipos, obrigatoriedade, chaves e regras relevantes.

Arquivo: [`dicionario_de_dados.txt`](dicionario_de_dados.txt)

O documento deve permanecer alinhado ao modelo lógico e ao script SQL efetivamente utilizado.

## 11. Implementação SQL

A implementação utiliza **MySQL 8.0.16 ou superior** e contempla a criação do banco, tabelas, chaves primárias e estrangeiras, restrições e relacionamentos.

Arquivo de criação: [`script_sql.txt`](script_sql.txt)

## 12. Massa de dados

O projeto inclui dados fictícios para testar os relacionamentos e executar as consultas do banco.

Arquivo de carga: [`script_massa_dados.txt`](script_massa_dados.txt)

A massa é destinada a testes acadêmicos e não contém dados reais de pacientes. Como conjunto demonstrativo, ela não representa necessariamente todos os cenários e registros previstos nas regras de negócio; por isso, os resultados das consultas de auditoria devem ser interpretados dentro desse contexto.

## 13. Consultas de gerenciamento e auditoria

As consultas SQL foram organizadas em dois grupos e estão reunidas em um único arquivo:

[`consultas_gerenciamento_auditoria.sql`](consultas_gerenciamento_auditoria.sql)

### 13.1 Consultas de gerenciamento

As consultas de gerenciamento apoiam a operação e a tomada de decisão, permitindo:

- Visualizar a agenda por período;
- Consultar o histórico de atendimentos de uma paciente;
- Acompanhar consultas por médico e situação;
- Identificar pagamentos pendentes;
- Consultar resumos financeiros;
- Acompanhar follow-ups pendentes e realizados;
- Consultar exames e resultados;
- Analisar a distribuição dos status das consultas.

### 13.2 Consultas de auditoria

As consultas de auditoria procuram identificar situações que merecem conferência, como:

- Consultas realizadas sem evolução no prontuário;
- Exames realizados sem resultado;
- Uso de convênio inativo ou fora da validade;
- Consultas sem acompanhamento registrado;
- Datas de acompanhamento diferentes do prazo previsto;
- Quantidade ou configuração de lembretes fora da regra;
- Divergências entre valores de consulta e pagamentos;
- Pacientes sem prontuário;
- Evoluções sem correspondência com o prontuário da paciente;
- Horários reservados ou ocupados sem consulta relacionada.

Uma ocorrência retornada por uma consulta de auditoria indica um ponto para análise; não significa automaticamente que exista erro. A massa de dados é demonstrativa e pode não preencher todos os registros previstos nas regras.

## 14. Indicadores, BI e possibilidades de IA

A estrutura proposta permite construir indicadores para apoiar a gestão da clínica. Exemplos:

| Indicador | Possível utilização |
|---|---|
| Taxa de comparecimento | Avaliar a proporção de consultas realizadas em relação às confirmadas. |
| Taxa de faltas | Identificar períodos ou situações com maior índice de ausência. |
| Taxa de cancelamento e remarcação | Entender a estabilidade da agenda. |
| Receita por período | Acompanhar valores registrados em pagamentos. |
| Pagamentos pendentes | Apoiar o controle financeiro. |
| Acompanhamentos pendentes | Evitar que pacientes fiquem sem contato após a consulta. |
| Exames pendentes de resultado | Acompanhar etapas do processo clínico. |
| Distribuição de consultas por médico | Apoiar o planejamento da agenda. |

### Possibilidades futuras de BI

Os dados podem alimentar painéis com filtros por período, profissional e situação, permitindo acompanhar indicadores operacionais e financeiros.

### Possibilidades futuras de IA

Em uma evolução do projeto, técnicas de IA poderiam auxiliar na identificação de padrões de faltas, previsão de demanda por horários, priorização de acompanhamentos pendentes e organização de informações clínicas. Qualquer uso de IA com dados de saúde deverá observar controles de acesso, privacidade, segurança e a LGPD.

Essas possibilidades são propostas de evolução, não funcionalidades de IA implementadas neste projeto.

## 15. Histórico de evolução do projeto

O trabalho foi desenvolvido de forma incremental, passando da compreensão do negócio à revisão do modelo e à implementação relacional.

| Etapa / registro | Evolução documentada |
|---|---|
| Levantamento do negócio | Identificação do processo de atendimento, dos problemas e das necessidades da clínica. |
| Requisitos e regras | Organização dos requisitos funcionais, não funcionais e regras de negócio com códigos para rastreabilidade. |
| Modelagem conceitual | Identificação de entidades, atributos, relacionamentos, cardinalidades e entidades associativas. |
| Diário AL05 | Atividade de modelagem conceitual avançada, com análise de relacionamentos N:N, entidades associativas e chaves. |
| Diário AL06 | Atividade de auditoria do modelo lógico, com revisão de chaves, relacionamentos e estrutura das entidades. |
| Revisão do modelo | Atualização do DER e do modelo lógico, incluindo ajustes de relacionamentos, cardinalidades e entidades necessárias ao processo. |
| Normalização | Registro das decisões relacionadas à 1FN, 2FN e 3FN e das dependências funcionais relevantes. |
| Implementação | Criação das tabelas e inserção de dados fictícios para teste. |
| Consultas SQL | Desenvolvimento e teste das consultas de gerenciamento e auditoria. |

Os diários de bordo e o histórico de commits do GitHub complementam o registro da evolução e da colaboração da equipe.

## 16. Estrutura do repositório

Os arquivos do projeto são mantidos na raiz do repositório para facilitar o acesso.

| Arquivo | Finalidade |
|---|---|
| `README.md` | Documentação geral do projeto. |
| `DER.drawio` | Diagrama entidade-relacionamento revisado e editável. |
| `modelo_logico.txt` | Modelo lógico relacional. |
| `dicionario_de_dados.txt` | Dicionário de dados. |
| `#9-normalização` | Análise das formas normais e dependências funcionais. |
| `script_sql.txt` | Criação do banco e das tabelas. |
| `script_massa_dados.txt` | Inserção dos dados fictícios de teste. |
| `consultas_gerenciamento_auditoria.sql` | Consultas gerenciais e de auditoria. |
| `Fluxograma.drawio.xml` | Fluxograma do processo de atendimento. |
| `DIARIO_DE_BORDO_AL05.pdf` | Registro da atividade AL05. |
| `DIARIO_DE_BORDO_AL06.pdf` | Registro da atividade AL06. |

> Todos os links desta documentação correspondem aos nomes dos arquivos exibidos na raiz do repositório.

## 17. Como executar

### Pré-requisitos

- MySQL 8.0.16 ou superior;
- MySQL Workbench ou outro cliente compatível com MySQL.

### Ordem de execução

1. Clone ou baixe este repositório.
2. Abra o MySQL Workbench e conecte-se ao servidor.
3. Execute `script_sql.txt` para criar o banco e as tabelas.
4. Execute `script_massa_dados.txt` para inserir os registros fictícios.
5. Execute, individualmente, as consultas de `consultas_gerenciamento_auditoria.sql`.

**Importante:** os scripts de criação e carga devem corresponder à mesma versão do modelo. Execute a criação antes da inserção dos dados. As consultas podem ser executadas separadamente, conforme a análise desejada.

## 18. Considerações finais

O projeto demonstra o processo de construção de uma solução de banco de dados a partir de um cenário real: levantamento do negócio, identificação de problemas, definição de requisitos e regras, modelagem conceitual, transformação em modelo lógico, normalização, documentação e implementação em SQL.

A estrutura proposta busca melhorar a organização das informações da clínica, apoiar o acompanhamento das pacientes e fornecer uma base para análises gerenciais futuras.

O repositório reúne os artefatos necessários para compreender a modelagem e reproduzir os testes do banco de dados.
