/*Visualizando os dados das tabelas, a quantidade de dados é muito grande onde fica dificil de entender, usando um Count para retornar a 
quantidade de linhas da tabela*/
SELECT * FROM categorias;

-- Qual a quantidade de vendas?
SELECT COUNT(*) As Qtd_Vendas_Totais FROM vendas; 

-- Visualizandos dos produtos, é visivel que tem valores de preço muito alto para alguns produtos, os dados vieram brutos e sem tratamentos
SELECT DISTINCT(nome_produto) from produtos;

-- Visualizando o menor valor para usar no update
SELECT * FROM produtos
WHERE nome_produto = 'Bola de Futebol'

-- Usando um update para alterar os dados, e usando uma subquery para retornar o menor valor da coluna pelo produto, isso sera feito para outros produtoscategorias
UPDATE produtos
SET preco = (
	SELECT MIN(preco)
  	FROM produtos
  	WHERE nome_produto = 'Chocolate'
  	and preco > 10 AND preco < 50)
WHERE nome_produto = 'Chocolate' and preco > 50

-- Alterando os valores de camisa, onde as camisas com o valor maior que 150 terar o preço de 149
UPDATE produtos
SET preco = (
	SELECT MAX(preco) 
    FROM produtos
	WHERE nome_produto = 'Camisa' 
    and preco > 80 AND preco < 200)
WHERE nome_produto = 'Camisa' AND preco > 200

-- Alterando os valores dos livros 
UPDATE produtos
SET preco = (
	SELECT MAX(preco) 
    FROM produtos
	WHERE nome_produto = 'Livro de Ficção' 
    and preco > 10 and preco < 200)
WHERE nome_produto = 'Livro de Ficção' AND preco > 200

-- Alterando os valores as bolas de futebol
UPDATE produtos
SET preco = (
	SELECT MAX(preco) 
    FROM produtos
	WHERE nome_produto = 'Bola de Futebol' 
    and preco > 20 and preco < 100)
WHERE nome_produto = 'Bola de Futebol' AND preco > 100

-- Alterando os valores dos celulares
UPDATE produtos
SET preco = (
	SELECT MAX(preco) 
    FROM produtos
	WHERE nome_produto = 'Celular' 
    and preco > 80 and preco < 5000)
WHERE nome_produto = 'Bola de Futebol' AND preco > 5000

SELECT preco, * FROM produtos
WHERE nome_produto = 'Camisa' 
and preco IN (80,200)
