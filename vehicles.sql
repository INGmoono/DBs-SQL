-- By Julian Camacho

-- create the database
create database vehicles;

-- use the database
use vehicles;

-- create table brand
create table if not exists brand(
id_brand int auto_increment not null,
nm_brand varchar(30) not null, -- brand name
ct_brand varchar(30) not null, -- brand country

-- primary key
primary key(id_brand)
);

-- data of brand
INSERT INTO brand (id_brand, nm_brand, ct_brand) VALUES
(1, 'Toyota', 'Japan'),
(2, 'Ford', 'USA'),
(3, 'BMW', 'Germany'),
(4, 'Hyundai', 'South Korea'),
(5, 'Ferrari', 'Italy');


-- create table model
create table if not exists model(
id_model int auto_increment not null,
nm_model varchar(30) not null, -- model name
ye_model int not null, -- model year
id_brand int not null,

-- primary key
primary key(id_model),
-- foreign key
constraint model_brand foreign key(id_brand) references brand(id_brand)
);

-- data of model
INSERT INTO model (id_model, nm_model, ye_model, id_brand) VALUES
(1, 'Corolla', 2023, 1),
(2, 'F-150', 2022, 2),
(3, 'X5', 2023, 3),
(4, 'Elantra', 2023, 4),
(5, '488 Spider', 2021, 5);


-- create table version
create table if not exists version (
id_version int auto_increment not null,
nm_version varchar(30) not null, -- version name
eg_version varchar(40) not null, -- version engine
tm_version varchar(40) not null, -- version transmission
id_model int not null,

-- primary key
primary key(id_version),
-- foreign key
constraint version_model foreign key(id_model) references model(id_model)
);

-- data of version
INSERT INTO version (id_version, nm_version, eg_version, tm_version, id_model) VALUES
(1, 'LE', '1.8L I4', 'Automatic', 1),
(2, 'Lariat', '3.5L V6', 'Automatic', 2),
(3, 'xDrive40i', '3.0L I6', 'Automatic', 3),
(4, 'SE', '2.0L I4', 'Automatic', 4),
(5, 'Base', '3.9L V8', 'Automatic', 5);


-- add views
-- list all models of specific bran
CREATE VIEW v_models_by_brand AS
SELECT 
    m.id_model, 
    m.nm_model AS model_name, 
    m.ye_model AS model_year, 
    b.nm_brand AS brand_name
FROM 
    model m
INNER JOIN 
    brand b ON m.id_brand = b.id_brand;
-- SELECT * FROM v_models_by_brand WHERE brand_name = 'Toyota';

-- get all versions available for a vehicle model
CREATE VIEW v_versions_by_model AS
SELECT 
    v.id_version,
    v.nm_version AS version_name,
    v.eg_version AS engine,
    v.tm_version AS transmission,
    m.nm_model AS model_name
FROM 
    version v
INNER JOIN 
    model m ON v.id_model = m.id_model;
-- SELECT * FROM v_versions_by_model WHERE model_name = 'Corolla';

-- iii. Consult information about a specific brand, model or version.
CREATE VIEW v_info AS
SELECT 
    b.id_brand,
    b.nm_brand AS brand_name,
    b.ct_brand AS brand_country,
    m.id_model,
    m.nm_model AS model_name,
    m.ye_model AS model_year,
    v.id_version,
    v.nm_version AS version_name,
    v.eg_version AS engine,
    v.tm_version AS transmission
FROM 
    brand b
LEFT JOIN 
    model m ON b.id_brand = m.id_brand
LEFT JOIN 
    version v ON m.id_model = v.id_model;

-- SELECT * FROM v_info 
-- WHERE brand_name = 'BMW' OR model_name = 'X5' OR version_name = 'xDrive40i';


