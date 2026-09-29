# Sistema de Gestão para Clínica de Ginecologia Natural e Emocional

Projeto de modelagem de banco de dados desenvolvido para o **Centro de Ginecologia Natural e Emocional**, com o objetivo de organizar informações de pacientes, médicos, funcionários, consultas, pagamentos, prontuários, prescrições, exames e demais processos da clínica.

---

# Etapa 1 — Identificação da Empresa

### Qual é o nome da empresa?

**Centro de Ginecologia Natural e Emocional**

### Qual é o segmento?

**Saúde da Mulher / Ginecologia Natural e Integrativa**

### O que ela vende ou oferece?

Consulta e tratamento natural para todos os sintomas e diagnósticos ginecológicos.

### Quem são seus principais clientes?

Mulheres de 30 a 55 anos com diagnósticos ginecológicos e/ou sintomas.

Mulheres com:

- SOMP
- Endometriose
- Mioma
- Candidíase
- Perimenopausa

### Quais são seus principais setores?

Setores eu não sei responder (questionar).

### Como funciona atualmente?

Atualmente, o primeiro contato com o paciente é feito por uma inteligência artificial, que cuida do processo de agendamento.

Essa IA está sincronizada com o Google Calendar e sempre oferece três horários disponíveis para o paciente escolher.

Depois que o paciente escolhe o horário, a IA envia automaticamente o link de pagamento e as regras de cancelamento.

Antes da consulta, o sistema envia três lembretes, sendo um deles de confirmação da presença.

Depois da consulta, o profissional realiza um follow-up, presencial ou por telefone, uma semana depois, para verificar como o paciente está evoluindo, se iniciou o tratamento proposto e se ainda tem alguma dúvida.

Ou seja, todo o processo de agendamento e lembretes é automatizado, e apenas o acompanhamento pós-consulta é feito manualmente pelo profissional.

### Quais informações são importantes para o negócio?

- Principal queixa
- Diagnóstico, quando houver
- Perfil da paciente
- Histórico de tratamentos
- Taxa de comparecimento
- Taxa de remarcação

---

# Etapa 2 — Escolha da Empresa

Escolhemos a empresa por ser de uma pessoa próxima de um integrante do grupo.

**Observação:** questionar.

**Responsável:** Gabriel Reis  
**Data:** 24/09/2026 — 17:47

---

# Etapa 3 — Processo Atual

## Fluxo geral

**Paciente → Agenda → Faz o pagamento → Lembretes antes da consulta → Faz a consulta → Follow-up**

## Agendamento

### Quem participa?

Paciente e IA (assistente virtual).

### O que inicia o processo?

O paciente entra em contato querendo marcar uma consulta.

### O que acontece?

A IA conversa com o paciente e oferece 3 horários disponíveis, já verificando o Google Calendar.

### Qual informação é gerada?

Data e horário escolhidos e dados do paciente.

### Qual é o resultado?

Consulta marcada na agenda.

---

## Pagamento

### Quem participa?

Paciente e sistema de pagamento integrado à IA.

### O que inicia o processo?

A escolha do horário pelo paciente.

### O que acontece?

A IA envia o link de pagamento e a política de cancelamento.

### Qual informação é gerada?

Comprovante/registro do pagamento.

### Qual é o resultado?

Consulta confirmada e paga.

---

## Lembretes

### Quem participa?

IA e paciente.

### O que inicia o processo?

A aproximação da data da consulta.

### O que acontece?

São enviados 3 lembretes, sendo um deles de confirmação de presença.

### Qual informação é gerada?

Confirmação ou não da presença do paciente.

### Qual é o resultado?

Paciente ciente e confirmado para a consulta.

---

## Consulta

### Quem participa?

Paciente e profissional.

### O que inicia o processo?

O horário marcado chegou.

### O que acontece?

O atendimento clínico em si acontece.

### Qual informação é gerada?

Registro clínico: queixas, avaliação e plano de tratamento.

### Qual é o resultado?

Paciente atendido, com orientações ou protocolo definido.

---

## Pós-consulta

### Quem participa?

Profissional e paciente.

### O que inicia o processo?

Passou 1 semana da consulta.

### O que acontece?

O profissional entra em contato, presencialmente ou por telefone, para verificar a evolução.

### Qual informação é gerada?

Registro de como o paciente está, se seguiu o tratamento e suas dúvidas.

### Qual é o resultado?

Acompanhamento do progresso e ajuste do tratamento, se necessário.

**Responsável:** Gabriel Reis  
**Data:** 24/09/2026 — 17:55

---

# Etapa 4 — Problemas Identificados

## Problemas

### 1. Follow-up pós-consulta feito manualmente

O acompanhamento é realizado por telefone ou presencialmente.

### 2. Não há menção de prontuário eletrônico integrado

Os dados clínicos não estão descritos como integrados a um prontuário eletrônico.

### 3. Não há relato de relatórios

Não foram identificados relatórios sobre:

- Quantidade de agendamentos
- Faltas
- Cancelamentos
- Outros indicadores da clínica

### 4. Pagamento e agendamento parecem estar em sistemas diferentes

O link de pagamento é enviado separadamente.

## Consequências

### 1. Dependência do profissional

Depende do profissional lembrar de realizar o follow-up, podendo atrasar ou até não acontecer.

### 2. Possível perda ou dispersão dos dados

Os dados do paciente podem ficar espalhados.

### 3. Dificuldade de acompanhar o desempenho da clínica

Sem relatórios, torna-se mais difícil acompanhar os indicadores do negócio.

### 4. Risco de informações financeiras separadas

Existe o risco de a informação de pagamento não ficar registrada junto com a consulta.

**Responsável:** Gabriel Reis  
**Data:** 24/09/2026 — 18:21

---

# Etapa 5 — Cadastros Gerais

## Pessoas

O sistema deverá cadastrar pessoas:

- Nome
- Sobrenome
- CPF
- Sexo
- E-mail

O sistema deverá cadastrar o endereço e o telefone de cada pessoa.

## Pacientes

O sistema deverá cadastrar pacientes, vinculando:

- Dados da pessoa
- Tipo sanguíneo

## Funcionários

O sistema deverá cadastrar funcionários:

- Cargo
- CRM, se for o caso

## Médicos

O sistema deverá cadastrar médicos:

- CRM
- Data de contratação

## Especialidades

O sistema deverá cadastrar as especialidades médicas.

## Salas

O sistema deverá cadastrar as salas de atendimento:

- Número
- Andar

---

## Convênios

O sistema deverá:

- Cadastrar convênios
- Registrar nome
- Registrar número de registro na ANS
- Registrar telefone
- Vincular um paciente a um ou mais convênios
- Registrar número da carteirinha
- Registrar data de início
- Registrar validade do convênio

---

## Alergias

O sistema deverá:

- Cadastrar tipos de alergia
- Registrar as alergias de cada paciente
- Registrar gravidade
- Registrar data de identificação

---

## Agendamento

O sistema deverá:

- Gerenciar a agenda dos médicos
- Registrar data
- Registrar horário de início
- Registrar horário de fim
- Registrar sala
- Registrar status
- Permitir marcar uma consulta
- Vincular paciente, médico, sala e convênio, se houver
- Registrar data e hora
- Registrar tipo e status da consulta
- Permitir consultar os horários disponíveis de cada médico

---

## Pagamento

O sistema deverá registrar o pagamento de cada consulta:

- Valor
- Forma de pagamento
- Data
- Status

---

## Prontuário e Atendimento

O sistema deverá:

- Abrir um prontuário para cada paciente
- Registrar a evolução do prontuário a cada consulta
- Registrar queixa principal
- Registrar diagnóstico
- Registrar CID-10
- Registrar conduta

---

## Prescrição

O sistema deverá:

- Cadastrar medicamentos
- Gerar uma prescrição vinculada a uma consulta
- Registrar os itens da prescrição
- Registrar medicamento
- Registrar posologia
- Registrar dosagem
- Registrar duração do tratamento

---

## Exames

O sistema deverá:

- Cadastrar tipos de exame
- Registrar nome
- Registrar preço padrão
- Registrar preparo necessário
- Cadastrar laboratórios externos
- Permitir solicitar exames vinculados a uma consulta e a um paciente
- Registrar data de solicitação
- Registrar data de realização
- Registrar status do exame
- Registrar resultado do exame
- Registrar laudo
- Permitir arquivo anexo
- Registrar médico responsável

**Responsável:** Gabriel Reis  
**Data:** 24/09/2026 — 18:43

---

# Etapa 6 — Requisitos Não Funcionais

## Segurança

O sistema deverá:

- Controlar o acesso dos usuários por perfil:
  - Médico
  - Funcionário
  - Paciente
- Manter os dados do prontuário e das prescrições protegidos contra acesso não autorizado
- Manter registro das operações realizadas pelos usuários, identificando quem alterou o quê e quando

## Privacidade / LGPD

O sistema deverá:

- Seguir as regras da LGPD para armazenar dados sensíveis de saúde dos pacientes
- Permitir que o paciente solicite seus próprios dados, conforme a lei

## Desempenho

O sistema deverá:

- Apresentar as consultas e o histórico do paciente em tempo adequado para uso durante o atendimento
- Processar o agendamento, feito pela IA ou funcionário, sem demora perceptível para o paciente

## Disponibilidade

O sistema deverá:

- Estar disponível para agendamento a qualquer horário
- Manter backup periódico dos dados, evitando perda de informações do prontuário

## Usabilidade

O sistema deverá:

- Ter uma interface simples para o uso do profissional durante a consulta
- Ser fácil de usar pelo paciente ao interagir com a IA de agendamento

## Confiabilidade

O sistema deverá:

- Garantir que os dados de agendamento estejam sempre sincronizados com o Google Calendar
- Evitar duplicidade de horários
- Confirmar o pagamento antes de considerar a consulta como confirmada

## Integração

O sistema deverá:

- Integrar-se com o Google Calendar para sincronizar a agenda dos médicos
- Integrar-se com um sistema de pagamento para gerar e enviar os links automaticamente

**Responsável:** Gabriel Reis  
**Data:** 24/09/2026 — 18:43

---

# Etapa 7 — Regras de Negócio

## Pessoas, pacientes e funcionários

- Toda pessoa deve possuir CPF único.
- Um paciente está associado a apenas uma pessoa.
- Um médico está associado a apenas uma pessoa.
- Um médico deve possuir CRM válido.
- Um médico pode possuir uma ou mais especialidades. **(Questionar)**

## Convênios

- Um paciente pode possuir vários convênios. **(Questionar)**
- Um convênio deve possuir data de validade.
- Uma consulta pode ou não estar vinculada a um convênio.

## Alergias

- Um paciente pode possuir várias alergias.
- Cada alergia registrada deve possuir um grau de gravidade.

## Agendamento

- Uma consulta deve estar associada a um paciente e a um médico.
- Uma consulta deve ocorrer em uma sala disponível.
- Um médico não pode ter duas consultas marcadas no mesmo horário.
- A IA deve oferecer sempre 3 horários disponíveis ao paciente, se houver 3 horários disponíveis.
- Um horário só é considerado ocupado após a confirmação do agendamento.

## Pagamento

- Uma consulta só é confirmada após o envio do link e pagamento da consulta.
- Toda consulta deve possuir um pagamento vinculado.
- O status do pagamento deve ser atualizado conforme a confirmação.

## Lembretes e Cancelamento

- O paciente deve receber 3 lembretes antes da consulta.
- Um dos lembretes deve ser de confirmação de presença.
- Um paciente pode cancelar a consulta conforme a política de cancelamento definida.

## Prontuário e Atendimento

- Todo paciente deve possuir um prontuário.
- Um prontuário pode conter várias evoluções, sendo uma por consulta.
- Toda consulta realizada deve gerar uma evolução no prontuário.

## Prescrição

- Uma prescrição deve estar vinculada a uma consulta.
- Uma prescrição deve conter pelo menos um item (medicamento). **(Questionar)**
- Um item de prescrição deve possuir posologia e dosagem definidas.

## Exames

- Um exame deve estar vinculado a uma consulta e a um paciente.
- Um exame pode ser realizado em um laboratório externo.
- Todo exame realizado deve gerar um resultado.

## Follow-up

- Toda consulta deve gerar um follow-up após 1 semana.
- O follow-up deve verificar a evolução dos sintomas e a adesão ao tratamento.

**Responsável:** Gabriel Reis  
**Data:** 24/09/2026 — 19:07

---

# Etapa 8 — Aprovações e Alterações

## Prontuário

- Somente o médico responsável pode alterar o prontuário do paciente.

## Cadastro

- Somente funcionários autorizados podem alterar dados cadastrais de pacientes.

## Follow-up

- Somente o profissional pode confirmar a realização de um follow-up. **(Questionar)**

## Pagamento

- A consulta só é confirmada após o pagamento ou confirmação do convênio.
- O sistema deve seguir a forma de pagamento definida pela clínica, como o link de pagamento enviado pela IA.

## Cancelamento

- O cancelamento da consulta deve seguir a política definida pela clínica.
- Deve considerar prazo mínimo e existência ou não de reembolso.
- Um cancelamento feito fora do prazo pode gerar cobrança, conforme regra da clínica.

## Acesso à Informação

- Dados do prontuário são de acesso restrito à equipe médica.
- Dados financeiros, como pagamentos, são de acesso restrito à administração da clínica.
- O paciente pode acessar apenas seus próprios dados.

## Agendamento

- A IA só pode oferecer horários que estejam livres na agenda do médico.
- Um horário só é confirmado depois que o paciente escolhe e realiza o pagamento ou confirma o convênio.

## Convênios

- A clínica só aceita convênios previamente cadastrados no sistema.
- O uso do convênio depende da validade da carteirinha do paciente.

## Follow-up

- O follow-up pós-consulta é de responsabilidade do profissional que atendeu o paciente. **(Talvez colocar a IA para mandar uma mensagem automática)**
- O prazo padrão definido pela clínica para o follow-up é de 1 semana após a consulta.

**Responsável:** Gabriel Reis  
**Data:** 24/09/2026 — 20:13

---

# Etapa 10 — Entidades do Banco de Dados

As entidades identificadas no modelo são:

```text
PESSOA
ENDERECO_PESSOA
TELEFONE_PESSOA
PACIENTE
FUNCIONARIO
MEDICO
ESPECIALIDADE
MEDICO_ESPECIALIDADE
ALERGIA
PACIENTE_ALERGIA
CONVENIO
PACIENTE_CONVENIO
SALA
AGENDA
CONSULTA
PAGAMENTO
PRONTUARIO
EVOLUCAO_PRONTUARIO
MEDICAMENTO
PRESCRICAO
ITEM_PRESCRICAO
TIPO_EXAME
LABORATORIO_EXTERNO
EXAME
RESULTADO_EXAME

---

# Etapa 11 Atributos

## PESSOA

```text
id_pessoa (PK)
cpf
nome
sobrenome
sexo
email

```

## ENDERECO_PESSOA

```text
id_endereco (PK)
id_pessoa (FK)
logradouro
numero
bairro
cidade
estado
cep
complemento

```

## TELEFONE_PESSOA

```text
id_telefone (PK)
id_pessoa (FK)
numero

```

## PACIENTE

```text
id_paciente (PK)
id_pessoa (FK)
tipo_sanguineo

```

## FUNCIONARIO

```text
id_funcionario (PK)
id_pessoa (FK)
cargo
crm

```

## MEDICO

```text
id_medico (PK)
id_pessoa (FK)
crm
data_contratacao

```

## ESPECIALIDADE

```text
id_especialidade (PK)
nome

```

## MEDICO_ESPECIALIDADE

```text
id_medico (FK)
id_especialidade (FK)
rqe

```

## ALERGIA

```text
id_alergia (PK)
descricao

```

## PACIENTE_ALERGIA

```text
id_paciente (FK)
id_alergia (FK)
gravidade
data_identificacao

```

## CONVENIO

```text
id_convenio (PK)
nome
registro_ans
telefone_contato

```

## PACIENTE_CONVENIO

```text
id_paciente (FK)
id_convenio (FK)
numero_carteirinha
data_inicio
data_validade
ativo

```

## SALA

```text
id_sala (PK)
numero
andar

```

## AGENDA

```text
id_horario (PK)
id_medico (FK)
id_sala (FK)
data
hora_inicio
hora_fim
status

```

## CONSULTA

```text
id_consulta (PK)
id_paciente (FK)
id_medico (FK)
id_sala (FK)
id_convenio (FK)
data_hora
tipo_consulta
status
valor
observacoes

```

## PAGAMENTO

```text
id_pagamento (PK)
id_consulta (FK)
valor
forma_pagamento
data_pagamento
status

```

## PRONTUARIO

```text
id_prontuario (PK)
id_paciente (FK)
data_abertura
sintomas

```

## EVOLUCAO_PRONTUARIO

```text
id_evolucao (PK)
id_prontuario (FK)
id_consulta (FK)
data
queixa_principal
diagnostico
cid10
conduta

```

## MEDICAMENTO

```text
id_medicamento (PK)
nome
principio_ativo
fabricante
tarja

```

## PRESCRICAO

```text
id_prescricao (PK)
id_consulta (FK)
data_emissao
validade

```

## ITEM_PRESCRICAO

```text
id_prescricao (FK)
id_medicamento (FK)
posologia
dosagem
duracao_tratamento

```

## TIPO_EXAME

```text
id_tipo_exame (PK)
nome
preco_padrao
preparo_necessario

```

## LABORATORIO_EXTERNO

```text
id_laboratorio (PK)
nome
cnpj
telefone

```

## EXAME

```text
id_exame (PK)
id_consulta (FK)
id_tipo_exame (FK)
id_paciente (FK)
id_funcionario_responsavel (FK)
id_laboratorio_externo (FK)
data_solicitacao
data_realizacao
status

```

## RESULTADO_EXAME

```text
id_resultado (PK)
id_exame (FK)
id_medico (FK)
data_resultado
laudo
arquivo_anexo

```

---
---
# Etapa 12 — Relacionamentos

## Pessoas

```text
PESSOA — POSSUI — ENDERECO_PESSOA
PESSOA — POSSUI — TELEFONE_PESSOA
PESSOA — ESPECIALIZA — PACIENTE
PESSOA — ESPECIALIZA — MEDICO
PESSOA — ESPECIALIZA — FUNCIONARIO

```

## Convênio

```text
CONVENIO — VINCULA — PACIENTE_CONVENIO

```

## Alergias

```text
PACIENTE — POSSUI — PACIENTE_ALERGIA
ALERGIA — CLASSIFICA — PACIENTE_ALERGIA

```

## Agendamento

```text
MEDICO — TEM — AGENDA
PACIENTE — AGENDA — CONSULTA

```

## Prontuário

```text
PRONTUARIO — REGISTRA — EVOLUCAO_PRONTUARIO
CONSULTA — GERA — EVOLUCAO_PRONTUARIO

```

## Prescrição

```text
PRESCRICAO — CONTEM — ITEM_PRESCRICAO
MEDICAMENTO — COMPÕE — ITEM_PRESCRICAO

```

## Especialidade

```text
MEDICO — POSSUI — MEDICO_ESPECIALIDADE
ESPECIALIDADE — CLASSIFICA — MEDICO_ESPECIALIDADE

```

## Exames

```text
CONSULTA — SOLICITA — EXAME
TIPO_EXAME — CLASSIFICA — EXAME
EXAME — GERA — RESULTADO_EXAME
MEDICO — ASSINA — RESULTADO_EXAME
LABORATORIO_EXTERNO — PROCESSA — EXAME

```

## Pagamento

```text
CONSULTA — GERA — PAGAMENTO

```

---

# Etapa 13 — Cardinalidades

Prontuario (1,1) --- Vincula --- Convenio (1,N)

Endereco_Pessoa (1,1) --- possui --- Pessoa (1,N)

Pessoa (1,N) --- possui --- Telefone_Pessoa (1,1)

Convenio (0,N) --- vincula --- Paciente_Convenio (1,1)

Prontuario (1,1) --- registro --- Evolucao_Prontuario (1,N)

Pessoa (0,1) --- especializa --- Paciente (1,1)

Pessoa (0,1) --- especializa --- Funcionario (1,1)

Pessoa (0,1) --- especializa --- Medico (1,1)

Paciente (0,N) --- agenda --- Consulta (1,1)

Paciente (1,1) --- possui --- Prontuario (1,1)

Paciente (0,N) --- possui --- Paciente_Alergia (1,1)

Alergia (0,N) --- classifica --- Paciente_Alergia (1,1)

Paciente (0,N) --- tem --- Paciente_Convenio (1,1)

Medico (0,N) --- tem --- Agenda (1,1)

Agenda (0,1) --- Aloca --- Sala (0,N)

Medico (1,1) --- possui --- Medico_Especialidade (1,N)

Especialidade (1,N) --- classifica --- Medico_Especialidade (1,N)

Medico (0,N) --- realiza --- Consulta (1,1)

Sala (0,N) --- aloca --- Consulta (1,1)

Consulta (0,N) --- solicita --- Exame (1,1)

Tipo_Exame (0,N) --- classifica --- Exame (1,1)

Laboratorio_Externo (0,N) --- Processado_por --- Exame (1,N)

Exame (1,N) --- gera --- Resultado_Exame (1,1)

Medico (1,1) --- assinado_por --- Resultado_Exame (1,N)

Exame (1,N) --- origina --- Prescricao (1,N)

Consulta (1,N) --- gera --- Pagamento (1,1)

Consulta (1,1) --- gera --- Evolucao_Prontuario (1,1)

Prescricao (1,1) --- contem --- Item_Prescricao (1,N)

Medicamento (0,N) --- Compõe --- Item_Prescricao (1,1)

#  Etapa 14 — Relacionamentos N\:N

O relacionamento **N\:N principal** identificado no modelo é:

```text
MEDICO ↔ ESPECIALIDADE

```

Esse relacionamento é resolvido através da tabela associativa:

```text
MEDICO_ESPECIALIDADE

```

A tabela possui:

```text
id_medico (FK)
id_especialidade (FK)
rqe

```

O atributo `rqe` pertence ao relacionamento porque representa o registro de qualificação daquele médico naquela especialidade específica.

---

# Etapa 15 — Entidades Associativas

## PACIENTE — POSSUI — ALERGIA

Relacionamento realizado através da entidade associativa:

**PACIENTE_ALERGIA**

Possui atributos próprios:

- `gravidade`
- `data_identificacao`

### Justificativa

Gravidade e data de identificação não pertencem somente ao paciente nem somente à alergia.

Elas descrevem aquela alergia específica daquele paciente.

Outro paciente pode possuir a mesma alergia com uma gravidade diferente.

---

## PACIENTE — VINCULA — CONVENIO

Relacionamento realizado através da entidade associativa:

**PACIENTE_CONVENIO**

Possui atributos próprios:

- `numero_carteirinha`
- `data_inicio`
- `data_validade`
- `ativo`

### Justificativa

O número da carteirinha e as datas de validade pertencem ao vínculo entre aquele paciente e aquele convênio.

O mesmo convênio possui carteirinhas diferentes para pacientes diferentes.

---

## MEDICO — POSSUI — ESPECIALIDADE

Relacionamento realizado através da entidade associativa:

**MEDICO_ESPECIALIDADE**

Possui atributo próprio:

- `rqe`

### Justificativa

O RQE é o registro daquele médico especificamente naquela especialidade.

Não faz sentido colocar esse campo somente na tabela `MEDICO`, pois ele pode mudar de acordo com a especialidade.

Também não deve ficar na tabela `ESPECIALIDADE`, pois ela é genérica e não pertence a um médico específico.

---

## PRESCRICAO — COMPÕE — MEDICAMENTO

Relacionamento realizado através da entidade associativa:

**ITEM_PRESCRICAO**

Possui atributos próprios:

- `posologia`
- `dosagem`
- `duracao_tratamento`

### Justificativa

A posologia e a dosagem valem para aquele medicamento dentro daquela prescrição específica.

O mesmo medicamento pode possuir dosagens diferentes em prescrições diferentes.

---

**Responsável:** Gabriel Reis  
**Data:** 24/09/2026 — 21:40

---

# Etapa 18 — Justificativa das Principais Decisões

## Generalização de Pessoa em Paciente, Médico e Funcionário

Decidimos criar a tabela `PESSOA` com os dados comuns:

- `CPF`
- `nome`
- `sobrenome`
- `sexo`
- `e-mail`

E ligar a ela as tabelas:

- `PACIENTE`
- `MEDICO`
- `FUNCIONARIO`

com cardinalidade `(0,1)` do lado de Pessoa e `(1,1)` do lado de cada especialização.

Fizemos assim porque a regra de negócio diz que toda pessoa possui CPF único e que um paciente ou um médico está associado a apenas uma pessoa.

Sem isso, os mesmos dados seriam repetidos em três tabelas.

Uma médica que também fosse paciente da clínica poderia acabar tendo dois cadastros.

O `(0,1)` existe porque uma pessoa cadastrada pode não ser nenhum dos três papéis.

O `(1,1)` existe porque todo paciente, médico ou funcionário precisa ser uma pessoa.

---

## Endereço e telefone em tabelas separadas

As tabelas `ENDERECO_PESSOA` e `TELEFONE_PESSOA` ficaram fora de `PESSOA` porque uma pessoa pode ter mais de um endereço e mais de um telefone.

Por isso:

- Cada endereço ou telefone pertence a uma única pessoa.
- Uma pessoa pode possuir vários endereços ou telefones.

Se colocássemos esses campos diretamente em `PESSOA`, teríamos que limitar a um único endereço ou telefone ou criar colunas repetidas.

---

## Médico e Especialidade como N:N

Um médico pode ter uma ou mais especialidades e uma especialidade pode ser exercida por vários médicos.

Portanto, o relacionamento é N:N.

Esse relacionamento foi resolvido pela tabela:

**MEDICO_ESPECIALIDADE**

O `RQE` ficou nessa tabela porque o registro de qualificação de especialista pertence ao médico naquela especialidade específica.

Em `MEDICO`, ele não caberia porque pode mudar de uma especialidade para outra.

Em `ESPECIALIDADE`, também não caberia porque ela é genérica e não pertence a nenhum médico específico.

---

## Paciente e Alergia com gravidade e data no vínculo

Um paciente pode ter várias alergias e a mesma alergia pode aparecer em vários pacientes.

Por isso utilizamos:

**PACIENTE_ALERGIA**

Os atributos:

- `gravidade`
- `data_identificacao`

ficam nessa tabela porque descrevem aquela alergia naquele paciente.

Outro paciente pode possuir a mesma alergia com gravidade diferente.

A cardinalidade `(0,N)` do paciente existe porque ele pode não possuir nenhuma alergia registrada.

---

## Paciente e Convênio com carteirinha e validade no vínculo

A regra diz que um paciente pode possuir vários convênios, ou nenhum, e que o convênio deve possuir validade.

Os dados:

- `numero_carteirinha`
- `data_inicio`
- `data_validade`
- `ativo`

ficam em:

**PACIENTE_CONVENIO**

porque pertencem ao vínculo entre o paciente e o convênio.

O mesmo convênio possui carteirinhas diferentes para pacientes diferentes.

Na tabela `CONSULTA`, o `id_convenio` é opcional, pois uma consulta pode ou não estar vinculada a um convênio.

Isso permite atender pacientes particulares.

---

## Agenda separada de Consulta

Decidimos ter duas tabelas:

- `AGENDA`
- `CONSULTA`

porque:

- `AGENDA` representa o horário que o médico disponibiliza.
- `CONSULTA` representa o atendimento marcado com um paciente.

A tabela `AGENDA` possui informações como:

- `data`
- `hora_inicio`
- `hora_fim`
- `sala`
- `status`

Essa separação permite que a IA consulte apenas os horários livres pelo campo `status` e ofereça sempre 3 opções, conforme a regra definida.

Um médico pode ter vários horários `(0,N)`, mas cada horário pertence a um único médico `(1,1)`.

---

## Consulta ligada a paciente, médico e sala

A consulta possui cardinalidade `(1,1)` com:

- `PACIENTE`
- `MEDICO`
- `SALA`

porque a regra exige que toda consulta esteja associada a um paciente e a um médico e ocorra em uma sala disponível.

Do lado de cada um deles é `(0,N)` porque um paciente recém-cadastrado, um médico novo ou uma sala nova ainda podem não possuir nenhuma consulta.

Com o tempo, poderão possuir várias.

---

## Pagamento vinculado à Consulta

Criamos `PAGAMENTO` como uma tabela própria ligada à consulta.

Essa decisão está relacionada ao problema identificado na Etapa 4: o pagamento ficar separado do agendamento.

A regra estabelece que toda consulta deve possuir um pagamento e que ela só é confirmada depois dele ou da confirmação do convênio.

Com o pagamento registrado junto da consulta, podemos armazenar:

- `valor`
- `forma_pagamento`
- `data_pagamento`
- `status`

Isso permite que a clínica acompanhe as informações financeiras.

---

## Prontuário único por paciente, com várias evoluções

Cada paciente possui exatamente um prontuário `(1,1)`.

O prontuário pode possuir várias evoluções `(1,N)`, sendo uma por consulta realizada.

As tabelas são:

- `PRONTUARIO`
- `EVOLUCAO_PRONTUARIO`

Separamos as duas porque:

- O prontuário representa o histórico único do paciente.
- A evolução representa as informações de cada atendimento.

Na evolução ficam informações como:

- `queixa_principal`
- `diagnostico`
- `CID-10`
- `conduta`

A ligação com `CONSULTA` existe porque toda consulta realizada deve gerar uma evolução no prontuário.

---

## Prescrição e Medicamento com tabela associativa

Uma prescrição está sempre vinculada a uma consulta e pode possuir vários medicamentos.

Um medicamento também pode aparecer em várias prescrições.

Por isso criamos:

**ITEM_PRESCRICAO**

Os atributos:

- `posologia`
- `dosagem`
- `duracao_tratamento`

ficam nessa tabela porque pertencem ao medicamento dentro daquela prescrição específica.

O mesmo medicamento pode possuir dosagens diferentes em prescrições diferentes.

---

## Exame ligado a consulta, paciente, tipo e laboratório

O exame é solicitado em uma consulta e para um paciente.

Ele também possui um tipo:

**TIPO_EXAME**

Deixamos `TIPO_EXAME` separado para evitar repetição de informações como:

- `nome`
- `preco_padrao`
- `preparo_necessario`

a cada solicitação.

O laboratório externo é opcional porque a regra permite que o exame seja realizado em laboratório externo.

Cada exame realizado gera um resultado, que é assinado por um médico responsável.

Isso permite identificar quem foi responsável pelo laudo.

---

# Estrutura das Etapas

```text
Etapa 1  → Identificação da Empresa
Etapa 2  → Escolha da Empresa
Etapa 3  → Processo Atual
Etapa 4  → Problemas Identificados
Etapa 5  → Cadastros Gerais
Etapa 6  → Requisitos Não Funcionais
Etapa 7  → Regras de Negócio
Etapa 8  → Aprovações e Alterações
Etapa 9  → Fluxogramas (não incluída)
Etapa 10 → Entidades do Banco de Dados
Etapa 11 → Dicionário de Dados
Etapa 12 → Relacionamentos
Etapa 13 → Cardinalidades
Etapa 14 → Relacionamento N:N
Etapa 15 → Entidades Associativas
Etapa 16 → Não consta no material
Etapa 17 → Não consta no material
Etapa 18 → Justificativa das Principais Decisões
