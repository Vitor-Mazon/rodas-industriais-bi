-- 03_kpis_produtos.sql
-- KPIs relacionados aos produtos (rodas) utilizando a view vw_fat_venda_valor + dim_produto + fat_item_venda
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- 1) Quantidade de rodas cotadas (volume) por categoria e tipo de roda
-------------------------------------------------------------------------------
SELECT
    p.categoria,
    p.tipo_roda,
    SUM(iv.qtde) AS qtde_cotada
FROM fat_item_venda iv
INNER JOIN dim_produto p
    ON iv.id_roda = p.id_roda
GROUP BY
    p.categoria,
    p.tipo_roda
ORDER BY
    qtde_cotada DESC;

-------------------------------------------------------------------------------
-- 2) Quantidade e faturamento total por produto
-------------------------------------------------------------------------------
SELECT
    p.categoria,
    p.tipo_roda,
    p.marca,
    p.modelo,
    SUM(iv.qtde) AS qtde_vendida,
    SUM(iv.valor_unit * iv.qtde) AS faturamento_total
FROM fat_item_venda iv
INNER JOIN fat_venda v 
    ON iv.id_venda = v.id_venda
INNER JOIN dim_produto p 
    ON iv.id_roda = p.id_roda
WHERE v.status = 'FECHADA'
GROUP BY
    p.categoria,
    p.tipo_roda,
    p.marca,
    p.modelo
ORDER BY
    faturamento_total DESC;

-------------------------------------------------------------------------------
-- 3) Participação (%) por tipo de roda no faturamento total (FECHADAS)
-- O CROSS JOIN replica o faturamento total para todas as linhas,
-- permitindo o cálculo da participação percentual por tipo de roda
-------------------------------------------------------------------------------

SELECT
    p.tipo_roda,
    SUM(iv.valor_unit * iv.qtde) AS faturamento_tipo,
    (SUM(iv.valor_unit * iv.qtde) * 1.0 / total.faturamento_total) *100  AS participacao_pct
FROM fat_item_venda iv
INNER JOIN fat_venda v
    ON iv.id_venda = v.id_venda
INNER JOIN dim_produto p
    ON iv.id_roda = p.id_roda
CROSS JOIN (
    SELECT SUM(iv2.valor_unit * iv2.qtde) AS faturamento_total
    FROM fat_item_venda iv2
    INNER JOIN fat_venda v2
        ON iv2.id_venda = v2.id_venda
    WHERE v2.status = 'FECHADA'
) AS total
WHERE v.status = 'FECHADA'
GROUP BY
    p.tipo_roda,
    total.faturamento_total
ORDER BY
    participacao_pct DESC;

-------------------------------------------------------------------------------
-- 4) Sazonalidade : faturaemnto por modelo por mês (apenas vendas FECHADAS)
-------------------------------------------------------------------------------
SELECT
    DATE_FORMAT(v.data_venda, '%Y-%m') AS ano_mes,
    p.tipo_roda,
    p.modelo,
    SUM(iv.qtde) AS qtde_total,
    SUM(iv.valor_unit * iv.qtde) AS faturamento_modelo_mes
FROM fat_item_venda iv
INNER JOIN fat_venda v
    ON iv.id_venda = v.id_venda
INNER JOIN dim_produto p
    ON iv.id_roda = p.id_roda
WHERE v.status = 'FECHADA'
GROUP BY
    DATE_FORMAT(v.data_venda, '%Y-%m'), -- Ano-mês no formato YYYY-MM para facilitar visualização em dashboards
    p.tipo_roda,
    p.modelo
ORDER BY
    ano_mes,
    faturamento_modelo_mes DESC;

--------------------------------------------------------------------------------
-- 5) Ranking de modelos por fatramento (TOP rodas)
--------------------------------------------------------------------------------
SELECT
    RANK() OVER (ORDER BY faturamento_modelo DESC) AS posicao,
    categoria,
    tipo_roda,
    modelo,
    qtde_total,
    faturamento_modelo
FROM (
    SELECT
        p.tipo_roda,
        p.modelo,
        p.categoria,
        SUM(iv.qtde) AS qtde_total,
        SUM(iv.valor_unit * iv.qtde) AS faturamento_modelo
    FROM fat_item_venda iv
    INNER JOIN fat_venda v
        ON iv.id_venda = v.id_venda
    INNER JOIN dim_produto p
        ON iv.id_roda = p.id_roda
    WHERE v.status = 'FECHADA'
    GROUP BY
        p.tipo_roda,
        p.modelo,
        p.categoria
) AS t
ORDER BY
    posicao;

-------------------------------------------------------------------------------
-- Fim dos KPIs de produtos
-------------------------------------------------------------------------------