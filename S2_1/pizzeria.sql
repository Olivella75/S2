CREATE DATABASE IF NOT EXISTS `pizzeria`;

CREATE TABLE IF NOT EXISTS `pizzeria`.`store` (
	`store_id` INT NOT NULL PRIMARY KEY,
	`address` VARCHAR(45) NOT NULL,
	`zipcode` VARCHAR(5) NOT NULL,
	`city` VARCHAR(25) NOT NULL,
	`region` VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS `pizzeria`.`customer` (
	`customer_id` INT NOT NULL PRIMARY KEY,
    `name` VARCHAR(15) NOT NULL,
    `last_name` VARCHAR(25) NOT NULL,
	`address` VARCHAR(45) NOT NULL,
	`zipcode` INT(5) NOT NULL,
	`city` VARCHAR(25) NOT NULL,
	`region` VARCHAR(25) NOT NULL,
	`phone` INT(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS `pizzeria`.`employee` (
	`employee_id` INT NOT NULL PRIMARY KEY,
	`name` VARCHAR(20) NOT NULL,
	`last_name` VARCHAR(25) NOT NULL,
	`nif` VARCHAR(10) NOT NULL,
	`phone` INT(15) NOT NULL,
	`employment` ENUM('chef', 'delivery_man') NOT NULL,
    `store` INT,
	CONSTRAINT `fk_store_employee` FOREIGN KEY (`store`) REFERENCES `store` (`store_id`) 
);

CREATE TABLE IF NOT EXISTS `pizzeria`.`category` (
	`category_id` INT NOT NULL PRIMARY KEY,
    `name` VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS `pizzeria`.`product` (
	`product_id` INT NOT NULL PRIMARY KEY,
    `name` VARCHAR(25) NOT NULL,
    `type` ENUM ('pizza', 'burger', 'drink') NOT NULL,
    `description` VARCHAR(45) NOT NULL,
    `category` INT DEFAULT NULL,
    `image` BLOB DEFAULT NULL,
    `price` DECIMAL(5,2) NOT NULL,
    CONSTRAINT `fk_category_product` FOREIGN KEY (`category`) REFERENCES `category` (`category_id`)
);

CREATE TABLE IF NOT EXISTS `pizzeria`.`orders` (
	`orders_id` INT NOT NULL PRIMARY KEY, 
	`customer` INT NOT NULL,
	`time` DATETIME, /*DEFAULT CURRENT_TIMESTAMP,*/
    `delivery` ENUM ('store', 'home') NOT NULL,
    `empdelivery` INT DEFAULT NULL,
    `price` DECIMAL(5,2) NOT NULL,
    `store` INT NOT NULL,
	CONSTRAINT `fk_customer_orders` FOREIGN KEY (`customer`) REFERENCES `customer` (`customer_id`),
	CONSTRAINT `fk_empdelivery_orders` FOREIGN KEY (`empdelivery`) REFERENCES `employee` (`employee_id`),
	CONSTRAINT `fk_store_orders` FOREIGN KEY (`store`) REFERENCES `store` (`store_id`)
);

CREATE TABLE IF NOT EXISTS `pizzeria`.`order_product` (
	`orders` INT NOT NULL,
    `product` INT NOT NULL,
    `quantity` INT NOT NULL,
    PRIMARY KEY (`orders`, `product`),
    CONSTRAINT `fk_orders_orderProduct` FOREIGN KEY (`orders`) REFERENCES `orders` (`orders_id`),
    CONSTRAINT `fk_product_orderProduct` FOREIGN KEY (`product`) REFERENCES `product` (`product_id`)
);

/*DADES*/
 
 INSERT INTO `pizzeria`.`store` (store_id, address, zipcode, city, region) VALUES
	(1, 'Calle Rubió i Ors, 2', '08940', 'Cornella', 'Barcelona'),
    (2, 'Calle Ramón Sala, 8', '08940', 'Gavà', 'Barcelona');
    
INSERT INTO `pizzeria`.`customer` (customer_id, name, last_name, address, zipcode, city, region, phone) VALUES
	(1, 'Jordi', 'Olivella', 'Calle Ramón i Cajal, 34 1-1', '08940', 'Cornella', 'Barcelona', 696766846),
    (2, 'Bea', 'benito', 'Calle la Sardana, 7', '08940', 'Cornella', 'Barcelona', 696714684),
    (3, 'Juan', 'Perez', 'Calle Major, 74 5-4', '08930', 'Sant Joan Despi', 'Barcelona', 666777333),
    (4, 'Ruth', 'Lopez', 'Plaça Major, 7 1-2', '08940', 'Cornella', 'Barcelona', 666888444),
    (5, 'Oscar', 'Zapatero', 'Avenida Lamas Grande, 7 bajos', '08940', 'Cornella', 'Barcelona', 666999555),
    (6, 'Laura', 'castillejos', 'Calle Cerca, 7 8-2', '08930', 'Sant Joan Despi', 'Barcelona', 666111666);
    
INSERT INTO `pizzeria`.`employee` (employee_id, name, last_name, nif, phone, employment, store) VALUES
	(1, 'Marc', 'Badal', '11111111A', 666555111, 'chef', 1),
    (2, 'Eva', 'Sanz', '22222222B', 666555222, 'chef', 2),
    (3, 'Dani', 'Garcia', '33333333C', 666555333, 'delivery_man', 1),
    (4, 'Monica', 'Casals', '44444444D', 666555444, 'delivery_man', 2);
    
 INSERT INTO `pizzeria`.`category` (category_id, name) VALUES
	(1, 'fina'),
	(2, 'gruesa'),
    (3, 'rellena');
    
 INSERT INTO `pizzeria`.`product` (product_id, name, type, description, category, image, price) VALUES
	(1, 'vegetal', 'pizza', 'pizza de verduras', 1, NULL, 9.95),  
    (2, '3 quesos', 'pizza', 'pizza de quesos', 3, NULL, 10.50),
    (3, '4 estaciones', 'pizza', 'pizza variada', 3, NULL, 11),
    (4, 'margarita', 'pizza', 'pizza de jamon dulce', 1, NULL, 9.25),
    (5, 'simple', 'burger', 'hamburguesa pequeña', NULL, NULL, 7),
    (6, 'doble', 'burger', 'hamburguesa doble', NULL, NULL, 9),
    (7, 'triple', 'burger', 'hamburguesa triple', NULL, NULL, 11),
    (8, 'agua', 'drink', 'agua 50cl', NULL, NULL, 2),
    (9, 'agua', 'drink', 'agua con gas 50cl', NULL, NULL, 3),
    (10, 'cerveza', 'drink', 'lata de 33cl', NULL, NULL, 2.50);
    
 INSERT INTO `pizzeria`.`orders` (orders_id, customer, time, delivery, empdelivery, price, store) VALUES
	(1, 1, NULL, 'store', NULL, 37.45, 1),
    (2, 3, '2023-01-01 21:00:00', 'home', 3, 26.50, 1),
    (3, 4, NULL, 'store', NULL, 49, 2),
    (4, 5, '2023-01-01 21:30:00', 'home', 3, 11.25, 2);
    
 INSERT INTO `pizzeria`.`order_product` (orders, product, quantity) VALUES
	(1, 1, 1),
    (1, 2, 1),
    (1, 6, 1),
    (1, 9, 1),
    (1, 10, 2),
    (2, 2, 1),
    (2, 3, 1),
    (2, 10, 2),
    (3, 7, 2),
    (3, 6, 2),
    (3, 10, 2),
    (3, 8, 2),
    (4, 4, 1),
    (4, 8, 1);   