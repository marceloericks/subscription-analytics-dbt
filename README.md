# Subscription Analytics Pipeline com dbt, DuckDB e SQL

## Visão Geral

Projeto de Analytics Engineering desenvolvido para transformar dados brutos de clientes, assinaturas e pagamentos em uma camada analítica confiável, documentada e pronta para consumo.

A solução foi construída utilizando **dbt**, **DuckDB** e **SQL**, seguindo uma arquitetura moderna baseada em camadas analíticas. O projeto contempla modelagem dimensional, testes automatizados de qualidade, documentação da linhagem dos dados e construção de métricas voltadas à análise de clientes, assinaturas e receita.

O projeto foi desenvolvido para simular um ambiente real de Analytics Engineering, aplicando práticas utilizadas em pipelines analíticas modernas para garantir confiabilidade, rastreabilidade e reutilização dos ativos de dados.

---

## Objetivo

Simular um cenário real de Analytics Engineering aplicando boas práticas de mercado para:

- Padronização e transformação de dados.
- Centralização de regras de negócio.
- Construção de modelos analíticos reutilizáveis.
- Garantia de qualidade dos dados.
- Disponibilização de métricas para análise de negócio.

---

## Métricas Disponibilizadas

A camada analítica final disponibiliza indicadores prontos para consumo:

- Receita Total por Cliente
- Receita Líquida
- Ticket Médio
- Quantidade de Pagamentos
- Quantidade de Reembolsos
- Taxa de Reembolso
- Status da Assinatura
- Plano Ativo
- Quantidade de Assinaturas Ativas

---

## Stack

- SQL
- dbt
- DuckDB
- YAML
- Git
- GitHub

---

## Competências Demonstradas

- Analytics Engineering
- Data Modeling
- Data Transformation
- SQL
- dbt
- Data Quality Testing
- Dimensional Modeling
- Data Documentation
- Git Version Control

---

## Arquitetura da Solução

A pipeline foi estruturada utilizando uma arquitetura em camadas para separar responsabilidades entre preparação, modelagem e disponibilização dos dados.

```text
Raw Data
    ↓
Staging
    ↓
Facts & Dimensions
    ↓
Mart
```

### Camadas

| Camada | Responsabilidade |
|---------|---------|
| Raw Data | Armazenamento dos dados brutos |
| Staging | Limpeza, padronização e preparação dos dados |
| Facts & Dimensions | Aplicação das regras de negócio e modelagem dimensional |
| Mart | Consolidação das métricas finais |

### Lineage Graph

O dbt gera automaticamente a documentação da linhagem dos dados, permitindo rastrear todas as dependências entre modelos.

![Lineage Graph](images/dbt_lineage_graph.png)

---

## Estrutura do Projeto

Organização do repositório seguindo boas práticas do dbt:

![Estrutura do Projeto](images/project_structure.png)

---

## Modelagem Analítica

### Staging

Responsável pela preparação dos dados brutos através de:

- Conversão de tipos
- Padronização de atributos
- Tratamento de inconsistências
- Remoção de registros inválidos
- Aplicação inicial de regras de negócio

#### Principais Modelos

##### stg_payments

- Conversão de datas e valores monetários
- Identificação de pagamentos reembolsados
- Criação do indicador `is_refund`
- Remoção de registros inválidos

![stg_payments](images/stg_payments_model.png)

##### stg_subscriptions

- Padronização de planos
- Padronização de status
- Tratamento de duplicidades
- Identificação da versão mais recente das assinaturas

![stg_subscriptions](images/stg_subscriptions_model.png)

---

### Dimensão de Clientes

Centraliza atributos cadastrais dos clientes:

- Customer ID
- Nome
- E-mail
- País
- Data de Cadastro

---

### Fato de Pagamentos

Consolida eventos financeiros utilizados na geração das métricas.

Principais atributos:

- Pagamentos
- Reembolsos
- Receita Líquida
- Faixa de Valor
- Data da Transação

![fct_payments](images/fct_payments_model.png)

---

### Fato de Assinaturas

Consolida informações relacionadas ao ciclo de vida das assinaturas.

Principais atributos:

- Plano Contratado
- Status da Assinatura
- Indicador de Assinatura Ativa

---

## Camada Mart

Camada final responsável pela consolidação das métricas de negócio.

Os dados brutos de clientes, assinaturas e pagamentos são transformados em um modelo analítico único, pronto para consumo por analistas, dashboards e áreas de negócio.

Principais cálculos:

- Receita por Cliente
- Quantidade de Pagamentos
- Quantidade de Reembolsos
- Ticket Médio
- Taxa de Reembolso
- Status da Assinatura
- Plano Ativo

### Modelo Analítico Final

A construção do modelo final foi realizada através de CTEs responsáveis por consolidar informações de clientes, pagamentos e assinaturas em uma única camada analítica.

![Mart CTEs](images/mart_customer_metrics_ctes.png)

![Mart Final](images/mart_customer_metrics_final.png)

### Resultado da Camada Analítica

Após a aplicação das regras de negócio e consolidação das informações, a pipeline gera uma tabela analítica pronta para consumo.

![Mart Dataset](images/mart_final_dataset.png)

### Exemplo de Métricas Geradas

| customer_id | total_revenue | payment_count | refund_count | plan |
|------------|--------------:|--------------:|-------------:|------|
| 1 | 1323 | 17 | 0 | Basic |
| 4 | 763 | 7 | 0 | Basic |
| 5 | 631 | 9 | 0 | Enterprise |
| 12 | 1146 | 15 | 1 | Enterprise |
| 20 | 1253 | 18 | 1 | Pro |

A partir dessa camada analítica é possível responder perguntas de negócio como:

- Quais clientes geram mais receita?
- Qual o volume de pagamentos por cliente?
- Qual a taxa de reembolso da operação?
- Quais planos possuem maior adesão?
- Quais clientes possuem assinaturas ativas?

O resultado é uma camada analítica reutilizável que transforma dados operacionais dispersos em informações prontas para análise e tomada de decisão.

---

## Qualidade de Dados

A qualidade dos dados foi implementada utilizando os testes nativos do dbt.

### Testes Aplicados

#### not_null

Validação de campos obrigatórios:

- `customer_id`
- `payment_id`
- `subscription_id`

#### unique

Validação de unicidade:

- `customer_id`
- `payment_id`

![Schema Tests](images/dbt_tests_schema_yml.png)

### Execução dos Testes

Validação automática através do comando `dbt test`.

![dbt Test](images/dbt_test_success.png)

---

## Execução da Pipeline

O dbt gerencia automaticamente as dependências entre modelos e executa as transformações na ordem correta.

![dbt Run](images/dbt_run_success.png)

---

## Resultados

- Pipeline analítica completa construída com dbt, DuckDB e SQL.
- Modelagem dimensional baseada em Facts e Dimensions.
- Consolidação de dados de clientes, assinaturas e pagamentos.
- Centralização das regras de negócio.
- Construção de métricas reutilizáveis para análise.
- Implementação de testes automatizados de qualidade.
- Documentação automática da linhagem dos dados.
- Estrutura preparada para evolução e manutenção.

---

## Dataset

O projeto utiliza dados simulados disponibilizados no próprio repositório.

Arquivos utilizados:

- `raw_customers.csv`
- `raw_subscriptions.csv`
- `raw_payments.csv`

Os dados foram utilizados exclusivamente para fins educacionais e demonstração técnica da solução.