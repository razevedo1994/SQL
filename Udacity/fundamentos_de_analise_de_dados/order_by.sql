/* Escreva uma consulta que retorna os 10 primeiros pedidos na tabela orders. 
Inclua id, occurred_at e total_amt_usd */

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

/* Escreva uma consulta para retornar os top 5 pedidos ordenados pelo maior total_amt_usd. 
Inclua id, account_id e total_amt_usd */

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/* Escreva uma consulta para retornar os últimos 20 pedidos ordenados pelo menor total. 
Inclua id, account_id e total */

SELECT id, account_id, total
FROM Orders
ORDER BY total
LIMIT 20;

/* Escreva uma consulta que retorna as primeiras 5 linhas de orders, ordenadas do mais novo ao mais antigo, e 
com ordenação pelo maior total_amt_usd para cada data listada */

SELECT *
FROM orders
ORDER BY occurred_at, total_amt_usd DESC
LIMIT 5;

/* Escreva uma consulta que retorna as primeiras 10 linhas de orders, ordenadas do mais antigo ao mais novo, 
mas com o menor total_amt_usd para cada data listada primeiro para cada data. */

SELECT *
FROM orders
ORDER BY occurred_at, total_amt_usd
LIMIT 10;