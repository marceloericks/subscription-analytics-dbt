# Subscription Analytics Pipeline com dbt, DuckDB e SQL

## Contexto

Projeto de Analytics Engineering desenvolvido para transformar dados brutos de clientes, assinaturas e pagamentos em uma camada analítica confiável, documentada e pronta para consumo.

A solução foi construída utilizando dbt, DuckDB e SQL, seguindo uma arquitetura moderna de transformação de dados baseada em camadas analíticas. O projeto contempla modelagem dimensional, testes automatizados de qualidade, documentação da linhagem dos dados e construção de métricas de negócio voltadas à análise de clientes, assinaturas e receita.

O objetivo foi simular um cenário real de Analytics Engineering, aplicando boas práticas utilizadas em ambientes corporativos para garantir confiabilidade, rastreabilidade e reutilização dos ativos de dados.

---

## Meu Papel

Atuei como Analytics Engineer responsável pelo desenvolvimento completo da solução.

Minhas responsabilidades incluíram:

- Estruturação da arquitetura do projeto em dbt.
- Desenvolvimento das transformações SQL.
- Construção dos modelos Staging, Facts, Dimensions e Mart.
- Implementação de regras de negócio para pagamentos e assinaturas.
- Configuração de testes automatizados de qualidade de dados.
- Documentação da linhagem dos dados utilizando dbt Docs.
- Organização do versionamento e documentação técnica do projeto com Git e GitHub.

O projeto foi desenvolvido de ponta a ponta, desde a preparação dos dados brutos até a construção da camada final de métricas analíticas.

---

## Principais Desafios

- Estruturar uma pipeline analítica seguindo boas práticas de Analytics Engineering.
- Padronizar dados provenientes de diferentes entidades de negócio.
- Implementar regras de negócio para assinaturas e pagamentos.
- Garantir qualidade e consistência dos dados através de testes automatizados.
- Construir modelos reutilizáveis para análises futuras.
- Documentar completamente as dependências e transformações da pipeline.

---

## Principais Funcionalidades

- Padronização e tratamento de dados de clientes, assinaturas e pagamentos.
- Construção de modelos analíticos reutilizáveis.
- Modelagem dimensional utilizando tabelas fato e dimensão.
- Implementação de regras de negócio para receita líquida e status de assinaturas.
- Construção de métricas analíticas prontas para consumo.
- Testes automatizados de qualidade de dados.
- Documentação automática da linhagem dos dados através do dbt Docs.
- Organização modular das transformações utilizando dbt.

---

## Stack

- SQL
- dbt
- DuckDB
- YAML
- Git
- GitHub
- Data Modeling
- Data Quality Testing

---

## Competências Demonstradas

- Analytics Engineering
- SQL
- Data Transformation
- Data Modeling
- Data Quality
- dbt
- DuckDB
- Documentação de Dados
- Construção de Pipelines Analíticas
- Versionamento com Git

---

## Arquitetura da Solução

A pipeline foi estruturada para transformar dados brutos de clientes, assinaturas e pagamentos em uma camada analítica confiável, documentada e pronta para consumo.

A arquitetura adotada segue uma abordagem em camadas amplamente utilizada em projetos de Analytics Engineering, permitindo separar responsabilidades entre preparação, modelagem e disponibilização dos dados. Essa estrutura reduz o acoplamento entre transformações, facilita a manutenção das regras de negócio e aumenta a confiabilidade das métricas geradas ao longo da pipeline.

```text
Raw Data
    ↓
Staging
    ↓
Facts & Dimensions
    ↓
Mart
```

Cada camada desempenha um papel específico dentro do processo analítico:

- **Raw Data:** armazenamento dos dados brutos provenientes das fontes originais.
- **Staging:** padronização, limpeza e preparação inicial dos dados para consumo analítico.
- **Facts & Dimensions:** aplicação das regras de negócio e construção da modelagem analítica.
- **Mart:** consolidação de métricas e indicadores prontos para consumo por analistas e áreas de negócio.

Essa organização permite que alterações em transformações ou regras de negócio sejam realizadas de forma controlada, reduzindo impactos em modelos dependentes e aumentando a rastreabilidade das informações ao longo de toda a solução.

O Lineage Graph gerado pelo dbt documenta automaticamente as dependências entre os modelos, permitindo visualizar o fluxo completo dos dados desde as tabelas brutas até as métricas finais. Essa rastreabilidade facilita auditorias, manutenção da pipeline e identificação da origem de cada indicador disponibilizado para análise.

![Lineage Graph](images/dbt_lineage_graph.png)

---

## Estrutura do Projeto

O projeto foi organizado seguindo a separação de responsabilidades proposta pelo dbt, permitindo isolar transformações, documentação, testes e componentes reutilizáveis em áreas específicas da solução.

Essa organização facilita a manutenção da pipeline, reduz o acoplamento entre modelos e torna mais simples a evolução das regras de negócio ao longo do tempo.

A estrutura também favorece a rastreabilidade das transformações e a reutilização de componentes analíticos, seguindo práticas comuns em projetos de Analytics Engineering.

![Estrutura do Projeto](images/project_structure.png)

## Camada Staging

A camada Staging é responsável pela preparação e padronização dos dados brutos para consumo analítico.

Nesta etapa são realizadas transformações iniciais voltadas à melhoria da qualidade dos dados, padronização de atributos e aplicação das primeiras regras de negócio da solução. O objetivo é garantir que as camadas posteriores trabalhem com informações consistentes e estruturadas, reduzindo a complexidade da modelagem analítica.

As principais transformações realizadas incluem:

- Conversão de tipos de dados.
- Padronização de atributos.
- Tratamento de inconsistências.
- Limpeza de registros inválidos.
- Aplicação inicial de regras de negócio.

### stg_payments

Modelo responsável pela preparação e padronização dos dados financeiros utilizados na pipeline.

Nesta etapa são realizadas conversões de tipos, validações básicas de qualidade e identificação de pagamentos reembolsados, garantindo consistência para as etapas posteriores de modelagem financeira e construção das métricas de receita.

Transformações implementadas:

- Conversão de datas e valores monetários.
- Identificação automática de pagamentos reembolsados.
- Criação do indicador `is_refund`, utilizado posteriormente nos cálculos de receita líquida e métricas financeiras.
- Remoção de registros sem identificação válida de cliente.
- Preparação dos dados para modelagem financeira.

![stg_payments](images/stg_payments_model.png)

### stg_subscriptions

Modelo responsável pela padronização e consolidação dos dados de assinaturas utilizados na camada analítica.

Nesta etapa são aplicados tratamentos para uniformizar nomenclaturas de planos e status, além da identificação da versão mais recente de cada assinatura. O objetivo é garantir uma representação consistente do ciclo de vida das assinaturas e evitar distorções causadas por registros duplicados ou históricos desatualizados.

Transformações implementadas:

- Padronização dos planos contratados.
- Padronização dos status das assinaturas.
- Tratamento de registros duplicados.
- Identificação da versão mais recente de cada assinatura utilizando funções analíticas.
- Preparação dos dados para modelagem analítica e métricas de atividade dos clientes.

![stg_subscriptions](images/stg_subscriptions_model.png)

---

## Modelagem Analítica

Após a preparação dos dados, foi aplicada uma modelagem analítica inspirada em conceitos de modelagem dimensional.

A separação entre fatos e dimensões permite centralizar regras de negócio, reduzir a duplicação de lógica entre análises e disponibilizar modelos reutilizáveis para diferentes cenários analíticos. Essa abordagem também facilita a manutenção da pipeline e garante maior consistência na geração das métricas finais.

### Dimensão de Clientes

Modelo responsável por consolidar os principais atributos cadastrais dos clientes em uma única entidade analítica.

A centralização dessas informações permite reutilização consistente dos atributos em diferentes análises e reduz a necessidade de replicar dados descritivos em múltiplos modelos da solução.

Informações disponibilizadas:

- Identificador do cliente.
- Nome.
- E-mail.
- País.
- Data de cadastro.

### Fato de Pagamentos

Tabela fato responsável por consolidar os eventos financeiros da operação.

O modelo concentra informações relacionadas a pagamentos e reembolsos, além de aplicar regras utilizadas na construção das métricas financeiras da solução. A estrutura permite análises de receita, comportamento de pagamentos e desempenho financeiro dos clientes.

Informações disponibilizadas:

- Pagamentos realizados.
- Reembolsos.
- Receita líquida.
- Classificação de pagamentos por faixa de valor.
- Datas das transações.

![fct_payments](images/fct_payments_model.png)

### Fato de Assinaturas

Tabela fato responsável por consolidar os eventos relacionados ao ciclo de vida das assinaturas.

O modelo disponibiliza informações utilizadas para análise de atividade dos clientes, status das assinaturas e identificação da base ativa, servindo como fundamento para métricas de retenção e acompanhamento dos planos contratados.

Informações disponibilizadas:

- Plano contratado.
- Status da assinatura.
- Indicador de assinatura ativa.

---

## Camada Mart

A camada Mart representa a etapa final da pipeline e disponibiliza métricas prontas para consumo analítico.

### Construção das Métricas

A construção do modelo final foi realizada utilizando CTEs para organizar responsabilidades e facilitar manutenção da lógica de negócio.

As principais etapas incluem:

- Agregação de receita por cliente.
- Contagem de pagamentos.
- Contagem de reembolsos.
- Identificação de assinaturas ativas.

![Mart CTEs](images/mart_customer_metrics_ctes.png)

### Modelo Final

O modelo final consolida informações provenientes das dimensões e tabelas fato.

As métricas geradas incluem:

- Receita total por cliente.
- Quantidade de pagamentos.
- Quantidade de reembolsos.
- Ticket médio.
- Taxa de reembolso.
- Status da assinatura.
- Plano ativo.

![Mart Final](images/mart_customer_metrics_final.png)

---

## Qualidade de Dados

A qualidade dos dados foi incorporada diretamente ao processo de transformação através dos testes nativos do dbt.

### Testes Implementados

Foram configurados testes para validação automática dos principais identificadores e métricas da pipeline.

Validações implementadas:

#### not_null

Garante que campos críticos não contenham valores nulos.

Exemplos:

- `customer_id`
- `payment_id`
- `subscription_id`

#### unique

Garante que identificadores de negócio não possuam duplicidades indevidas.

Exemplos:

- `customer_id`
- `payment_id`

![Schema Tests](images/dbt_tests_schema_yml.png)

### Execução dos Testes

Os testes são executados automaticamente através do comando `dbt test`, permitindo identificar problemas de qualidade antes que eles impactem análises e indicadores.

A imagem abaixo demonstra a execução bem-sucedida dos testes configurados.

![dbt Test](images/dbt_test_success.png)

---

## Execução da Pipeline

A execução da pipeline é realizada através do mecanismo de dependências do dbt, utilizando referências entre modelos por meio da função `ref()`.

Essa abordagem garante que todas as transformações sejam executadas automaticamente na ordem correta.

![dbt Run](images/dbt_run_success.png)

---

## Resultados

- Pipeline analítica estruturada utilizando arquitetura em camadas.
- Construção de modelos Staging, Facts, Dimensions e Mart.
- Implementação de regras de negócio para assinaturas e pagamentos.
- Criação de métricas analíticas prontas para consumo.
- Configuração de testes automatizados de qualidade de dados.
- Documentação completa da linhagem dos dados através do dbt Docs.
- Organização modular das transformações para facilitar manutenção futura.
- Projeto desenvolvido seguindo práticas modernas de Analytics Engineering.

---

## Dataset

O projeto utiliza dados simulados de clientes, assinaturas e pagamentos para fins educacionais e demonstração técnica.