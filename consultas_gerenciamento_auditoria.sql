-- ============================================================
-- CENTRO DE GINECOLOGIA NATURAL E EMOCIONAL
-- CONSULTAS SQL DE GERENCIAMENTO E AUDITORIA
-- SGBD: MySQL 8.0.16+
-- Banco: clinica_ginecologia
--
-- Como utilizar:
-- 1. Execute primeiro o script de criação das tabelas.
-- 2. Execute depois o script de massa de dados.
-- 3. Selecione o banco clinica_ginecologia.
-- 4. Execute cada consulta separadamente, conforme a necessidade.
--
-- Observação:
-- As consultas de auditoria retornam situações que merecem análise.
-- Nem todo resultado indica necessariamente erro: a massa de dados
-- do projeto é demonstrativa e não preenche todos os registros
-- previstos nas regras de negócio.
-- ============================================================

USE clinica_ginecologia;

-- ============================================================
-- PARTE 1 - CONSULTAS DE GERENCIAMENTO
-- ============================================================

-- G01. Agenda de consultas por período.
-- Demonstra a visualização da agenda com paciente, médico, sala
-- e situação da consulta.
SELECT
    a.data,
    a.hora_inicio,
    a.hora_fim,
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente,
    CONCAT(pm.nome, ' ', pm.sobrenome) AS medico,
    s.numero AS sala,
    c.tipo_consulta,
    c.status AS status_consulta
FROM consulta c
JOIN paciente pa ON pa.id_paciente = c.id_paciente
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
JOIN agenda a ON a.id_horario = c.id_horario
JOIN medico m ON m.id_medico = a.id_medico
JOIN funcionario f ON f.id_funcionario = m.id_funcionario
JOIN pessoa pm ON pm.id_pessoa = f.id_pessoa
JOIN sala s ON s.id_sala = a.id_sala
WHERE a.data BETWEEN '2026-10-01' AND '2026-12-31'
ORDER BY a.data, a.hora_inicio;


-- G02. Histórico de consultas de uma paciente.
-- Altere o CPF no WHERE para consultar outra paciente.
SELECT
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente,
    a.data,
    a.hora_inicio,
    CONCAT(pm.nome, ' ', pm.sobrenome) AS medico,
    c.tipo_consulta,
    c.status,
    c.valor
FROM consulta c
JOIN paciente pa ON pa.id_paciente = c.id_paciente
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
JOIN agenda a ON a.id_horario = c.id_horario
JOIN medico m ON m.id_medico = a.id_medico
JOIN funcionario f ON f.id_funcionario = m.id_funcionario
JOIN pessoa pm ON pm.id_pessoa = f.id_pessoa
WHERE p.cpf = '55555555555'
ORDER BY a.data DESC, a.hora_inicio DESC;


-- G03. Consultas agrupadas por médico e status.
-- Apoia a análise de volume de atendimentos e situações da agenda.
SELECT
    CONCAT(pm.nome, ' ', pm.sobrenome) AS medico,
    c.status,
    COUNT(*) AS total_consultas
FROM consulta c
JOIN agenda a ON a.id_horario = c.id_horario
JOIN medico m ON m.id_medico = a.id_medico
JOIN funcionario f ON f.id_funcionario = m.id_funcionario
JOIN pessoa pm ON pm.id_pessoa = f.id_pessoa
GROUP BY m.id_medico, pm.nome, pm.sobrenome, c.status
ORDER BY medico, c.status;


-- G04. Pagamentos pendentes.
-- Lista valores ainda não registrados como pagos.
SELECT
    pg.id_pagamento,
    c.id_consulta,
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente,
    a.data AS data_consulta,
    pg.valor,
    pg.forma_pagamento,
    pg.status
FROM pagamento pg
JOIN consulta c ON c.id_consulta = pg.id_consulta
JOIN paciente pa ON pa.id_paciente = c.id_paciente
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
JOIN agenda a ON a.id_horario = c.id_horario
WHERE pg.status = 'pendente'
ORDER BY a.data, pg.id_pagamento;


-- G05. Resumo financeiro por período.
-- Soma pagamentos pagos e apresenta valores por forma de pagamento.
SELECT
    DATE(pg.data_pagamento) AS dia_pagamento,
    pg.forma_pagamento,
    COUNT(*) AS quantidade_pagamentos,
    SUM(pg.valor) AS total_recebido
FROM pagamento pg
WHERE pg.status = 'pago'
  AND pg.data_pagamento >= '2026-10-01'
  AND pg.data_pagamento <  '2027-01-01'
GROUP BY DATE(pg.data_pagamento), pg.forma_pagamento
ORDER BY dia_pagamento, pg.forma_pagamento;


-- G06. Acompanhamentos e seus status.
-- Permite acompanhar os retornos previstos, realizados ou sem retorno.
SELECT
    c.id_consulta,
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente,
    a.data AS data_consulta,
    ac.data_prevista,
    ac.data_realizacao,
    ac.canal,
    ac.status AS status_acompanhamento
FROM acompanhamento ac
JOIN consulta c ON c.id_consulta = ac.id_consulta
JOIN paciente pa ON pa.id_paciente = c.id_paciente
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
JOIN agenda a ON a.id_horario = c.id_horario
ORDER BY ac.data_prevista, paciente;


-- G07. Exames e respectivos resultados.
-- Mostra o exame solicitado, a paciente, o status e o laudo, quando houver.
SELECT
    e.id_exame,
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente,
    te.nome AS tipo_exame,
    e.data_solicitacao,
    e.data_realizacao,
    e.status AS status_exame,
    r.data_resultado,
    r.laudo
FROM exame e
JOIN consulta c ON c.id_consulta = e.id_consulta
JOIN paciente pa ON pa.id_paciente = c.id_paciente
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
JOIN tipo_exame te ON te.id_tipo_exame = e.id_tipo_exame
LEFT JOIN resultado_exame r ON r.id_exame = e.id_exame
ORDER BY e.data_solicitacao DESC, e.id_exame;


-- G08. Taxa de comparecimento por status de consulta.
-- Apresenta a distribuição de consultas realizadas, faltas,
-- cancelamentos e demais situações registradas.
SELECT
    c.status,
    COUNT(*) AS quantidade,
    ROUND(
        COUNT(*) * 100.0 / NULLIF((SELECT COUNT(*) FROM consulta), 0),
        2
    ) AS percentual
FROM consulta c
GROUP BY c.status
ORDER BY quantidade DESC;


-- ============================================================
-- PARTE 2 - CONSULTAS DE AUDITORIA
-- ============================================================

-- A01. Consultas realizadas sem evolução no prontuário.
-- Regra verificada: toda consulta realizada deve gerar uma evolução.
-- Resultado esperado em uma carga completa: nenhuma linha.
SELECT
    c.id_consulta,
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente,
    a.data AS data_consulta,
    c.status
FROM consulta c
JOIN paciente pa ON pa.id_paciente = c.id_paciente
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
JOIN agenda a ON a.id_horario = c.id_horario
LEFT JOIN evolucao_prontuario ep ON ep.id_consulta = c.id_consulta
WHERE c.status = 'realizada'
  AND ep.id_evolucao IS NULL;


-- A02. Exames concluídos sem resultado cadastrado.
-- Regra verificada: todo exame concluído deve possuir resultado/laudo.
-- Resultado esperado em uma carga consistente: nenhuma linha.
SELECT
    e.id_exame,
    te.nome AS tipo_exame,
    e.id_consulta,
    e.data_realizacao,
    e.status
FROM exame e
JOIN tipo_exame te ON te.id_tipo_exame = e.id_tipo_exame
LEFT JOIN resultado_exame r ON r.id_exame = e.id_exame
WHERE e.status = 'concluido'
  AND r.id_resultado IS NULL;


-- A03. Convênios utilizados fora do período de validade ou inativos.
-- Verifica se o vínculo utilizado na consulta estava ativo e válido
-- na data marcada na agenda.
SELECT
    c.id_consulta,
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente,
    a.data AS data_consulta,
    co.nome AS convenio,
    pc.data_inicio,
    pc.data_validade,
    pc.ativo
FROM consulta c
JOIN paciente pa ON pa.id_paciente = c.id_paciente
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
JOIN paciente_convenio pc
    ON pc.id_paciente_convenio = c.id_paciente_convenio
JOIN convenio co ON co.id_convenio = pc.id_convenio
JOIN agenda a ON a.id_horario = c.id_horario
WHERE c.id_paciente_convenio IS NOT NULL
  AND (
      pc.ativo = FALSE
      OR a.data NOT BETWEEN pc.data_inicio AND pc.data_validade
  );


-- A04. Consultas sem acompanhamento cadastrado.
-- Regra verificada: cada consulta deve possuir um acompanhamento previsto.
-- Atenção: a massa demonstrativa do projeto não cadastrou acompanhamento
-- para todas as consultas; portanto, este resultado pode conter registros
-- intencionalmente ausentes na amostra.
SELECT
    c.id_consulta,
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente,
    a.data AS data_consulta,
    DATE_ADD(a.data, INTERVAL 7 DAY) AS data_prevista_regra
FROM consulta c
JOIN paciente pa ON pa.id_paciente = c.id_paciente
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
JOIN agenda a ON a.id_horario = c.id_horario
LEFT JOIN acompanhamento ac ON ac.id_consulta = c.id_consulta
WHERE ac.id_acompanhamento IS NULL;


-- A05. Acompanhamentos com data prevista diferente de sete dias
-- após a consulta.
-- Regra verificada: o acompanhamento deve ser previsto para uma semana
-- depois da consulta.
SELECT
    ac.id_acompanhamento,
    ac.id_consulta,
    a.data AS data_consulta,
    ac.data_prevista,
    DATE_ADD(a.data, INTERVAL 7 DAY) AS data_prevista_correta
FROM acompanhamento ac
JOIN consulta c ON c.id_consulta = ac.id_consulta
JOIN agenda a ON a.id_horario = c.id_horario
WHERE ac.data_prevista <> DATE_ADD(a.data, INTERVAL 7 DAY)
   OR ac.data_prevista IS NULL;


-- A06. Consultas com quantidade de lembretes diferente de três
-- ou sem exatamente um lembrete de confirmação de presença.
-- Regra verificada: três lembretes por consulta, sendo um de confirmação.
-- Atenção: a massa demonstrativa não preencheu os três lembretes para
-- todas as consultas; o resultado evidencia essa limitação da amostra.
SELECT
    c.id_consulta,
    COUNT(l.id_lembrete) AS total_lembretes,
    SUM(CASE WHEN l.tipo = 'confirmacao_presenca' THEN 1 ELSE 0 END)
        AS lembretes_confirmacao
FROM consulta c
LEFT JOIN lembrete l ON l.id_consulta = c.id_consulta
GROUP BY c.id_consulta
HAVING COUNT(l.id_lembrete) <> 3
    OR SUM(CASE WHEN l.tipo = 'confirmacao_presenca' THEN 1 ELSE 0 END) <> 1;


-- A07. Pagamentos com valor diferente do valor da consulta.
-- A consulta permite localizar divergências para conferência manual.
-- Diferenças podem ser legítimas (parcelas, pagamentos parciais ou ajustes);
-- por isso, o resultado deve ser analisado e não tratado automaticamente
-- como erro.
SELECT
    c.id_consulta,
    c.valor AS valor_consulta,
    SUM(CASE WHEN pg.status = 'pago' THEN pg.valor ELSE 0 END) AS total_pago,
    SUM(CASE WHEN pg.status = 'estornado' THEN pg.valor ELSE 0 END) AS total_estornado
FROM consulta c
LEFT JOIN pagamento pg ON pg.id_consulta = c.id_consulta
GROUP BY c.id_consulta, c.valor
HAVING total_pago - total_estornado <> c.valor;


-- A08. Pacientes sem prontuário eletrônico.
-- Regra verificada: cada paciente deve possuir um prontuário.
-- A massa demonstrativa contém prontuários apenas para parte dos pacientes,
-- então esta consulta pode apontar registros ainda não preenchidos na amostra.
SELECT
    pa.id_paciente,
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente
FROM paciente pa
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
LEFT JOIN prontuario pr ON pr.id_paciente = pa.id_paciente
WHERE pr.id_prontuario IS NULL;


-- A09. Evoluções sem prontuário correspondente ao paciente da consulta.
-- Verifica se a paciente atendida possui prontuário cadastrado.
SELECT
    ep.id_evolucao,
    c.id_consulta,
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente
FROM evolucao_prontuario ep
JOIN consulta c ON c.id_consulta = ep.id_consulta
JOIN paciente pa ON pa.id_paciente = c.id_paciente
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
LEFT JOIN prontuario pr ON pr.id_paciente = pa.id_paciente
WHERE pr.id_prontuario IS NULL;


-- A10. Horários ocupados ou reservados sem consulta vinculada.
-- Ajuda a identificar horários que podem exigir conferência da agenda.
SELECT
    a.id_horario,
    a.data,
    a.hora_inicio,
    a.hora_fim,
    a.status AS status_agenda,
    CONCAT(pm.nome, ' ', pm.sobrenome) AS medico,
    s.numero AS sala
FROM agenda a
JOIN medico m ON m.id_medico = a.id_medico
JOIN funcionario f ON f.id_funcionario = m.id_funcionario
JOIN pessoa pm ON pm.id_pessoa = f.id_pessoa
JOIN sala s ON s.id_sala = a.id_sala
LEFT JOIN consulta c ON c.id_horario = a.id_horario
WHERE a.status IN ('reservado', 'ocupado')
  AND c.id_consulta IS NULL
ORDER BY a.data, a.hora_inicio;


-- ============================================================
-- FIM DO ARQUIVO
-- ============================================================
