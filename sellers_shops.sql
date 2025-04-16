-- By Julian Camacho

-- create de new database
create database shops_sellers;

-- use the schemas
use shops_sellers;

-- create table shops
create table if not exists shops(
id_shop int auto_increment not null,
nm_shop varchar(30) not null, -- name shop
ad_shop varchar(50) not null, -- address shop
ph_shop varchar(20) not null, -- phone shop
em_shop varchar(100) not null, -- email shop

-- assign primary key
primary key(id_shop)
);

-- Insert data into shops table
INSERT INTO shops (id_shop, nm_shop, ad_shop, ph_shop, em_shop)
VALUES
(1, 'ElectroWorld', '123 Main St', '555-1234', 'contact@electroworld.com'),
(2, 'Book Haven', '456 Elm St', '555-5678', 'info@bookhaven.com'),
(3, 'Fashion Corner', '789 Maple Ave', '555-8765', 'support@fashioncorner.com'),
(4, 'Tech Gear', '101 Oak St', '555-4321', 'sales@techgear.com'),
(5, 'Green Grocer', '202 Pine St', '555-7890', 'contact@greengrocer.com');

-- create table sellers
create table if not exists sellers(
id_seller int auto_increment not null,
nm_seller varchar(25) not null, -- name seller
ln_seller varchar(25) not null, -- last name seller
dh_seller date not null, -- date hiring
id_shop int not null,

-- asign primary key
primary key(id_seller),

-- foreing key
constraint sellers_shops foreign key(id_shop) references shops(id_shop)
);

-- Insert data into sellers table
INSERT INTO sellers (id_seller, nm_seller, ln_seller, dh_seller, id_shop)
VALUES
(1, 'John', 'Doe', '2023-01-15', 1),
(2, 'Jane', 'Smith', '2023-02-20', 1),
(3, 'Albert', 'Johnson', '2023-03-10', 2),
(4, 'Emily', 'Davis', '2023-04-05', 2),
(5, 'Michael', 'Brown', '2023-05-15', 3),
(6, 'Sarah', 'Wilson', '2023-06-25', 3),
(7, 'David', 'Taylor', '2023-07-30', 4),
(8, 'Laura', 'Anderson', '2023-08-20', 4),
(9, 'Chris', 'Thomas', '2023-09-10', 5),
(10, 'Sophia', 'Moore', '2023-10-01', 5);

-- rules
ALTER TABLE sellers
ADD CONSTRAINT fk_shop_seller
FOREIGN KEY (id_shop)
REFERENCES shops(id_shop)
ON DELETE RESTRICT;

-- add views 

-- sellers that work in a specific shop
CREATE VIEW sellers_in_shop AS
SELECT s.id_seller, s.nm_seller, s.ln_seller, s.dh_seller, sh.nm_shop
FROM sellers s
JOIN shops sh ON s.id_shop = sh.id_shop;
-- SELECT * FROM sellers_in_shop WHERE nm_shop = 'ElectroWorld';

--  Get information about the shop a sellers is assigned to
CREATE VIEW shop_of_seller AS
SELECT s.id_seller, s.nm_seller, s.ln_seller, sh.nm_shop, sh.ad_shop, sh.ph_shop, sh.em_shop
FROM sellers s
JOIN shops sh ON s.id_shop = sh.id_shop;
-- SELECT * FROM shop_of_seller WHERE id_seller = 1;

-- list all the shops together to assigned sellers
CREATE VIEW shop_with_seller_count AS
SELECT sh.id_shop, sh.nm_shop, COUNT(s.id_seller) AS seller_count
FROM shops sh
LEFT JOIN sellers s ON sh.id_shop = s.id_shop
GROUP BY sh.id_shop, sh.nm_shop;
-- SELECT * FROM shop_with_seller_count;
