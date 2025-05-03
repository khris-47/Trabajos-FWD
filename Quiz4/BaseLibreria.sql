create database Libreria;
use Libreria;

-- ===================================================================================================================================================================
-- crear tablas independientes
-- ===================================================================================================================================================================

create table Autores(
    idAutor int primary key auto_increment,
    nombre varchar(30) not null,
    primerApellido varchar(30) not null,
    segundoApellido varchar(30) not null,
    numContacto varchar(20) not null,
    correo varchar(100) not null unique
);

create table Categorias(
    idCategoria int primary key auto_increment,
    nombre varchar(50) not null,
    descripcion varchar(100) not null
);

create table Editoriales(
    idEditorial int primary key auto_increment,
    nombre varchar(100) not null,
    pais varchar(50),
    correo varchar(100) unique
);

create table EstadoLibro(
    idEstado int primary key auto_increment,
    descripcion varchar(50) not null
);

create table Direcciones(
    idDireccion int primary key auto_increment,
    provincia varchar(50),
    canton varchar(50),
    distrito varchar(50),
    direccionExacta text
);

create table Clientes(
    idCliente int primary key auto_increment,
    cedula int not null,
    nombre varchar(30) not null,
    primerApellido varchar(30) not null,
    segunApellido varchar(30) not null,
    telefono varchar(20) not null,
    correo varchar(100) not null unique,
    idDireccion int, -- La direccion sera opcional
    foreign key (idDireccion) references Direcciones (idDireccion)
);

create table Empleados(
    idEmpleado int primary key auto_increment,
    nombre varchar(50) not null,
    correo varchar(100) not null unique,
    rol varchar(30) not null
);

-- ===================================================================================================================================================================
-- crear tablas dependientes
-- ===================================================================================================================================================================

create table Libros(
    idLibro int primary key auto_increment,
    nombre varchar(100) not null,
    precio decimal(10,2) not null,
    cantidad int not null,
    idCategoria int not null,
    idAutor int not null,
    idEditorial int,
    idEstado int,
    foreign key (idCategoria) references Categorias (idCategoria),
    foreign key (idAutor) references Autores (idAutor),
    foreign key (idEditorial) references Editoriales (idEditorial),
    foreign key (idEstado) references EstadoLibro (idEstado)
);

create table Ventas(
    idVenta int primary key auto_increment,
    idCliente int not null,
    idEmpleado int not null,
    descuento decimal(10,2) not null,
    impuesto decimal(10,2) not null,
    precioTotal decimal(10,2) not null,
    fechaVenta date default (current_date),
    foreign key (idCliente) references Clientes (idCliente),
    foreign key (idEmpleado) references Empleados (idEmpleado)
);

create table Detalle_Venta(
    idDetalle int primary key auto_increment,
    idVenta int not null,
    idLibro int not null,
    cantidad int not null,
    precioLibro decimal(10,2) not null,
    foreign key (idVenta) references Ventas (idVenta),
    foreign key (idLibro) references Libros (idLibro)
);


-- ===================================================================================================================================================================
-- Insert's de las tablas
-- ===================================================================================================================================================================
insert into Editoriales (nombre, pais, correo) values 
	('Alfa', 'Costa Rica', 'info@hotmail.com'),('Beta', 'Portugal', 'beta@gmail.com'),
	('Planeta', 'Mexico', 'planeta@hotmail.com'),('Penelope', 'USA', 'penlp@gmail.com'),
	('Santillana', 'Colombia', 'santi@gmail.com');

insert into Categorias (nombre, descripcion) values 
	('Novela', 'Narrativa de ficcion'),('Tecnologia', 'Informatica y sistemas'),
	('Ciencia', 'Investigacion y ciencias'),('Historia', 'Libros historicos'),
	('Infantil', 'Libros para ninos');

insert into EstadoLibro (descripcion) values 
	('Disponible'),('Agotado');

insert into Direcciones (provincia, canton, distrito, direccionExacta) values 
	('San Jose', 'Central', 'Carmen', 'Calle 5, Avenida Central'),('Alajuela', 'Alajuela', 'San Jose', '200 metros norte del parque'),
	('Cartago', 'Oreamuno', 'San Rafael', 'Frente a la iglesia'),('Heredia', 'Santo Domingo', 'Calle 3', 'Del super 100 norte'),
	('Puntarenas', 'Central', 'Barranca', 'Contiguo a la escuela');

insert into Autores (nombre, primerApellido, segundoApellido, numContacto, correo) values 
	('Carlos', 'Gomez', 'Lopez', '8888-0000', 'carlos.gomez@gmail.com'),
	('Ana', 'Fernandez', 'Vargas', '9999-1234', 'ana.fernandez@gmail.com'),('Luis', 'Martinez', 'Ramirez', '7777-2222', 'luis.martinez@gmail.com'),
	('Marcela', 'Castro', 'Vega', '6666-3333', 'marcela.castro@hotmail.com'),('José', 'Rodriguez', 'Solano', '5555-4444', 'jose.rodriguez@hotmail.com');

insert into Clientes (cedula, nombre, primerApellido, segunApellido, telefono, correo, idDireccion) values 
	(101010101, 'Luis', 'Ramirez', 'Salas', '8888-1111', 'luis.ramirez@gmail.com', 1),(202020202, 'Maria', 'Perez', 'Alfaro', '8888-2222', 'maria.perez@gmail.com', 2),
	(303030303, 'Andres', 'Soto', 'Jimenez', '8888-3333', 'andres.soto@gmail.com', 3),(404040404, 'Lucia', 'Vega', 'Guzman', '8888-4444', 'lucia.vega@gmail.com', 4),
	(505050505, 'Jorge', 'Mora', 'Campos', '8888-5555', 'jorge.mora@gmail.com', 5);

insert into Empleados (nombre, correo, rol) values 
	('Juan Mendez', 'juan.mendez@libreria.com', 'Vendedor'),('Lucia Castro', 'lucia.castro@libreria.com', 'Cajera'),
	('Roberto Ruiz', 'roberto.ruiz@libreria.com', 'Administrador');

insert into Libros (nombre, precio, cantidad, idCategoria, idAutor, idEditorial, idEstado) values 
	('Salome', 8500, 10, 1, 1, 1, 1),('Introduccion a MySQL', 12500, 5, 2, 2, 2, 1),
	('Pensamientos cientificos',1250, 4, 3, 3, 3, 1),('La revolucion frencesa', 9000, 7, 4, 3, 4, 1),
	('Python para Todos', 11000, 8, 2, 4, 4, 1),('Los tres cerditos', 6000, 12, 5, 5, 1, 1);


insert into Ventas (idCliente, idEmpleado, descuento, impuesto, precioTotal, fechaVenta) values 
	(1, 1, 500.00, 650.00, 9650.00, '2025-04-10'),(2, 2, 1000.00, 750.00, 11850.00, '2025-04-15'),
	(3, 2, 0.00, 1300.00, 14300.00, '2025-03-25'),(4, 1, 700.00, 900.00, 11900.00, '2025-04-20'),
	(5, 2, 0.00, 500.00, 11500.00, '2025-05-01');

insert into Detalle_Venta (idVenta, idLibro, cantidad, precioLibro) values
	(1, 7, 4, 8500.00), -- Venta 1: un libro

	(2, 8, 1, 12500.00),-- Venta 2: dos libros diferentes
	(2, 9, 6, 9000.00),

	(3, 10, 2, 11000.00), -- Venta 3: un solo libro

	(4, 11, 5, 8500.00),-- Venta 4: dos libros
	(4, 12, 2, 6000.00),

	(5, 10, 1, 11000.00);-- Venta 5: un libro


select * from Ventas;
select * from Detalle_Venta;

select * from Libros;
select * from Editoriales;
select * from Autores;
select * from Categorias;
select * from estadolibro;

select * from Empleados;
select * from Clientes;
select * from Direcciones