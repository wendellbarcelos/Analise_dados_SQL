SELECT * from produtos;
SELECT * from fornecedores;
SELECT * from marcas;

-- Entendendo os dados
-- Qual a quantidade de linhas em cada tabela?
SELECT COUNT(*) As Qtd_Categorias FROM categorias;
SELECT COUNT(*) As Qtd_Clientes FROM clientes;
SELECT COUNT(*) As Qtd_Fornecedores FROM fornecedores;
SELECT COUNT(*) As Qtd_ItensVendas FROM itens_venda;
SELECT COUNT(*) As Qtd_Marcas FROM marcas;
SELECT COUNT(*) As Qtd_Produtos FROM produtos;
SELECT COUNT(*) As Qtd_Vendas FROM vendas;

-- Visualizar os dados em tempo real pode ser um problema, pois a quantidade de linhas carregadas pode lentidão no sistema ou algo pior
-- pra isso não acontecer visualizamos as 5 primeiras linhas da base com a função LIMIT
SELECT * from vendas LIMIT 5;


-- Analise temporal: Ciclo de vendas
-- Vamos entender o periodo que os dados ocorreram, se teve uma quantidade na black friday, a sazonalidade desses dados

-- Qual a quantidade de vendas por mês e ano
SELECT strftime('%Y', data_venda) As Ano,
strftime('%m', data_venda) As Mês,
COUNT(id_venda) As Qtd_Vendas
from vendas
GROUP BY Ano, Mês
ORDER BY Ano;

-- Precisamos analisar os principais periodos de venda,Janeiro, Novembro e Dezembro

SELECT strftime('%Y', data_venda) As Ano,
strftime('%m', data_venda) As Mes,
COUNT(id_venda) As Qtd_Vendas
from vendas
WHERE Mes in ('01','11','12')
GROUP BY Ano, Mes
ORDER BY Ano;











