-- By Julian Camacho

-- creacion de la db
create database alqVehiculos;
-- usamos la database
use alqVehiculos;

-- creamos la tabla marca
create table if not exists marca(
id_marca int auto_increment not null,
nom_vehiculo varchar(45) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,

-- primary key
primary key(id_marca)
)
engine = InnoDB
default char set = utf8mb4
collate = utf8mb4_spanish_ci;

-- filas de marca
INSERT INTO marca (id_marca, nom_vehiculo) VALUES
(1, 'Toyota'),
(2, 'Ford'),
(3, 'Chevrolet'),
(4, 'Honda'),
(5, 'Nissan');

-- segunda tabla estado
create table if not exists estado(
id_estado int auto_increment not null,
des_estado varchar(40) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,

-- primary key
primary key(id_estado) 
)
engine = InnoDB
default char set = utf8mb4
collate = utf8mb4_spanish_ci;

-- filas de datos en tabla estado
INSERT INTO estado (id_estado, des_estado) VALUES
(1, 'Disponible'),
(2, 'No Disponible'),
(3, 'Disponible'),
(4, 'Disponible'),
(5, 'No Disponible');

-- creacion de tabla tipo
create table if not exists tipo(
id_tipo int auto_increment not null,
desCor_tipo varchar(25) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
desAmp_tipo varchar(65) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
preAlq_tipo decimal(10,2) not null,

-- primary key
primary key(id_tipo)	
)
engine = InnoDB
default char set = utf8mb4
collate = utf8mb4_spanish_ci;

-- Agregar filas a la tabla tipo
INSERT INTO tipo (id_tipo, desCor_tipo, desAmp_tipo, preAlq_tipo) VALUES
(1, 'Sedán', 'Vehículo compacto y cómodo', 50.00),
(2, 'SUV', 'Vehículo utilitario deportivo', 75.00),
(3, 'Pickup', 'Camioneta de carga mediana', 85.00),
(4, 'Deportivo', 'Vehículo de alto rendimiento', 120.00),
(5, 'Convertible', 'Vehículo descapotable', 100.00);

-- creamos la tabla vehiculo
create table if not exists vehiculo(
id_vehiculo int auto_increment not null,
pla_vehiculo varchar(10) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
id_marca int not null,
id_tipo int not null,
id_estado int not null,

-- primary key
primary key(id_vehiculo),

-- foreign key
constraint vehiculo_marca foreign key(id_marca) references marca(id_marca),
constraint vehiculo_tipo foreign key(id_tipo) references tipo(id_tipo),
constraint vehiculo_estado foreign key(id_estado) references estado(id_estado)
)
engine = InnoDB
default char set = utf8mb4
collate = utf8mb4_spanish_ci;

-- filas a tabla vehiculo
INSERT INTO vehiculo (id_vehiculo, pla_vehiculo, id_marca, id_tipo, id_estado) VALUES
(1, 'ABC123', 1, 2, 1), -- Toyota SUV 
(2, 'DEF456', 2, 3, 3), -- Ford Pickup 
(3, 'GHI789', 3, 4, 5), -- Chevrolet Deportivo 
(4, 'JKL321', 4, 5, 2), -- Honda Convertible 
(5, 'MNO654', 5, 1, 4); -- Nissan Sedán 

-- creacion de la tabla cliente
create table if not exists cliente(
id_cliente int auto_increment not null,
doc_cliente varchar(12) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
nom_cliente varchar(25) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
ape_cliente varchar(25) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
email_cliente varchar(65) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
tel_cliente varchar(15) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,

-- primary key
primary key(id_cliente)
)
engine = InnoDB
default char set = utf8mb4
collate = utf8mb4_spanish_ci;

-- filas en tabla cliente
INSERT INTO cliente (id_cliente, doc_cliente, nom_cliente, ape_cliente, email_cliente, tel_cliente) VALUES
(1, '123456789012', 'Juan', 'Pérez', 'juan.perez@example.com', '3001234567'),
(2, '987654321098', 'Ana', 'Gómez', 'ana.gomez@example.com', '3109876543'),
(3, '456789123456', 'Luis', 'Martínez', 'luis.martinez@example.com', '3204567890'),
(4, '789123456789', 'María', 'Rodríguez', 'maria.rodriguez@example.com', '3507891234'),
(5, '321654987321', 'Carlos', 'Fernández', 'carlos.fernandez@example.com', '3153216548');

-- creacion de tabla empleado
create table if not exists empleado(
id_empleado int auto_increment not null,
nom_empleado varchar(65) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
email_empleado varchar(65) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
tel_empleado varchar(15) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
cargo_empleado varchar(40) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
sala_empleado int not null,

-- primary key
primary key(id_empleado)
)
engine = InnoDB
default char set = utf8mb4
collate = utf8mb4_spanish_ci;

-- filas en tabla empleado
INSERT INTO empleado (id_empleado, nom_empleado, email_empleado, tel_empleado, cargo_empleado, sala_empleado) VALUES
(1, 'Sofía López', 'sofia.lopez@example.com', '3101234567', 'Gerente General', 8000),
(2, 'Diego Torres', 'diego.torres@example.com', '3209876543', 'Asesor Comercial', 4000),
(3, 'Laura Pérez', 'laura.perez@example.com', '3004567890', 'Jefe de Taller', 5000),
(4, 'Andrés Ramírez', 'andres.ramirez@example.com', '3507891234', 'Recepcionista', 2500),
(5, 'Camila Vargas', 'camila.vargas@example.com', '3153216548', 'Contadora', 7000);

-- creacion de tabla alquiler
create table if not exists alquiler(
id_alquiler int auto_increment not null,
id_vehiculo int not null,
id_cliente int not null,
id_empleado int not null,
fech_inicio date not null,
fech_fin date not null,
precio_alquiler decimal(10,2) not null,

-- primary key
primary key(id_alquiler),

-- foreign key
constraint alquiler_vehiculo foreign key(id_vehiculo) references vehiculo(id_vehiculo),
constraint alquiler_cliente foreign key(id_cliente) references cliente(id_cliente),
constraint alquiler_empleado foreign key(id_empleado) references empleado(id_empleado)
)
engine = InnoDB
default char set = utf8mb4
collate = utf8mb4_spanish_ci;

-- filas de la tabla alquiler
INSERT INTO alquiler (id_alquiler, id_vehiculo, id_cliente, id_empleado, fech_inicio, fech_fin, precio_alquiler) VALUES
(1, 1, 1, 1, '2024-12-01', '2024-12-05', 250.00), -- Toyota SUV alquilado por Juan
(2, 2, 2, 2, '2024-12-02', '2024-12-06', 340.00), -- Ford Pickup alquilado por Ana
(3, 3, 3, 3, '2024-12-03', '2024-12-07', 480.00), -- Chevrolet Deportivo alquilado por Luis
(4, 4, 4, 4, '2024-12-04', '2024-12-08', 400.00), -- Honda Convertible alquilado por María
(5, 5, 5, 5, '2024-12-05', '2024-12-09', 200.00); -- Nissan Sedán alquilado por Carlos


-- creacion de tabla metodos
create table if not exists metodo(
id_metodo int auto_increment not null,
tipo_metodo varchar(20) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,
des_metodo varchar(100) character set 'utf8mb4' collate 'utf8mb4_spanish_ci'  not null,

-- primary key
primary key(id_metodo)
)
engine = InnoDB
default char set = utf8mb4
collate = utf8mb4_spanish_ci;

-- filas de la tabla metodo
INSERT INTO metodo (id_metodo, tipo_metodo, des_metodo) VALUES
(1, 'Efectivo', 'Pago realizado en efectivo en moneda local'),
(2, 'Tarjeta Débito', 'Pago realizado con tarjeta de débito bancaria'),
(3, 'Tarjeta Crédito', 'Pago realizado con tarjeta de crédito bancaria'),
(4, 'Transferencia', 'Pago realizado mediante transferencia bancaria'),
(5, 'Pago Móvil', 'Pago realizado utilizando una aplicación móvil de pagos');

-- creacion de la tabla pago
create table if not exists pago(
id_pago int auto_increment not null,
id_alquiler int not null,
id_metodo int not null,
fech_pago date not null,
monto_pago decimal(10,2) not null,

-- primary key
primary key(id_pago),

-- foreign key
constraint pago_alquiler foreign key(id_alquiler) references alquiler(id_alquiler),
constraint pago_metodo foreign key(id_metodo) references metodo(id_metodo)
)
engine = InnoDB
default char set = utf8mb4
collate = utf8mb4_spanish_ci;

-- filas de la tabla pago
INSERT INTO pago (id_pago, id_alquiler, id_metodo, fech_pago, monto_pago) VALUES
(1, 1, 1, '2024-12-01', 250.00), -- Pago en efectivo por el alquiler 1
(2, 2, 2, '2024-12-02', 340.00), -- Pago con tarjeta débito por el alquiler 2
(3, 3, 3, '2024-12-03', 480.00), -- Pago con tarjeta crédito por el alquiler 3
(4, 4, 4, '2024-12-04', 400.00), -- Pago por transferencia bancaria por el alquiler 4
(5, 5, 5, '2024-12-05', 200.00); -- Pago móvil por el alquiler 5


-- consultas esperadas
-- i. vehiculos disponibles
CREATE VIEW vehiculos_disponibles AS
SELECT 
    v.id_vehiculo,
    v.pla_vehiculo,
    m.nom_vehiculo AS marca,
    t.desCor_tipo AS tipo,
    t.preAlq_tipo AS tarifa
FROM vehiculo v
JOIN marca m ON v.id_marca = m.id_marca
JOIN tipo t ON v.id_tipo = t.id_tipo
JOIN estado e ON v.id_estado = e.id_estado
WHERE e.des_estado = 'Disponible';

select * from vehiculos_disponibles;

-- ii. historial de alquileres de un cliente
CREATE VIEW historial_alquiler_cliente AS
SELECT 
    a.id_alquiler,
    c.nom_cliente,
    c.ape_cliente,
    v.pla_vehiculo,
    m.nom_vehiculo AS marca,
    t.desCor_tipo AS tipo,
    a.fech_inicio,
    a.fech_fin,
    a.precio_alquiler
FROM alquiler a
JOIN cliente c ON a.id_cliente = c.id_cliente
JOIN vehiculo v ON a.id_vehiculo = v.id_vehiculo
JOIN marca m ON v.id_marca = m.id_marca
JOIN tipo t ON v.id_tipo = t.id_tipo;

select * from historial_alquileres_cliente where id_cliente = 1;

-- iii. listar tipos de vihiculos y sus tarifas
CREATE VIEW tipos_vehiculos_tarifas AS
SELECT 
    t.id_tipo,
    t.desCor_tipo AS tipo,
    t.desAmp_tipo AS descripcion,
    t.preAlq_tipo AS tarifa
FROM tipo t;

select * from tipos_vehiculos_tarifas;

-- iv. detalles especificos del vehiculo
CREATE VIEW detalle_vehiculo AS
SELECT 
    v.id_vehiculo,
    v.pla_vehiculo,
    m.nom_vehiculo AS marca,
    t.desCor_tipo AS tipo,
    e.des_estado AS estado
FROM vehiculo v
JOIN marca m ON v.id_marca = m.id_marca
JOIN tipo t ON v.id_tipo = t.id_tipo
JOIN estado e ON v.id_estado = e.id_estado;

select * from detalle_vehiculo where id_vehiculo = 1;


-- v. clientes con vehiculo alquilado
CREATE VIEW clientes_con_alquileres AS
SELECT DISTINCT 
    c.id_cliente,
    c.nom_cliente,
    c.ape_cliente,
    c.email_cliente,
    c.tel_cliente
FROM alquiler a
JOIN cliente c ON a.id_cliente = c.id_cliente
WHERE CURDATE() BETWEEN a.fech_inicio AND a.fech_fin;

select * from clientes_con_alquileres;

-- vi. ingreso alquileres en un perido especifico
CREATE VIEW ingresos_por_periodo AS
SELECT 
    SUM(a.precio_alquiler) AS total_ingresos,
    MIN(a.fech_inicio) AS inicio_periodo,
    MAX(a.fech_fin) AS fin_periodo
FROM alquiler a
WHERE a.fech_inicio >= '2024-01-01' AND a.fech_fin <= '2024-12-31';

select * from ingresos_por_periodo where inicio_periodo = '2024-12-01' and fin_periodo = '2024-12-20';

-- vii. obtener el numero de alquileres por cada tipo
CREATE VIEW alquileres_por_tipo AS
SELECT 
    t.desCor_tipo AS tipo,
    COUNT(a.id_alquiler) AS num_alquileres
FROM alquiler a
JOIN vehiculo v ON a.id_vehiculo = v.id_vehiculo
JOIN tipo t ON v.id_tipo = t.id_tipo
GROUP BY t.desCor_tipo;

select * from alquileres_por_tipo;

-- viii. Marcas de vehículos y cantidad por marca
CREATE VIEW cantidad_por_marca AS
SELECT 
    m.nom_vehiculo AS marca,
    COUNT(v.id_vehiculo) AS cantidad
FROM vehiculo v
JOIN marca m ON v.id_marca = m.id_marca
GROUP BY m.nom_vehiculo;

select * from cantidad_por_marca;

-- ix. Alquileres gestionados por un empleado específico
CREATE VIEW alquileres_por_empleado AS
SELECT 
    e.id_empleado,
    e.nom_empleado,
    a.id_alquiler,
    c.nom_cliente,
    c.ape_cliente,
    v.pla_vehiculo,
    a.fech_inicio, 
    a.fech_fin
FROM alquiler a
JOIN empleado e ON a.id_empleado = e.id_empleado
JOIN cliente c ON a.id_cliente = c.id_cliente
JOIN vehiculo v ON a.id_vehiculo = v.id_vehiculo;

select * from alquileres_por_empleado where id_empleado = 1;

-- x. Total de pagos realizados por un cliente en un período
CREATE VIEW pagos_por_cliente_periodo AS
SELECT 
    a.id_cliente,
    c.nom_cliente,
    c.ape_cliente,
    SUM(p.monto_pago) AS total_pagado,
    MIN(p.fech_pago) AS inicio_periodo,
    MAX(p.fech_pago) AS fin_periodo
FROM pago p
JOIN alquiler a ON p.id_alquiler = a.id_alquiler
JOIN cliente c ON a.id_cliente = c.id_cliente
WHERE p.fech_pago BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY a.id_cliente, c.nom_cliente, c.ape_cliente;

select * from pagos_por_cliente_periodo where id_cliente = 1;

-- xi. Métodos de pago más utilizados en un período
CREATE VIEW metodos_pago_frecuentes AS
SELECT 
    m.tipo_metodo,
    COUNT(p.id_pago) AS cantidad_usos
FROM pago p
JOIN metodo m ON p.id_metodo = m.id_metodo
WHERE p.fech_pago BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY m.tipo_metodo
ORDER BY cantidad_usos DESC;

select * from metodos_pago_mas_utilizados where inicio_periodo = '2024-12-01' and fin_periodo = '2024-12-31';







