# Projeto: Análise Industrial de Vendas de Rodas  
### *Modelagem Dimensional, SQL Analítico e Dashboard Power BI*

---
Dados do Projeto

Os arquivos de dados utilizados neste projeto estão organizados na pasta [`/data`](./data):

- [`DIM_CLIENTE`](./data/dim_cliente.csv) – cadastro e segmentação de clientes  
- [`DIM_PRODUTO`](./data/dim_produto.csv) – catálogo técnico de rodas  
- [`FAT_VENDA`](./data/fat_venda.csv) – cabeçalho das vendas  
- [`FAT_ITEM_VENDA`](./data/fat_item_venda.csv) – itens de cada venda
---
## 1. Objetivo do Projeto

Este projeto simula uma operação real de uma empresa industrial que fabrica e comercializa **rodas industriais** (tração, apoio, carga e roletes).  
O objetivo é construir um pipeline completo de análise de dados:

- Modelagem dimensional (modelo estrela)
- Criação de dataset industrial
- SQL analítico para clientes, produtos e vendas
- KPIs estratégicos
- Dashboard no Power BI
- Documentação profissional para portfólio

---

## 2. Estrutura do Banco de Dados (Modelo Estrela)

O modelo dimensional foi criado para permitir análises rápidas e escaláveis.

### Tabelas Dimensão

#### **DIM_CLIENTE**
Contém informações cadastrais e segmentação:
- id_cliente  
- nome  
- cidade  
- estado  
- segmento  

#### **DIM_PRODUTO**
Catálogo técnico das rodas:
- id_roda  
- tipo_roda  
- modelo  
- diametro  
- largura  
- marca  
- categoria  

#### **DIM_DATA**
Gerada posteriormente no Power BI:
- data  
- ano  
- mês  
- nome_do_mês  
- trimestre  

---

### Tabelas Fato

#### **FAT_VENDA**
Estrutura das vendas:
- id_venda  
- id_cliente  
- data_venda  
- canal_venda  
- status  

#### **FAT_ITEM_VENDA**
Itens que compõem cada venda:
- id_item  
- id_venda  
- id_roda  
- qtde  
- valor_unit  
- valor_linha (qtde × valor_unit)

---

## 3. KPIs Definidos

### Clientes
- Faturamento total  
- Ticket médio  
- Participação (%) no faturamento  
- Frequência de compra  
- Curva ABC  
- Ranking por faturamento  

### Produtos
- Quantidade vendida por roda  
- Faturamento total por modelo  
- Participação por tipo_roda  
- Ticket médio por modelo  
- Sazonalidade por modelo  

### Vendas
- Faturamento mensal  
- Número de vendas por mês  
- Faturamento por canal  
- Taxa de cancelamento  

---

## 4. SQL Analítico (Exemplos)

```sql
SELECT
    c.nome,
    SUM(v.valor_total) AS faturamento,
    SUM(v.valor_total) / total.faturamento_total * 100 AS participacao_pct
FROM FAT_VENDA v
JOIN DIM_CLIENTE c ON v.id_cliente = c.id_cliente
CROSS JOIN (
    SELECT SUM(valor_total) AS faturamento_total FROM FAT_VENDA
) AS total
GROUP BY c.nome, total.faturamento_total;
