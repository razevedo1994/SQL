/* Recupere o ID do funcionario, o nome e o sobrenome de todos os funcionarios do banco. 
 * Ordene pelo sobrenome e, entao, pelo nome.*/
SELECT
	emp_id AS employee_id,
	fname AS first_name,
	lname AS last_name
FROM
	employee
ORDER BY
	last_name,
	first_name


/* Recupere o ID de conta, o ID de cliente e o saldo disponivel de todas as contas cujo
 * status seja igual a 'ACTIVE' e cujo saldo disponivel seja maior que U$2.500.*/
SELECT
	account_id,
	cust_id,
	avail_balance
FROM
	account
WHERE
	status = 'ACTIVE'
	AND avail_balance > 2500

	
/* Escreva uma consulta a tabela account que retorne os IDs dos empregados que abriram
 * as contas (use a coluna account.open_emp_id). Inlcua uma unica linha para cada funcionario
 * especifico.*/
SELECT DISTINCT open_emp_id FROM account