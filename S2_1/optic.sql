CREATE DATABASE IF NOT EXISTS `optic`;

CREATE TABLE IF NOT EXISTS `optic`.`address` (
    `direction_id` INT NOT NULL PRIMARY KEY,
    `street` VARCHAR(45) NOT NULL,
    `number` INT(3) NOT NULL,
    `floor` INT(2),
    `door` VARCHAR(2),
    `city` VARCHAR(25) NOT NULL,
    `zipcode` VARCHAR(5),
    `country` VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS `optic`.`supplier` (
    `supplier_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    `address` INT(3),
    `telephone` INT(15),
    `fax` INT(15) DEFAULT NULL,
    `CIF` VARCHAR(10),
    CONSTRAINT `fk_address_supplier` FOREIGN KEY (`address`) REFERENCES `address` (`direction_id`)
);

CREATE TABLE IF NOT EXISTS `optic`.`brand` (
    `brand_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(25) NOT NULL,
    `supplier` INT NOT NULL,
    CONSTRAINT `fk_supplier_brand` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`supplier_id`)
);

CREATE TABLE IF NOT EXISTS `optic`.`customer` (
    `customer_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `address` INT,
    `telephone` INT(15),
    `email` VARCHAR(45) NULL,
    `date_register` DATE,
    `recommended_id` INT(3),
    CONSTRAINT `fk_address_customer` FOREIGN KEY (`address`) REFERENCES `address` (`direction_id`),
    CONSTRAINT `fk_recommended_customer` FOREIGN KEY (`recommended_id`) REFERENCES `customer` (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `optic`.`employee` (
    `employee_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `telephone` INT(15) NOT NULL,
    `mail` VARCHAR(45) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `optic`.`glasses` (
    `glasses_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `brand` INT NOT NULL,
    `grad_left` DECIMAL(4,2) NOT NULL,
    `grad_right` DECIMAL(4,2) NOT NULL,
    `frame` ENUM('floating', 'pasta', 'metal') NOT NULL,
    `frame_color` VARCHAR(20) NOT NULL,
    `glass_color` VARCHAR(20) NOT NULL,
    `price` DECIMAL(6,2) NOT NULL,
    CONSTRAINT `fk_brand_glasses` FOREIGN KEY (`brand`) REFERENCES `brand` (`brand_id`)
);

CREATE TABLE IF NOT EXISTS `optic`.`sales` (
    `sales_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `glasses` INT NOT NULL,
    `employee` INT NOT NULL,
    `customer` INT,
    `date` DATE NOT NULL,
    CONSTRAINT `fk_glasses_sales` FOREIGN KEY (`glasses`) REFERENCES `glasses` (`glasses_id`),
    CONSTRAINT `fk_employee_sales` FOREIGN KEY (`employee`) REFERENCES `employee` (`employee_id`),
    CONSTRAINT `fk_customer_sales` FOREIGN KEY (`customer`) REFERENCES `customer` (`customer_id`)
);

/*DADES*/

INSERT INTO `optic`.`address` (direction_id, street, number, floor, door, city, zipcode, country) VALUES
    (1, 'Carrer Arenys', 24, NULL, 4, 'Castelldefels',08860, 'Espanya'),
    (2, 'Carrer Ramon y Cajal', 34, 2, 1, 'Cornellà', 08940, 'Espanya'),
    (3, 'Plaça Perez', 5, NULL, NULL, 'Gavà', 08950, 'Espanya'),
    (4, 'Carrer quatre', 4, 4, 4, 'Barcelona', 08004, 'Espanya'),
    (5, 'Carrer cinc', 5, 5, 5, 'Barcelona', 08005, 'Espanya'),
    (6, 'Carrer sis', 6, 6, 6, 'Barcelona', 08006, 'Espanya');

INSERT INTO `optic`.`supplier` (supplier_id, name, address, telephone, fax, CIF) VALUES
    (1, 'Glasses-Oakley', 4, 93444444, 93444444, 'B-08456789'),
    (2, 'Glasses-Afflelou', 5, 9355555, NULL, 'A-08987654'),
    (3, 'Glasses-D&G', 6, 9366666, NULL, 'A-08123456');

INSERT INTO `optic`.`brand` (brand_id, name, supplier) VALUES
    (1, 'Oakley-1', 1),
    (2, 'Oakley-2', 1),
    (3, 'Oakley-3', 1),
    (4, 'Afflelou-1', 2),
    (5, 'Afflelou-2', 2),
    (6, 'D&G-1', 3),
    (7, 'D&G-2', 3);

INSERT INTO `optic`.`customer` (customer_id, name, address, telephone, email, date_register, recommended_id) VALUES
    (1, 'Jordi Olivella', 1, 696766846,'jordiolivella@hotmail.com','2020-01-01', NULL),
    (2, 'Beatriz Benito', 2, 696714684,'beabenito@hotmail.com', '2021-01-01',1),
    (3, 'Juan Perez', 3, 666777888, 'juanperez@hotmail.com', '2022-01-01', NULL),
    (4, 'Juana Gomez', 3, 666888777, 'juanagomez@hotmail.com', '2022-02-01', 3);

INSERT INTO `optic`.`employee` (employee_id, name, telephone, mail) VALUES
    (1, 'Anna Garcia', 666333111, 'annag@hotmail.com'),
    (2, 'Jaume Vista', 666555222, 'jaumevista@hotmaio.com');
    
INSERT INTO `optic`.`glasses` (glasses_id, brand, grad_left, grad_right, frame, frame_color, glass_color, price) VALUES
	(1, 1, 2.5, 2.5, 'pasta', 'white', 'transparent', 49.95),
	(2, 4, 1.25, 1.25, 'metal', 'black', 'grey', 25.00),
	(3, 6, 0.50, 0.50, 'floating', 'red', 'transparent', 80.00),
	(4, 7, 1.25, 1.25, 'pasta', 'white', 'grey', 100),
	(5, 2, 1.50, 1.50, 'metal', 'white', 'grey', 60.00),
	(6, 5, 0.25, 0.25, 'floating', 'yellow', 'transparent', 35.00),
	(7, 3, 5, 5, 'metal', 'black', 'grey', 114.99);
    
INSERT INTO `optic`.`sales` (sales_id, glasses, employee, customer, date) VALUES
    (1, 2, 1, 1, '2023-01-02'),
    (2, 1, 1, 2, '2023-01-03'),
    (3, 3, 2, 3, '2023-01-04'),
    (4, 5, 2, 1, '2023-01-05'),
    (5, 7, 1, 4, '2023-01-06'),
    (6, 6, 2, 1, '2023-01-06'),
    (7, 4, 1, 3, '2023-01-07');
