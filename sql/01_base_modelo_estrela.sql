-- 01_base_modelo_estrela.sql
-- View básica para facilitar análises: consolida valor_total por venda

DROP VIEW IF EXISTS vw_fat_venda_valor;

CREATE VIEW vw_fat_venda_valor AS
SELECT 
    v.id_venda,
    v.id_cliente,
    v.data_venda,
    v.canal_venda,
    v.status,
    SUM(iv.qtde * iv.valor_unit) AS valor_total
FROM fat_venda v
INNER JOIN fat_item_venda iv 
    ON v.id_venda = iv.id_venda
GROUP BY 
    v.id_venda,
    v.id_cliente,
    v.data_venda,
    v.canal_venda,
    v.status;

-- Consulta de teste: visualizar o resultado da view
SELECT * FROM vw_fat_venda_valor
ORDER BY
    data_venda, 
    id_venda;
