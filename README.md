# Subscription Analytics Pipeline com dbt, DuckDB e SQL

## Visão Geral

Projeto de Analytics Engineering desenvolvido para transformar dados brutos de clientes, assinaturas e pagamentos em uma camada analítica confiável, documentada e pronta para consumo.

A solução foi construída utilizando dbt, DuckDB e SQL, seguindo uma arquitetura em camadas e incorporando testes automatizados, documentação da linhagem dos dados e modelagem analítica orientada a métricas de negócio.

## Meu Papel

Atuei como Analytics Engineer responsável pelo desenvolvimento completo da pipeline analítica.

As atividades realizadas incluíram:

- Estruturação da arquitetura do projeto em dbt.
- Desenvolvimento das transformações SQL.
- Construção dos modelos Staging, Facts, Dimensions e Mart.
- Implementação de regras de negócio para pagamentos e assinaturas.
- Configuração de testes automatizados de qualidade de dados.
- Documentação da linhagem dos dados através do dbt Docs.
- Versionamento e documentação técnica do projeto utilizando Git e GitHub.

O projeto foi desenvolvido seguindo conceitos modernos de Analytics Engineering, com foco em modularidade, rastreabilidade, reutilização de código e confiabilidade dos dados.

## Arquitetura da Solução

A pipeline foi estruturada seguindo o fluxo:

**Raw Data → Staging → Facts & Dimensions → Mart**

Essa abordagem permite separar responsabilidades entre as diferentes camadas do projeto.

- A camada **Raw** representa os dados de origem.
- A camada **Staging** realiza limpeza, padronização e preparação dos dados.
- A camada **Facts & Dimensions** organiza os dados em entidades analíticas reutilizáveis.
- A camada **Mart** concentra métricas prontas para consumo.

Essa separação reduz acoplamento entre transformações, facilita manutenção e melhora a rastreabilidade dos dados.

O Lineage Graph gerado pelo dbt documenta automaticamente as dependências entre os modelos.

A visualização permite identificar exatamente quais transformações contribuem para cada modelo final, facilitando auditoria, manutenção e análise de impacto em futuras alterações.

![Lineage Graph](images/dbt_lineage_graph.png)

## Principais Funcionalidades

- Padronização e tratamento de dados de clientes, assinaturas e pagamentos.
- Construção de modelos analíticos reutilizáveis.
- Implementação de regras de negócio em SQL.
- Modelagem em camadas seguindo boas práticas de Analytics Engineering.
- Testes automatizados de qualidade de dados com dbt.
- Documentação automática da linhagem dos dados.
- Geração de métricas prontas para consumo analítico.

## Estrutura do Projeto

Organização do projeto dbt contendo modelos, documentação, testes e componentes de transformação.

![Estrutura do Projeto](images/project_structure.png)

## Camada Staging

A camada Staging é responsável por transformar dados brutos em dados confiáveis para utilização nas etapas seguintes da pipeline.

Nessa camada são realizadas atividades como:

- Padronização de formatos.
- Limpeza de valores inconsistentes.
- Conversão de tipos de dados.
- Normalização de atributos.
- Aplicação inicial de regras de negócio.

### stg_payments

Modelo responsável pelo tratamento dos dados financeiros.

Entre as transformações implementadas estão:

- Identificação de transações reembolsadas.
- Normalização de campos financeiros.
- Tratamento de datas e atributos monetários.
- Criação da métrica `net_revenue`, utilizada posteriormente nos cálculos de receita líquida.

A separação dessa lógica em uma camada específica evita duplicação de regras ao longo do projeto.

![stg_payments](images/stg_payments_model.png)

### stg_subscriptions

Modelo responsável pela preparação dos dados de assinaturas.

As transformações incluem:

- Padronização dos status de assinatura.
- Tratamento de registros inconsistentes.
- Criação do indicador de assinatura ativa.
- Organização dos atributos utilizados na modelagem analítica.

![stg_subscriptions](images/stg_subscriptions_model.png)

## Modelagem Analítica

Após a preparação dos dados, foi utilizada uma abordagem inspirada em modelagem dimensional para organizar as entidades de negócio.

O objetivo dessa camada é criar modelos reutilizáveis e desacoplados das regras de limpeza implementadas anteriormente.

### Dimensão de Clientes

A dimensão de clientes concentra atributos descritivos dos usuários.

Entre os dados disponibilizados estão:

- Identificador do cliente.
- Nome.
- E-mail.
- País.
- Data de cadastro.

Essa estrutura permite enriquecer análises futuras sem necessidade de consultar diretamente os dados brutos.

### Fato de Pagamentos

Tabela fato responsável por registrar eventos financeiros relacionados aos clientes.

O modelo consolida:

- Valores pagos.
- Valores reembolsados.
- Receita líquida.
- Datas das transações.

A utilização de uma tabela fato facilita agregações e cálculos de métricas financeiras.

![fct_payments](images/fct_payments_model.png)

### Fato de Assinaturas

Tabela fato responsável pelos eventos relacionados às assinaturas.

O modelo contém:

- Plano contratado.
- Status da assinatura.
- Indicador de assinatura ativa.

Essas informações são posteriormente utilizadas na construção das métricas finais de negócio.

## Camada Mart

A camada Mart representa a etapa final da pipeline.

Seu objetivo é disponibilizar métricas prontas para consumo analítico, reduzindo a necessidade de novas transformações por parte de dashboards ou relatórios.

### Construção das Métricas

A construção do modelo final foi realizada utilizando CTEs para separar responsabilidades e facilitar manutenção da lógica de negócio.

As CTEs realizam:

- Agregação de receitas por cliente.
- Contagem de pagamentos.
- Contagem de reembolsos.
- Identificação de assinaturas ativas.

![Mart CTEs](images/mart_customer_metrics_ctes.png)

### Modelo Final

O modelo final consolida informações provenientes das dimensões e fatos criados anteriormente.

As principais métricas geradas incluem:

- Receita total por cliente.
- Quantidade de pagamentos.
- Quantidade de reembolsos.
- Ticket médio.
- Taxa de reembolso.
- Status da assinatura.
- Plano ativo.

Esse modelo representa a camada de consumo da solução e pode ser utilizado diretamente em dashboards, análises exploratórias e relatórios.

![Mart Final](images/mart_customer_metrics_final.png)

## Qualidade de Dados

Uma das principais vantagens do dbt é a capacidade de incorporar testes diretamente ao processo de transformação.

Os testes foram definidos através de arquivos YAML e executados automaticamente durante a validação da pipeline.

### Configuração dos Testes

![Schema Tests](images/dbt_tests_schema_yml.png)

As validações implementadas incluem:

#### not_null

Garante que colunas críticas não contenham valores nulos.

Exemplos:

- customer_id
- payment_id
- subscription_id

#### unique

Garante que identificadores de negócio não possuam duplicidades indevidas.

Exemplos:

- customer_id
- payment_id

#### relationships

Valida a integridade referencial entre modelos.

Exemplos:

- pagamentos devem estar associados a clientes válidos.
- assinaturas devem possuir clientes existentes.

Esses testes ajudam a detectar problemas de qualidade antes que eles impactem análises ou indicadores.

### Execução dos Testes

A imagem abaixo demonstra a execução bem-sucedida dos testes configurados.

![dbt Test](images/dbt_test_success.png)

## Execução da Pipeline

Após a validação dos modelos e dos testes, o dbt realiza a materialização dos modelos analíticos.

Durante essa etapa são executadas todas as dependências definidas através da função `ref()`, respeitando automaticamente a ordem correta de processamento dos dados.

A utilização do mecanismo de dependências do dbt elimina a necessidade de gerenciamento manual da ordem de execução das transformações.

![dbt Run](images/dbt_run_success.png)

## Stack Utilizada

- SQL
- dbt
- DuckDB
- YAML
- Git
- GitHub
- Data Modeling
- Data Quality Testing

## Competências Demonstradas

- Analytics Engineering
- SQL Avançado
- Data Modeling
- Data Transformation
- Data Cleaning
- Data Quality
- dbt
- DuckDB
- Documentação de Dados
- Versionamento com Git
- Construção de Pipelines Analíticas

## Dataset

O projeto utiliza dados simulados de clientes, assinaturas e pagamentos para fins educacionais e demonstração técnica.

## Resultado

Foi construída uma pipeline analítica completa utilizando dbt e DuckDB, contemplando transformação de dados, modelagem analítica, testes automatizados e documentação da linhagem dos dados.

A solução entrega uma camada final de métricas pronta para consumo analítico, seguindo práticas modernas de Analytics Engineering, governança de dados e desenvolvimento orientado à qualidade.