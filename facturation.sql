	-- By Julian Camacho
	
	-- create database
	create database facturacion;

	-- use the new database
	use facturacion;

	-- create table cashier
	create table if not exists cashier(
	id_cashier int auto_increment not null,
	nm_cashier varchar(20) not null, -- cashier name
	ln_cashier varchar(20) not null, -- cashier last name
	tn_cashier varchar(10) not null, -- cashier turn

	-- primary key
	primary key(id_cashier)
	);

	-- rows cashier
	INSERT INTO cashier (id_cashier, nm_cashier, ln_cashier, tn_cashier)
	VALUES 
	(1, 'Juan', 'Pérez', 'Mañana'),
	(2, 'María', 'Gómez', 'Tarde'),
	(3, 'Luis', 'Hernández', 'Noche');


	-- crete the table seller
	create table if not exists seller(
	id_seller int auto_increment not null,
	nm_seller varchar(20) not null, -- seller name
	ln_seller varchar(20) not null, -- seller last name
	tn_seller varchar(10) not null,

	-- primary key
	primary key(id_seller)
	); 

	-- rows seller
	INSERT INTO seller (id_seller, nm_seller, ln_seller, tn_seller)
	VALUES 
	(1, 'Laura', 'López', 'Mañana'),
	(2, 'Pedro', 'Martínez', 'Tarde'),
	(3, 'Sofía', 'Jiménez', 'Noche');


	-- create the table customer
	create table if not exists customer(
	id_customer int auto_increment not null,
	nm_customer varchar(20) not null, -- customer name
	ln_customer varchar(20) not null, -- customer last name
	ad_customer varchar(50) not null, -- customer address
	em_customer varchar(50) not null, -- customer email
	ph_customer varchar(14) not null, -- customer phone

	-- primary key
	primary key(id_customer)
	);

	-- rows customer
	INSERT INTO customer (id_customer, nm_customer, ln_customer, ad_customer, em_customer, ph_customer)
	VALUES 
	(1, 'Carlos', 'Ramírez', 'Av. Principal 123', 'carlos@example.com', '555-123-456'),
	(2, 'Ana', 'Fernández', 'Calle 456', 'ana@example.com', '555-987-654'),
	(3, 'Luis', 'García', 'Plaza Norte 789', 'luis@example.com', '555-654-321');

	-- create table product
	create table if not exists product(
	id_product int auto_increment not null,
	nm_product varchar(20) not null, -- product name
	dc_product varchar(80) not null, -- product description
	pc_product int not null, -- product price
	st_product int not null, -- product stock

	-- primary key
	primary key(id_product)
	);

	-- rows product
	INSERT INTO product (id_product, nm_product, dc_product, pc_product, st_product)
	VALUES 
	(1, 'Laptop', 'Laptop marca A de alta gama', 1500, 10),
	(2, 'Teléfono', 'Teléfono inteligente modelo X', 800, 20),
	(3, 'Monitor', 'Monitor 4K para escritorio', 300, 15);


	-- create table invoice
	create table if not exists invoice(
	id_invoice int  auto_increment not null,
	id_cashier int not null,
	id_customer int not null,
	dt_invoice datetime not null, -- invoice date
	to_invoice int not null, -- invoice total

	-- primary key
	primary key(id_invoice),

	-- foreign keys
	constraint invoice_cashier foreign key(id_cashier) references cashier(id_cashier),
	constraint invoice_customer foreign key(id_customer) references customer(id_customer) 
	);

	-- rows invoice
	INSERT INTO invoice (id_invoice, id_cashier, id_customer, id_seller, dt_invoice, to_invoice)
	VALUES 
	(1, 1, 1, 1, '2024-11-24 10:00:00', 2300),
	(2, 2, 2, 2, '2024-11-24 14:00:00', 800),
	(3, 3, 3, 3, '2024-11-24 18:00:00', 1500);


	-- create table invoice datail
	create table if not exists invoice_detail(
	id_product int not null,
	id_invoice int not null,
	qu_purchased int not null,-- quantity purchased
	un_price int not null, -- unit price
	su_total int not null, -- subtotal

	-- primary key
	primary key(id_invoice),	

	-- foreign keys
	constraint invoicedetail_product foreign key(id_product) references product(id_product),
	constraint invoicedetail_invoice foreign key(id_invoice) references invoice(id_invoice)
	);

	-- rows invoice datail
	INSERT INTO invoice_detail (id_invoice, id_product, qu_purchased, un_price, su_total)
	VALUES 
	(1, 1, 1, 1500, 1500), -- invoice 1: Laptop
	(1, 2, 1, 800, 800),  -- invoice 1: Teléfono
	(2, 2, 1, 800, 800),  -- invoice 2: Teléfono
	(3, 1, 1, 1500, 1500); -- invoice 3: Laptop


-- relations
ALTER TABLE invoice_detail
DROP FOREIGN KEY invoicedetail_product,
DROP FOREIGN KEY invoicedetail_invoice;

ALTER TABLE invoice_detail
DROP PRIMARY KEY;

ALTER TABLE invoice_detail
ADD PRIMARY KEY (id_invoice, id_product);

ALTER TABLE invoice_detail
ADD CONSTRAINT invoicedetail_product FOREIGN KEY (id_product) REFERENCES product (id_product),
ADD CONSTRAINT invoicedetail_invoice FOREIGN KEY (id_invoice) REFERENCES invoice (id_invoice);

-- Paso 1: Eliminar la clave foránea existente (si aplica)
ALTER TABLE invoice
DROP FOREIGN KEY invoice_seller;

-- Paso 2: Eliminar la columna id_seller
ALTER TABLE invoice
DROP COLUMN id_seller;

-- Paso 3: Volver a agregar la columna id_seller
ALTER TABLE invoice
ADD COLUMN id_seller INT NOT NULL AFTER id_customer;

-- Paso 4: Crear la clave foránea para id_seller
ALTER TABLE invoice
ADD CONSTRAINT invoice_seller FOREIGN KEY (id_seller) REFERENCES seller (id_seller);

-- views
-- View all invoices issued by a cashier on a specific day.
CREATE VIEW FacturasPorCajeroYFecha AS
SELECT 
    c.nm_cashier AS NombreCajero,
    c.ln_cashier AS ApellidoCajero,
    i.id_invoice AS IdFactura,
    i.dt_invoice AS FechaFactura,
    i.to_invoice AS TotalFactura
FROM 
    invoice i
JOIN 
    cashier c ON i.id_cashier = c.id_cashier;

/* SELECT * 
FROM FacturasPorCajeroYFecha 
WHERE NombreCajero = 'Juan' AND ApellidoCajero = 'Pérez' AND DATE(FechaFactura) = '2024-11-24'; */

-- View products sold on a specific invoice.
CREATE VIEW ProductosPorFactura AS
SELECT 
    i.id_invoice AS IdFactura,
    p.nm_product AS NombreProducto,
    p.dc_product AS DescripcionProducto,
    d.qu_purchased AS Cantidad,
    d.un_price AS PrecioUnitario,
    d.su_total AS Subtotal
FROM 
    invoice_detail d
JOIN 
    product p ON d.id_product = p.id_product
JOIN 
    invoice i ON d.id_invoice = i.id_invoice;

/* SELECT * 
FROM ProductosPorFactura 
WHERE IdFactura = 1; */

-- Obtain the total sales made by a seller during a period of time.
CREATE VIEW VentasPorVendedoraYPeriodo AS
SELECT 
    s.nm_seller AS NombreVendedora,
    s.ln_seller AS ApellidoVendedora,
    SUM(i.to_invoice) AS TotalVentas,
    MIN(i.dt_invoice) AS InicioPeriodo,
    MAX(i.dt_invoice) AS FinPeriodo
FROM 
    invoice i
JOIN 
    seller s ON i.id_seller = s.id_seller
GROUP BY 
    s.id_seller;

/* SELECT * 
FROM VentasPorVendedoraYPeriodo 
WHERE NombreVendedora = 'Laura' AND ApellidoVendedora = 'López'; */

-- Consult a customer's purchase history.
CREATE VIEW HistorialComprasCliente AS
SELECT 
    c.nm_customer AS NombreCliente,
    c.ln_customer AS ApellidoCliente,
    i.id_invoice AS IdFactura,
    i.dt_invoice AS FechaFactura,
    i.to_invoice AS TotalFactura
FROM 
    invoice i
JOIN 
    customer c ON i.id_customer = c.id_customer;
    
/* SELECT * 
FROM HistorialComprasCliente 
WHERE NombreCliente = 'Carlos' AND ApellidoCliente = 'Ramírez'; */

-- Check product stock before making a sale.
CREATE VIEW StockProductos AS
SELECT 
    p.id_product AS IdProducto,
    p.nm_product AS NombreProducto,
    p.st_product AS StockDisponible
FROM 
    product p;
    
/* SELECT * 
FROM StockProductos
WHERE IdProducto = 1; */

-- rules
-- iii

DELIMITER $$

CREATE TRIGGER update_invoice_total
AFTER INSERT ON invoice_detail
FOR EACH ROW
BEGIN
    DECLARE total INT DEFAULT 0;
    -- Calcula el total de la factura
    SELECT COALESCE(SUM(su_total), 0) INTO total
    FROM invoice_detail
    WHERE id_invoice = NEW.id_invoice;

    -- Actualiza el total de la factura
    UPDATE invoice
    SET to_invoice = total
    WHERE id_invoice = NEW.id_invoice;
END$$

DELIMITER ;

-- v
DELIMITER $$

CREATE TRIGGER update_product_stock
AFTER INSERT ON invoice_detail
FOR EACH ROW
BEGIN
    UPDATE product
    SET st_product = st_product - NEW.qu_purchased
    WHERE id_product = NEW.id_product;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER check_stock_before_sale
BEFORE INSERT ON invoice_detail
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;
    SELECT st_product INTO current_stock
    FROM product
    WHERE id_product = NEW.id_product;

    IF current_stock < NEW.qu_purchased THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para realizar la venta';
    END IF;
END$$

DELIMITER ;


