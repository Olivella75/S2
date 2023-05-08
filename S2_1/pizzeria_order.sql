/*Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat (store).*/
/*Primer llisto quantes begudes s'han venut en el local 2, després et poso el detall. L'enunciat no deixa clar quina consulta vol.*/

SELECT COUNT(orders) AS ventas FROM pizzeria.order_product
INNER JOIN pizzeria.product ON order_product.product = product_id
INNER JOIN pizzeria.orders ON order_product.orders = orders_id
WHERE product.type = 'drink'
AND pizzeria.orders.store = 2
ORDER BY (orders);

SELECT orders, name AS drink, type, description, store FROM pizzeria.order_product
INNER JOIN pizzeria.product ON order_product.product = product_id
INNER JOIN pizzeria.orders ON order_product.orders = orders_id
WHERE product.type = 'drink'
AND pizzeria.orders.store = 2;

/*Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat (customer).*/
SELECT customer.name, last_name, address, zipcode, city, product.name, type, description FROM pizzeria.customer
INNER JOIN pizzeria.orders ON customer.customer_id = customer
INNER JOIN pizzeria.order_product ON orders.orders_id = order_product.orders
INNER JOIN pizzeria.product ON product_id = order_product.product
WHERE pizzeria.customer.city = "Cornella"
AND pizzeria.order_product.product >= 8;

/*Llista quantes comandes ha efectuat un determinat empleat/da.*/
SELECT COUNT(orders_id) AS num_commands, empdelivery AS employee
FROM pizzeria.orders
WHERE empdelivery = 3
GROUP BY empdelivery
ORDER BY COUNT(orders_id);

SELECT orders_id, customer, delivery, empdelivery, store, product, quantity FROM pizzeria.orders
INNER JOIN pizzeria.order_product ON order_product.orders = orders.orders_id
WHERE empdelivery = 3;