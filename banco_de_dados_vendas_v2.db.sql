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

/*O projeto de análise de dados para a Zoop Megastore avançou para uma nova etapa. Fomos convidados para participar da reunião trimestral, 
cujo tema será a Black Friday.

A razão do convite é a nossa referência na área em relação à quantificação das vendas durante a Black Friday nos períodos anteriores. 
Vamos participar dessa reunião com o propósito de auxiliar na resposta a questões que possam surgir durante a elaboração das estratégias 
para a Black Friday deste ano.*/

-- Temática da reunião: quais ações focar na Black Friday deste ano?

/** Acreditamos ser importante preparar algumas consultas (queries) antes da reunião, pois criar consultas de última hora para responder 
perguntas pode levar muito tempo e a reunião tem um tempo limitado. Quanto mais rápido conseguirmos responder a essas perguntas, melhor.
Para montar essas consultas que irão nos auxiliar na reunião, vamos analisar a pauta. A pauta da reunião tem três tópicos: */

SELECT * from vendas;
SELECT * from itens_venda;
SELECT * FROM produtos;
SELECT * from fornecedores;

-- O papel dos fornecedores na Black Friday;
-- para essa resposta preciso dos itens_vendas e os fornecedores para medir a quantidade de itens vendidos por fornecedor

SELECT strftime('%Y/%m', v.data_venda) As Ano_Mes, 
f.nome As fornecedor, COUNT(iv.produto_id) as qtd_vendas
from itens_venda iv
INNER JOIN produtos p ON iv.produto_id = p.id_produto
INNER JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
INNER JOIN vendas v ON v.id_venda = iv.venda_id
WHERE Ano_Mes LIKE '%11'
GROUP by Ano_Mes, fornecedor
ORDER BY Ano_Mes;


-- A categoria de produtos da Black Friday;

SELECT strftime('%Y/%m', v.data_venda) As Ano_Mes, 
f.nome AS fornecedor, c.nome_categoria As categoria, COUNT(iv.produto_id) as qtd_vendas
from itens_venda iv
INNER JOIN produtos p ON iv.produto_id = p.id_produto
INNER JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
INNER JOIN categorias c ON c.id_categoria = p.categoria_id
INNER JOIN vendas v ON v.id_venda = iv.venda_id
WHERE Ano_Mes LIKE '%11'
GROUP by Ano_Mes, fornecedor, categoria
ORDER BY fornecedor;

-- E a performance das Black Friday anteriores e futuras.

SELECT strftime('%Y/%m', v.data_venda) As Ano_Mes, 
f.nome As fornecedor, COUNT(iv.produto_id) as qtd_vendas
from itens_venda iv
INNER JOIN produtos p ON iv.produto_id = p.id_produto
INNER JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
INNER JOIN vendas v ON v.id_venda = iv.venda_id
WHERE Ano_Mes Like '%11'
GROUP by Ano_Mes, fornecedor
ORDER BY fornecedor;

-- Os dados estão atualizados? temos um total de 150000 vendas, vamos verificar e validar
SELECT SUM(qtd_vendas) AS qtd_vendas from (
  SELECT strftime('%Y/%m', v.data_venda) As Ano_Mes, 
  f.nome As fornecedor, COUNT(iv.produto_id) as qtd_vendas
  from itens_venda iv
  INNER JOIN produtos p ON iv.produto_id = p.id_produto
  INNER JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
  INNER JOIN vendas v ON v.id_venda = iv.venda_id
  GROUP by Ano_Mes, fornecedor
  ORDER BY Ano_Mes
)

-- Foi solicitado pelo time estrategico qual o fornecedor que menos vendeu na ultima black friday, e enviar um relatorio por email

SELECT strftime('%Y/%m', v.data_venda) As Ano_Mes, f.nome, COUNT(iv.produto_id) as qtd_vendas
from itens_venda iv
INNER JOIN produtos p ON iv.produto_id = p.id_produto
INNER JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
INNER JOIN vendas v ON v.id_venda = iv.venda_id
WHERE f.nome IN ('NebulaNetworks','AstroSupply','HorizonDistributors')
GROUP by Ano_Mes, f.nome
ORDER BY Ano_Mes;

/* Participamos da reunião trimestral e entregamos uma demanda pendente, uma tarefa que surgiu, que era fornecer os dados do fornecedor 
cujos produtos tiveram a pior performance na última Black Friday. Fornecemos para eles um arquivo .csv com todas as informações de venda 
separadas por ano e mês.

Infelizmente, recebemos alguns feedbacks negativos em relação à entrega dessa demanda, pois muitas pessoas da área de negócios não sabiam 
como lidar com o arquivo .csv e interpretar os dados. Algumas conseguiram carregar no Excel e em outras ferramentas de planilha, mas a 
maioria não soube muito bem lidar com aquela tabela cheia de informações.

Portanto, é nossa responsabilidade, como time de pessoas analistas de dados, entregar essas informações e dados da melhor maneira possível 
para que a equipe da área de negócios possa consumi-los. Então, vou retrabalhar essa demanda usando o excel e gerando um grafico.*/

-- Criar uma query para exportar os dados, adicionando as vendas por fornecedor em cada coluna
SELECT Ano_Mes,
SUM(CASE WHEN fornecedor == 'NebulaNetworks' THEN qtd_vendas ELSE 0 END) AS Vendas_Nebula,
SUM(CASE WHEN fornecedor == 'AstroSupply' THEN qtd_vendas ELSE 0 END) AS Vendas_Astro,
SUM(CASE WHEN fornecedor == 'HorizonDistributors' THEN qtd_vendas ELSE 0 END) AS Vendas_Horizon
from ( 
  SELECT strftime('%Y/%m', v.data_venda) As Ano_Mes, f.nome As fornecedor, COUNT(iv.produto_id) as qtd_vendas
  from itens_venda iv
  INNER JOIN produtos p ON iv.produto_id = p.id_produto
  INNER JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
  INNER JOIN vendas v ON v.id_venda = iv.venda_id
  WHERE fornecedor IN ('NebulaNetworks','AstroSupply','HorizonDistributors')
  GROUP by Ano_Mes, fornecedor
  ORDER BY Ano_Mes)
GROUP BY Ano_Mes;


/* Nós conseguimos construir gráficos que vão apoiar o time de negócios. Vamos trazer esses gráficos para o nosso relatório final, comparando 
os fornecedores e o número de vendas que tiveram. No entanto, um dos tópicos que surgiu na reunião, e que parece ser importante abordarmos 
no nosso relatório, são as categorias dos produtos.

Para abordar esse tópico, estamos pensando em utilizar a porcentagem das categorias. Queremos saber qual é a porcentagem de representação 
de cada categoria nas nossas vendas. Acreditamos que essa é uma informação que pode guiar muito bem as decisões do time de negócio.*/

-- Calculando e exibindo percentuais de vendas por categoria, fornecedor e marca
-- Por categoria
SELECT categoria, qtd_vendas, ROUND(100.0*qtd_vendas / (SELECT COUNT(*) from itens_venda),2) || '%' AS Porcentagem
FROM(
  SELECT c.nome_categoria As categoria, COUNT(iv.produto_id) as qtd_vendas
  from itens_venda iv
  INNER JOIN produtos p ON iv.produto_id = p.id_produto
  INNER JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
  INNER JOIN categorias c ON c.id_categoria = p.categoria_id
  INNER JOIN vendas v ON v.id_venda = iv.venda_id
  GROUP by categoria)
;

-- Por fornecedor
SELECT fornecedor, qtd_vendas, ROUND(100.0*qtd_vendas / (SELECT COUNT(*) from itens_venda),2) || '%' AS Porcentagem
FROM(
  SELECT f.nome As fornecedor, COUNT(iv.produto_id) as qtd_vendas
  from itens_venda iv
  INNER JOIN produtos p ON iv.produto_id = p.id_produto
  INNER JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
  INNER JOIN vendas v ON v.id_venda = iv.venda_id
  GROUP by fornecedor
  ORDER BY fornecedor
);

-- Por marcas
SELECT marca, qtd_vendas, ROUND(100.0*qtd_vendas / (SELECT COUNT(*) from itens_venda),2) || '%' AS Porcentagem
FROM(
SELECT m.nome As marca, COUNT(iv.produto_id) as qtd_vendas
  from itens_venda iv
  INNER JOIN produtos p ON iv.produto_id = p.id_produto
  INNER JOIN marcas m ON m.id_marca = p.marca_id
  INNER JOIN vendas v ON v.id_venda = iv.venda_id
  GROUP by marca
  ORDER BY marca)
;

/* Avançamos significativamente no projeto de análise de dados para a Zoop Megastore, com ênfase na otimização das decisões para a 
Black Friday. Participamos de uma reunião de suporte, iniciando a reflexão sobre os gráficos e informações a serem incorporados no relatório 
conclusivo.

Até o momento, dedicamos nossa atenção à categoria de produtos e aos fornecedores. Contudo, agora buscamos contemplar uma visão abrangente. 
Qual tem sido o desempenho global de vendas da Zoop Megastore? */













