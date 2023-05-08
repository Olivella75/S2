USE optic;

/*Llista el total de compres d’un client/a.*/
SELECT customer.name AS customer, brand.name AS shopping, sales.date
FROM sales 
INNER JOIN glasses ON sales.glasses = glasses.glasses_id
INNER JOIN brand ON glasses.brand = brand_id
INNER JOIN customer ON sales.customer = customer.customer_id
WHERE customer.customer_id = 1;

/*Llista les diferents ulleres que ha venut un empleat durant un any.*/
SELECT glasses.brand AS glasses_model, glasses.price, customer.name AS customer, sales.date, employee.name AS employee
FROM optic.sales
INNER JOIN optic.glasses ON sales.glasses = glasses.glasses_id
INNER JOIN optic.employee ON sales.employee = employee.employee_id
LEFT JOIN optic.customer ON sales.customer = customer.customer_id
WHERE employee.employee_id = 1;

/*Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.*/
SELECT DISTINCT supplier.name
FROM supplier
INNER JOIN brand ON supplier.supplier_id = brand.brand_id
INNER JOIN sales ON brand.brand_id = sales.sales_id
WHERE sales.sales_id > 0;
