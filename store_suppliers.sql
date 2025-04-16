-- By Julian Camacho

-- create database store
create database store;

-- use db store
use store;

-- create table supplier
create table if not exists supplier(
id_supplier int auto_increment not null, 
nm_supplier varchar(30) not null, -- supplier address
ad_supplier varchar(50) not null, -- supplier address
ph_supplier varchar(25) not null, -- supplier phone
em_supplier varchar(50) not null, -- supplier email
nc_supplier varchar(40) not null, -- supplier name contact

-- primary key
primary key(id_supplier)
); 

-- rows supplier
insert into supplier (id_supplier, nm_supplier, ad_supplier, ph_supplier, em_supplier, nc_supplier)
values 
(1, 'Proveedor A', 'Calle Principal 123', '555-1234', 'contacto@proveedora.com', 'Juan Pérez'),
(2, 'Proveedor B', 'Avenida Secundaria 456', '555-5678', 'ventas@proveedorb.com', 'Ana Gómez'),
(3, 'Proveedor C', 'Boulevard Central 789', '555-9012', 'info@proveedorc.com', 'Carlos López');


-- create table product
create table if not exists product(
id_product int auto_increment not null,
nm_product varchar(30) not null, -- product name
dc_product varchar(70) not null, -- product description
pc_porduct int not null, -- price product
st_product int not null, -- product stock
cd_product varchar(70) not null, -- product category description
id_supplier int not null,

-- primary key
primary key(id_product),

-- create the foreign key
constraint product_supplier foreign key(id_supplier) references supplier(id_supplier)
);

-- rows product
insert into product (id_product, nm_product, dc_product, pc_porduct, st_product, cd_product, id_supplier)
values
(1, 'Laptop', 'Laptop de alto rendimiento', 1200, 15, 'Tecnología', 1),
(2, 'Impresora', 'Impresora multifuncional', 300, 20, 'Oficina', 1),
(3, 'Teclado', 'Teclado mecánico RGB', 100, 50, 'Periféricos', 2),
(4, 'Monitor', 'Monitor 4K UHD', 400, 10, 'Tecnología', 2),
(5, 'Ratón', 'Ratón inalámbrico', 50, 60, 'Periféricos', 3);


-- create table category
create table if not exists category(
id_category int auto_increment not null,
nm_category varchar(30) not null,
dc_category varchar(70) not null,

-- primary key
primary key(id_category)
);

-- rows category
insert into category (id_category, nm_category, dc_category)
values
(1, 'Tecnología', 'Productos tecnológicos como laptops y monitores'),
(2, 'Oficina', 'Productos de oficina como impresoras y papelería'),
(3, 'Periféricos', 'Dispositivos complementarios como teclados y ratones');


-- create table product_category
create table if not exists product_category(
id_product int not null,
id_category int not null,

-- primary key (composite key)
primary key (id_product, id_category),

-- foreign keys
constraint fk_product foreign key (id_product) references product(id_product),
constraint fk_category foreign key (id_category) references category(id_category)
);

-- rows product_category
insert into product_category (id_product, id_category)
values
(1, 1), -- Laptop en Tecnología
(2, 2), -- Impresora en Oficina
(3, 3), -- Teclado en Periféricos
(4, 1), -- Monitor en Tecnología
(5, 3), -- Ratón en Periféricos
(1, 3); -- Laptop también en Periféricos


-- views
-- List all products from a specific supplier
create view view_products_by_supplier as
select 
    p.id_product,
    p.nm_product,
    p.dc_product,
    p.pc_porduct,
    p.st_product,
    s.nm_supplier
from product p
join supplier s on p.id_supplier = s.id_supplier;
-- select * from view_products_by_supplier where nm_supplier = 'nombre_del_proveedor';

-- Consult the categories in which a product is classified
create view view_categories_by_product as
select 
    p.id_product,
    p.nm_product,
    c.id_category,
    c.nm_category,
    c.dc_category
from product p
join product_category pc on p.id_product = pc.id_product
join category c on pc.id_category = c.id_category;
-- select * from view_categories_by_product where nm_product = 'nombre_del_producto';

-- View all products that belong to a specific category
create view view_products_by_category as
select 
    c.id_category,
    c.nm_category,
    p.id_product,
    p.nm_product,
    p.dc_product
from category c
join product_category pc on c.id_category = pc.id_category
join product p on pc.id_product = p.id_product;
-- select * from view_products_by_category where nm_category = 'nombre_de_la_categoria';
select * from view_products_by_category where nm_category = 'Periféricos';

-- List products that belong to multiple categories
create view view_products_in_multiple_categories as
select 
    p.id_product,
    p.nm_product,
    count(pc.id_category) as category_count
from product p
join product_category pc on p.id_product = pc.id_product
group by p.id_product, p.nm_product
having count(pc.id_category) > 1;
-- select * from view_products_in_multiple_categories;

-- Get detailed information of a supplier along with their products
create view view_supplier_with_products as
select 
    s.id_supplier,
    s.nm_supplier,
    s.ad_supplier,
    s.ph_supplier,
    s.em_supplier,
    s.nc_supplier,
    p.id_product,
    p.nm_product,
    p.dc_product,
    p.pc_porduct,
    p.st_product
from supplier s
join product p on s.id_supplier = p.id_supplier;
-- select * from view_supplier_with_products where nm_supplier = 'nombre_del_proveedor';

-- rules
DELIMITER $$

CREATE TRIGGER ensure_product_in_category
AFTER INSERT ON product
FOR EACH ROW
BEGIN
    DECLARE category_exists INT DEFAULT 0;

    -- Contar si el producto tiene al menos una categoría en la tabla product_category
    SELECT COUNT(*)
    INTO category_exists
    FROM product_category
    WHERE id_product = NEW.id_product;

    -- Si no tiene categorías, arrojar un error
    IF category_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Un producto debe estar vinculado al menos a una categoría.';
    END IF;
END$$

DELIMITER ;


