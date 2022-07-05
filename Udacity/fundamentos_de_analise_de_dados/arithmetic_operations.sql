/* Crie uma coluna que divida a standard_amt_usd pela standard_qty para encontrar o preço por unidade para papel padrão em cada pedido. 
Limite os resultados para os 10 primeiros pedidos e inclua os campos id e account_id. */

SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

/* Escreva uma consulta que encontra a percentagem de receita que vem de papel pôster para cada pedido. 
Você vai precisar usar apenas as colunas que terminam com _usd. (Tente fazer isso sem usar a coluna de total). 
Inclua os campos id e account_id */

SELECT  id, 
		account_id, 
        poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders;