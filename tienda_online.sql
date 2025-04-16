-- By Julian Camacho

-- create the new database
create database tienda_online;

-- use the new database
use tienda_online;

-- create table categories
create table if not exists categories(
id_category int not null,
nm_category varchar(40) not null,
dc_category varchar(100) not null, -- description category

primary key(id_category)
);

-- categories rows
insert into categories (id_category, nm_category, dc_category) values 
(1, 'Electronics', 'Devices and gadgets'),
(2, 'Books', 'Printed and digital books'),
(3, 'Clothing', 'Apparel and accessories');


-- create table products
create table if not exists products(
id_product int auto_increment not null,
nm_product varchar(45) not null,  -- name product
dc_product varchar(100) not null,  -- description product
pr_product int not null,  -- price product
st_product int not null,  -- product stock
id_category int not null, 

primary key(id_product),
constraint products_category_fk foreign key(id_category) references categories(id_category)
);

-- modify to complete the rules
ALTER TABLE products
MODIFY COLUMN pr_product int NOT NULL CHECK (pr_product > 0);

ALTER TABLE products
MODIFY COLUMN st_product int NOT NULL CHECK (st_product >= 0);

-- products rows
insert into products (id_product, nm_product, dc_product, pr_product, st_product, id_category) values 
(1, 'Smartphone', 'High-end smartphone', 700, 50, 1),
(2, 'Laptop', 'Gaming laptop', 1200, 30, 1),
(3, 'E-book Reader', 'Digital e-book reader', 150, 100, 2),
(4, 'Novel', 'Best-selling novel', 20, 200, 2),
(5, 'T-shirt', 'Cotton T-shirt', 15, 150, 3),
(6, 'Jeans', 'Denim jeans', 40, 80, 3);

-- add views

-- list all products in a specific category
select p.id_product, p.nm_product, p.dc_product, p.pr_product, p.st_product
from products p
join categories c on p.id_category = c.id_category
where c.nm_category = 'Electronics';  -- Replace 'Namecategory' for the specific category.

-- get details of a specif product
select id_product, nm_product, pr_product, st_product
from products
where nm_product = 'Novel';  -- Replace 'Nameproduct' for the specif name product.

-- categories that not have associated products
select c.id_category, c.nm_category, c.dc_category
from categories c
left join products p on c.id_category = p.id_category
where p.id_product is null;

