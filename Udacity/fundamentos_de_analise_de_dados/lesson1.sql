### LIMIT

/*
Tente você mesmo(a) abaixo escrevendo uma consulta que limita a resposta a
apenas as 15 primeiras linhas e inclua os campos occurred_at, account_id e
channel na tabela web_events.
*/
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

