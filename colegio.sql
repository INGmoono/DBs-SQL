-- by Julian Camacho

-- create the new db
create database colegio;

-- start to use the db
use colegio;

-- table students
create table if not exists students(
id_student int auto_increment not null,
nm_student varchar(30) not null,
ln_student varchar(30) not null,  
bd_student date not null,  -- birthday
em_student varchar(45) not null,  -- email
ph_student varchar(20) not null,  -- phone

primary key(id_student)
);

-- rows table students 
INSERT INTO students (nm_student, ln_student, bd_student, em_student, ph_student)
VALUES 
('Juan', 'Pérez', '2000-01-15', 'juan.perez@example.com', '123-456-7890'),
('Ana', 'García', '1999-05-23', 'ana.garcia@example.com', '234-567-8901'),
('Luis', 'Martínez', '2001-07-08', 'luis.martinez@example.com', '345-678-9012'),
('Maria', 'Rodriguez', '2002-03-12', 'maria.rodriguez@example.com', '456-789-0123'),
('Carlos', 'Lopez', '2000-11-25', 'carlos.lopez@example.com', '567-890-1234'),
('Sofia', 'Hernandez', '1998-12-10', 'sofia.hernandez@example.com', '678-901-2345'),
('David', 'Gomez', '2001-05-20', 'david.gomez@example.com', '789-012-3456'),
('Laura', 'Diaz', '1999-10-18', 'laura.diaz@example.com', '890-123-4567'),
('Miguel', 'Sanchez', '2002-07-09', 'miguel.sanchez@example.com', '901-234-5678'),
('Carmen', 'Ramirez', '2000-02-28', 'carmen.ramirez@example.com', '123-456-7891'),
('Alejandro', 'Romero', '2001-04-15', 'alejandro.romero@example.com', '234-567-8902'),
('Elena', 'Morales', '1998-11-03', 'elena.morales@example.com', '345-678-9013'),
('Fernando', 'Ortiz', '2000-09-22', 'fernando.ortiz@example.com', '456-789-0124'),
('Valeria', 'Torres', '2001-06-17', 'valeria.torres@example.com', '567-890-1235'),
('Jose', 'Vargas', '1999-01-06', 'jose.vargas@example.com', '678-901-2346'),
('Patricia', 'Castro', '2002-08-19', 'patricia.castro@example.com', '789-012-3457'),
('Raul', 'Nunez', '2000-04-30', 'raul.nunez@example.com', '890-123-4568'),
('Carolina', 'Suarez', '1998-07-14', 'carolina.suarez@example.com', '901-234-5679'),
('Francisco', 'Rivas', '2001-03-03', 'francisco.rivas@example.com', '123-456-7892'),
('Gabriela', 'Flores', '1999-12-27', 'gabriela.flores@example.com', '234-567-8903');

-- table courses
create table if not exists courses(
id_course int auto_increment not null,
nm_course varchar(45) not null, 
dc_course varchar(100) not null,  -- description
sd_course date not null, -- start date
fd_course date not null, -- finish date
ct_course int not null,  -- credits

primary key(id_course)
);

-- rows table courses
INSERT INTO courses (nm_course, dc_course, sd_course, fd_course, ct_course)
VALUES 
('Matemáticas Básicas', 'Introducción a los conceptos fundamentales de matemáticas', '2024-01-15', '2024-06-15', 4),
('Programación en Python', 'Curso de programación básica en Python', '2024-02-01', '2024-07-01', 5),
('Bases de Datos', 'Fundamentos de bases de datos y SQL', '2024-03-10', '2024-08-10', 6),
('Manejo de APIs', 'Consumo de APIs para la Creacion de Software', '2024-04-01', '2024-10-30', 5);

-- table registration
create table if not exists registration(
id_registration int auto_increment not null,
id_student int not null,
id_course int not null,
dt_registration date not null,  -- date

primary key(id_registration),

-- foreigs keys
constraint registration_student foreign key(id_student) references students(id_student),
constraint registration_courses foreign key(id_course) references courses(id_course)
);

-- with this lines is impossible student cannot register for the same course
ALTER TABLE registration
ADD CONSTRAINT unique_student_course UNIQUE (id_student, id_course);

-- rows table registration
INSERT INTO registration (id_student, id_course, dt_registration)
VALUES 

-- Students in course 1 (Matemáticas Básicas)
(1, 1, '2024-01-08'),
(2, 1, '2024-01-08'),
(3, 1, '2024-01-08'),
(4, 1, '2024-01-08'),
(5, 1, '2024-01-08'),

-- Students in course 2 (Programación en Python)
(6, 2, '2024-01-25'),
(7, 2, '2024-01-25'),
(8, 2, '2024-01-25'),
(9, 2, '2024-01-25'),
(10, 2, '2024-01-25'),

-- Students in course 3 (Bases de Datos)
(11, 3, '2024-03-03'),
(12, 3, '2024-03-03'),
(13, 3, '2024-03-03'),
(14, 3, '2024-03-03'),
(15, 3, '2024-03-03'),

-- Students in course 4 (Manejo de APIs)
(16, 4, '2024-03-25'),
(17, 4, '2024-03-25'),
(18, 4, '2024-03-25'),
(19, 4, '2024-03-25'),
(20, 4, '2024-03-25');

-- ADD VIEWS

-- View 1: students in an specific course
CREATE VIEW view_students_in_course AS
SELECT 
    c.nm_course AS curso,
    s.nm_student AS nombre,
    s.ln_student AS apellido,
    r.dt_registration AS fecha_matricula
FROM 
    registration r
JOIN 
    students s ON r.id_student = s.id_student
JOIN 
    courses c ON r.id_course = c.id_course;

-- SELECT * FROM view_students_in_course WHERE curso = 'Name course';
 SELECT * FROM view_students_in_course 
 WHERE curso = 'Manejo de APIs';
 
-- View 2: Check how many students are enrolled in a course
CREATE VIEW view_count_students_in_course AS
SELECT 
    c.nm_course AS curso,
    COUNT(r.id_student) AS total_estudiantes
FROM 
    registration r
JOIN 
    courses c ON r.id_course = c.id_course
GROUP BY 
    c.nm_course;

-- SELECT * FROM view_count_students_in_course WHERE curso = 'Nombre del curso';
SELECT * FROM view_count_students_in_course
WHERE curso = 'Manejo de APIs';

-- Vista 3: See which courses a specific student is enrolled in
CREATE VIEW view_courses_of_student AS
SELECT 
    s.nm_student AS nombre,
    s.ln_student AS apellido,
    c.nm_course AS curso,
    r.dt_registration AS fecha_matricula
FROM 
    registration r
JOIN 
    students s ON r.id_student = s.id_student
JOIN 
    courses c ON r.id_course = c.id_course;

-- SELECT * FROM view_courses_of_student WHERE nombre = 'Nombre del estudiante' AND apellido = 'Apellido del estudiante';
SELECT * FROM view_courses_of_student
WHERE nombre = 'Juan' AND apellido = 'Perez'; 
