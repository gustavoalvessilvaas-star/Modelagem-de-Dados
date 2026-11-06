-- Script de Consultas SQL (Gerenciamento e Auditoria)
-- SGBD: MySQL 8.0+
-- Banco: clinica_ginecologia

USE clinica_ginecologia;

-- ============================================================
-- PARTE 1 - CONSULTAS DE GERENCIAMENTO
-- ============================================================

-- G01. Agenda de consultas por período (mostra paciente, médico, sala e status)
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


-- G02. Histórico de consultas de uma paciente pelo CPF
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


-- G03. Quantidade de consultas agrupadas por médico e por status
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


-- G04. Lista de pagamentos que ainda estão pendentes
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


-- G05. Total pago por dia e por forma de pagamento no período
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


-- G06. Status dos acompanhamentos e retornos das pacientes
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


-- G07. Exames solicitados e laudo cadastrado (se houver)
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


-- G08. Porcentagem de consultas por status (realizadas, faltas, canceladas, etc)
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

-- A01. Consultas marcadas como 'realizada' que estão sem evolução no prontuário
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


-- A02. Exames com status 'concluido' mas sem laudo/resultado cadastrado
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


-- A03. Consultas onde o convênio usado estava inativo ou fora da validade na data
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


-- A04. Consultas que não têm registro de acompanhamento cadastrado
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


-- A05. Acompanhamentos onde a data prevista não deu exatamente 7 dias após a consulta
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


-- A06. Consultas que não possuem exatamente 3 lembretes ou faltam lembrete de confirmação
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


-- A07. Consultas onde o valor total pago (descontando estornos) difere do valor da consulta
SELECT
    c.id_consulta,
    c.valor AS valor_consulta,
    SUM(CASE WHEN pg.status = 'pago' THEN pg.valor ELSE 0 END) AS total_pago,
    SUM(CASE WHEN pg.status = 'estornado' THEN pg.valor ELSE 0 END) AS total_estornado
FROM consulta c
LEFT JOIN pagamento pg ON pg.id_consulta = c.id_consulta
GROUP BY c.id_consulta, c.valor
HAVING total_pago - total_estornado <> c.valor;


-- A08. Pacientes que ainda não têm prontuário cadastrado
SELECT
    pa.id_paciente,
    CONCAT(p.nome, ' ', p.sobrenome) AS paciente
FROM paciente pa
JOIN pessoa p ON p.id_pessoa = pa.id_pessoa
LEFT JOIN prontuario pr ON pr.id_paciente = pa.id_paciente
WHERE pr.id_prontuario IS NULL;


-- A09. Evoluções registradas para consultas de pacientes sem prontuário
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


-- A10. Horários da agenda marcados como 'reservado' ou 'ocupado' sem consulta vinculada
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
