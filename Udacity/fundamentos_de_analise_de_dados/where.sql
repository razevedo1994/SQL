/* Puxe as primeiras 5 linhas e todas as colunas da tabela orders que possuem uma 
quantia em dólares de gloss_amt_usd maior que ou igual a 1000. */

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 3;

/* Puxe as primeiras 10 linhas e todas as colunas da tabela orders que possuem uma 
total_amt_usd menor que 500. */

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

/* Filtre a tabela de contas para incluir o name(nome) da empresa, o website o ponto 
inicial de contato (primary_poc) para Exxon Mobil na tabela accounts. */

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

