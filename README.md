# Análise Industrial de Vendas de Rodas (2025)
### Modelagem Dimensional · SQL Analítico · Power BI

---

## Visão Geral

Este projeto simula uma operação real de uma **empresa industrial de rodas para movimentação interna** (empilhadeiras, transpaleteiras e paleteiras).

O objetivo é demonstrar um **pipeline completo de análise de dados**, desde a modelagem dimensional até a entrega de um dashboard executivo com insights acionáveis.

O projeto foi desenvolvido com foco em **boas práticas de BI**, clareza de negócio e aplicabilidade real.

---

## Objetivos do Projeto

- Construir um **modelo estrela** para análise de vendas industriais  
- Criar e organizar um **dataset fictício, porém realista**  
- Desenvolver **SQL analítico** para clientes, produtos e vendas  
- Definir **KPIs estratégicos** para tomada de decisão  
- Criar um **dashboard profissional no Power BI**  
- Documentar o projeto de forma adequada para portfólio  

---

## Estrutura dos Dados

Os arquivos de dados são:

- `DIM_CLIENTE`  
  Cadastro e segmentação de clientes (Indústria, Logística, Revenda)

- `DIM_PRODUTO`  
  Catálogo técnico de rodas (tipo, modelo, marca, categoria)

- `FAT_VENDA`  
  Cabeçalho das vendas (data, canal, status)

- `FAT_ITEM_VENDA`  
  Itens de cada venda (quantidade e valor unitário)

---

## Modelo Dimensional (Modelo Estrela)

### Tabelas Dimensão
- **DIM_CLIENTE**  
- **DIM_PRODUTO**  
- **DIM_DATA** (gerada no Power BI)

### Tabelas Fato
- **FAT_VENDA**  
- **FAT_ITEM_VENDA**

O modelo foi projetado para permitir análises eficientes de:
- Faturamento
- Clientes
- Produtos
- Canais de venda
- Sazonalidade
- Qualidade da operação

---

## KPIs Desenvolvidos

### Visão Geral
- Faturamento total  
- Ticket médio  
- Quantidade de vendas  
- % de vendas canceladas  

### Clientes
- Faturamento por cliente  
- Participação no faturamento (Top N)  
- Frequência de compra (meses com compra)  
- Recorrência vs ticket médio  
- Concentração de receita  

### Produtos
- Faturamento por modelo  
- Faturamento por categoria  
- Quantidade vendida  
- Participação por tipo de roda  
- Sazonalidade por categoria  

### Refinamento (Insights Acionáveis)
- % de cancelamento por canal  
- Risco de concentração (Top clientes / produtos)  
- Oportunidades de upsell  
- Análise de volume × preço médio  

---

## SQL Analítico

O projeto inclui scripts SQL para:
- Criação do banco de dados (MySQL)
- Modelagem dimensional
- Consultas analíticas de clientes e produtos

Scripts disponíveis na pasta [`/sql`](/sql):
- [`00_criacao_mysql.sql`](/sql/00_criacao_mysql.sql)
- [`01_base_modelo_estrela.sql`](/sql/01_base_modelo_estrela.sql)
- [`02_kpis_clientes.sql`](/sql/02_kpis_clientes.sql)
- [`03_kpis_produtos.sql`](/sql/03_kpis_produtos.sql)

---

## Dashboard Power BI

O dashboard foi estruturado em ( [`**4 páginas**`](/Dashboard)):

1. [**Visão Geral**](/Dashboard/01-VisãoGeral.png) — desempenho global do negócio  
2. [**Clientes**](/Dashboard/02-Clientes.png) — comportamento, recorrência e concentração  
3. [**Produtos**](/Dashboard/03-Produtos.png) — mix, sazonalidade e faturamento  
4. [**Refinamento**](/Dashboard/04-Refinamento.png) — qualidade da venda, risco e oportunidades  

O foco do dashboard é **suportar decisões gerenciais**, não apenas visualização de dados.

---

## Tecnologias Utilizadas

- MySQL  
- SQL (consultas analíticas)  
- Power BI  
- DAX  
- Modelagem Dimensional  

---

## Autor

Projeto desenvolvido por **Vitor Mazon** como parte de seu portfólio profissional em Análise de Dados / BI.
