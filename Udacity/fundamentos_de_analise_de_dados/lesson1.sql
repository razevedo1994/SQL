### LIMIT

/*
Tente você mesmo(a) abaixo escrevendo uma consulta que limita a resposta a
apenas as 15 primeiras linhas e inclua os campos occurred_at, account_id e
channel na tabela web_events.
*/
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

### ORDER BY

/*
Escreva uma consulta que retorna os 10 primeiros pedidos na tabela orders.
Inclua id, occurred_at e total_amt_usd
*/
select id, occurred_at, total_amt_usd
from orders
order by occurred_at
limit 10;

/*
Escreva uma consulta para retornar os top 5 pedidos ordenados
pelo maior total_amt_usd. Inclua id, account_id e total_amt_usd.
*/
select id, account_id, total_amt_usd
from orders
order by total_amt_usd desc
limit 5;

/*
Escreva uma consulta para retornar os últimos 20 pedidos ordenados
pelo menor total. Inclua id, account_id e total
*/
select id, account_id, total
from orders
order by total
limit 20;