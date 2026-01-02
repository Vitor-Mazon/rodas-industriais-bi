--- 02_kpis_clientes.sql
--- KPIs relacionados aos clientes utilizando a view vw_fat_venda_valor + dim_cliente

-------------------------------------------------------------------------------
--- 1) Faturamento total por cliente no período
-------------------------------------------------------------------------------.
SELECT
    c.nome AS cliente,
    c.segmento,
    SUM(vv.valor_total) AS faturamento_cliente
FROM vw_fat_venda_valor vv
INNER JOIN dim_cliente c
    ON vv.id_cliente = c.id_cliente
-- WHERE vv.data_venda BETWEEN '2025-01-01' AND '2025-12-31'
WHERE vv.status = 'FECHADA'
GROUP BY
    c.nome,
    c.segmento
ORDER BY
    faturamento_cliente DESC;

-------------------------------------------------------------------------------
--- 2) Ticket médio por cliente
-- ticket médio = faturamento_cliente / qtde_vendas
-------------------------------------------------------------------------------

SELECT
    c.nome AS cliente,
    c.segmento,
    COUNT(vv.id_venda) AS qtde_vendas,
    SUM(vv.valor_total) AS faturamento_cliente,
    (SUM(vv.valor_total) * 1.0 / COUNT(vv.id_venda)) AS ticket_medio
FROM vw_fat_venda_valor vv
INNER JOIN dim_cliente c
    ON vv.id_cliente = c.id_cliente
WHERE vv.status = 'FECHADA'
GROUP BY
    c.nome,
    c.segmento
ORDER BY
    ticket_medio DESC;

-------------------------------------------------------------------------------
--- 3) Participação (%) de cada cliente no faturamento total
-------------------------------------------------------------------------------
SELECT
    c.nome AS cliente,
    c.segmento,
    SUM(vv.valor_total) AS faturamento_cliente,
    (SUM(vv.valor_total) * 1.0 / total.faturamento_total) * 100 AS participacao_pct
FROM vw_fat_venda_valor vv
INNER JOIN dim_cliente c
    ON vv.id_cliente = c.id_cliente
CROSS JOIN (
    SELECT 
        SUM(valor_total) AS faturamento_total 
    FROM vw_fat_venda_valor
    WHERE status = 'FECHADA'
) AS total
WHERE vv.status = 'FECHADA'
GROUP BY
    c.nome,
    c.segmento,
    total.faturamento_total
ORDER BY
    faturamento_cliente DESC;

-------------------------------------------------------------------------------
-- 4) Frequência de compra por cliente (número médio de compras por mês)
-- qtde de meses distintos em que o cliente realizou compras
-------------------------------------------------------------------------------
SELECT
    c.nome AS cliente,
    c.segmento,
    COUNT(DISTINCT DATE_FORMAT(vv.data_venda, '%Y-%m')) AS meses_com_compra,
    COUNT(vv.id_venda) AS qtde_vendas,
    SUM(vv.valor_total) AS faturamento_cliente,
    SUM(vv.valor_total) * 1.0 / COUNT(DISTINCT DATE_FORMAT(vv.data_venda, '%Y-%m')) AS ticket_medio_mensal
FROM vw_fat_venda_valor vv
INNER JOIN dim_cliente c
    ON vv.id_cliente = c.id_cliente
WHERE vv.status = 'FECHADA'
GROUP BY
    c.nome,
    c.segmento
ORDER BY
    meses_com_compra DESC,
    faturamento_cliente DESC;

-------------------------------------------------------------------------------
-- Fim dos KPIs de clientes
-------------------------------------------------------------------------------
