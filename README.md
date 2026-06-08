Projeto de Analytics Engineering para Subscription Analytics com dbt, DuckDB e SQL
Contexto

Projeto desenvolvido para demonstrar a construção de uma pipeline analítica moderna utilizando dbt, DuckDB e SQL.

O objetivo foi transformar dados brutos de clientes, assinaturas e pagamentos em modelos analíticos organizados, documentados e testados, seguindo boas práticas de Analytics Engineering.

A solução foi estruturada utilizando arquitetura em camadas (Staging → Facts & Dimensions → Mart), permitindo rastreabilidade completa das transformações e geração de métricas prontas para consumo analítico.

Objetivos do Projeto
Padronizar e limpar dados brutos provenientes de múltiplas fontes.
Construir modelos analíticos reutilizáveis.
Implementar regras de negócio utilizando SQL.
Aplicar testes automatizados de qualidade de dados com dbt.
Documentar dependências entre modelos através de Lineage Graph.
Disponibilizar uma camada final de métricas para análise de clientes e assinaturas.
Arquitetura da Solução

A pipeline foi estruturada seguindo a seguinte arquitetura:

Raw Data → Staging → Facts & Dimensions → Mart




Estrutura do Projeto

Organização completa do projeto dbt.




Camada Staging

A camada Staging é responsável pela limpeza, padronização e preparação dos dados brutos.

stg_payments

Transformação dos dados de pagamentos, incluindo tratamento de tipos de dados e identificação de reembolsos.

stg_subscriptions

Padronização dos planos de assinatura, tratamento de status e remoção de registros duplicados.

Camada Analítica
Dimensão de Clientes

Modelo responsável pela consolidação das informações cadastrais dos clientes.

Fato de Pagamentos

Tabela fato contendo os eventos financeiros e métricas derivadas.




Fato de Assinaturas

Tabela fato contendo informações relacionadas às assinaturas e seu status.

Camada Mart

A camada Mart concentra as métricas finais utilizadas para consumo analítico.

Construção das Métricas

Agregação de receita, pagamentos e reembolsos por cliente.




Modelo Final

Geração da tabela analítica consolidada contendo:

Receita total
Quantidade de pagamentos
Quantidade de reembolsos
Ticket médio
Taxa de reembolso
Status da assinatura
Plano ativo




Qualidade de Dados

Foram implementados testes automatizados utilizando dbt para garantir integridade dos modelos.

Principais validações:

not_null
unique
integridade de chaves
consistência de métricas
Configuração dos Testes




Execução dos Testes




Execução da Pipeline

Execução completa dos modelos através do comando dbt run.




Stack Utilizada
SQL
dbt
DuckDB
YAML
Git
GitHub
Data Modeling
Data Quality Testing
Competências Demonstradas
Analytics Engineering
SQL Avançado
Data Modeling
Data Transformation
Data Cleaning
Data Quality
dbt
DuckDB
Versionamento com Git
Documentação Técnica
Construção de Pipelines Analíticas
Dataset

O projeto utiliza dados simulados de clientes, assinaturas e pagamentos para fins educacionais e demonstração técnica.

Resultado

Foi construída uma pipeline analítica completa utilizando dbt e DuckDB, contemplando ingestão de dados, transformação, modelagem dimensional, testes automatizados e documentação da linhagem dos dados.

A solução entrega uma camada final de métricas preparada para consumo analítico, seguindo práticas modernas de Analytics Engineering.
