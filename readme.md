# Zoop Megastore Data Analysis Project

Bem-vindo ao repositório do projeto **Zoop Megastore Data Analysis**! Durante os nossos estudos, assumiremos o papel de analistas de dados da Zoop Megastore, uma empresa de varejo que comercializa desde utensílios e eletrodomésticos até produtos alimentícios. O objetivo é explorar os dados para obter insights e responder perguntas de negócio.

## Estrutura das Tabelas

### 1. Tabela de Vendas
- **id_venda**: Chave primária
- **data_venda**: Data da venda
- **total_venda**: Valor total da venda
- **cliente_id**: Chave estrangeira, relaciona com a tabela de clientes

### 2. Tabela de Produtos
- **id_produto**: Chave primária
- **nome_produto**: Nome do produto
- **preco**: Preço do produto
- **categoria_id**: Chave estrangeira, relaciona com a tabela de categorias
- **marca_id**: Chave estrangeira, relaciona com a tabela de marcas
- **fornecedor_id**: Chave estrangeira, relaciona com a tabela de fornecedores
- **data_estoque**: Data da última compra de estoque
- **status**: Status do produto (Vendido, Fora de linha, etc.)

### 3. Tabela de Clientes
- **id_cliente**: Chave primária
- **nome_cliente**: Nome completo do cliente
- **idade**: Idade do cliente
- **endereco**: Endereço do cliente

### 4. Tabela de Categorias
- **id_categoria**: Chave primária
- **nome_categoria**: Nome da categoria

### 5. Tabela de Fornecedores
- **id_fornecedor**: Chave primária
- **nome**: Nome do fornecedor
- **contato**: Contato do fornecedor

### 6. Tabela de Marcas
- **id_marca**: Chave primária
- **nome**: Nome da marca

### 7. Tabela de Itens Venda
- **venda_id**: Chave estrangeira, relaciona com a tabela de vendas
- **produto_id**: Chave estrangeira, relaciona com a tabela de produtos

## Objetivo do Projeto

Nosso trabalho será focado em entender os dados, desenvolver consultas SQL eficientes e criar análises úteis que suportem decisões estratégicas. Exploraremos vendas, clientes, produtos e categorias para gerar relatórios e visualizações que ajudem a Zoop Megastore a otimizar suas operações.

## Como Contribuir

1. Faça um fork do repositório.
2. Crie uma branch para suas alterações: `git checkout -b feature/nome-da-feature`.
3. Realize suas mudanças e faça commit: `git commit -m 'Descrição das alterações'`.
4. Envie sua branch: `git push origin feature/nome-da-feature`.
5. Abra um Pull Request.

## Ferramentas Utilizadas

- **SQL**: Para consultas e manipulação de dados.
- **Python**: Para análise de dados e automação.
- **Power BI**: Para criação de dashboards e relatórios.
- **Excel**: Para manipulação e visualização preliminar de dados.

## Conclusão

Com este projeto, aprenderemos práticas essenciais de análise de dados, explorando todo o ciclo de trabalho de um analista de dados. Vamos construir insights significativos para a Zoop Megastore enquanto desenvolvemos nossas habilidades técnicas e analíticas.

---

**Disclaimer**: Este projeto é fictício e criado para fins educacionais.