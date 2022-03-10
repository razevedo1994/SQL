-- Provide a table that provides the region for each sales_rep along with their associated accounts.
-- This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name.
-- Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name region_name,
       s.name sales_rep_name,
       a.name account_name
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
AND r.name = 'Midwest'
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY account_name;


-- Provide a table that provides the region for each sales_rep along with their associated accounts.
-- This time only for accounts where the sales rep has a first name starting with S and in the Midwest region.
-- Your final table should include three columns: the region name, the sales rep name, and the account name.
-- Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name region_name,
       s.name sales_rep_name,
       a.name account_name
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
AND r.name = 'Midwest'
AND s.name LIKE 'S%'
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY account_name;

-- Provide a table that provides the region for each sales_rep along with their associated accounts.
-- This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
-- Your final table should include three columns: the region name, the sales rep name, and the account name.
-- Sort the accounts alphabetically (A-Z) according to the account name.

SELECT r.name region_name,
       s.name sales_rep_name,
       a.name account_name
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
AND s.name LIKE '% K%'
AND r.name = 'Midwest'
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY account_name;
