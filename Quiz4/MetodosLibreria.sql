use Libreria;
-- ===================================================================================================================================================================
--  Consultas con Multiples tablas
-- ===================================================================================================================================================================

-- Lista de libros vendidos en el ultimo mes junto con la categoria y el autor##########################################################################################
select 
	v.idVenta, L.nombre as Libro, c.nombre as Categoria, a.nombre as Autor, v.fechaVenta
from Autores a
	join Libros l on l.idAutor  = a.idAutor
    join categorias c on c.idCategoria = l.idCategoria
    join Detalle_Venta d on d.idLibro = l.idLibro
    join Ventas v on v.idVenta = d.idVenta
where
	month(v.fechaVenta) = month(curdate() - interval 1 month) 
order by v.idVenta;

-- Clientes que han comprado más de 3 libros, con detalles de sus compras.####################################################################################
select 
	c.nombre, c.primerApellido, c.segunApellido, sum(d.cantidad) as cantidad_libros
from Clientes c
	join Ventas v on v.idCliente = c.idCliente
    join Detalle_venta d on v.idVenta =  d.idVenta
group by c.nombre, c.primerApellido, c.segunApellido
having
	sum(d.cantidad) > 3;
    
-- Autores que han publicado libros en más de una categoría.###########################################################################################################
select 
	a.nombre, a.primerApellido, a.segundoApellido, count(distinct c.idCategoria) as cantidad_categorias 
from Autores a
	join Libros l on l.idAutor = a.idAutor
    join Categorias c on c.idCategoria = l.idCategoria
    group by 
		a.nombre, a.primerApellido, a.segundoApellido
	having 
		count(c.idCategoria) > 1;
        

-- ===================================================================================================================================================================
--  Comandos para Crear, Modificar y Borrar Tablas
-- ===================================================================================================================================================================

-- Cree una nueva tabla para almacenar resenas de libros #################################################################################################################
create table Resenas (
    idResena int primary key auto_increment,
    idCliente int not null,
    idLibro int not null,
    comentario varchar(500) not null,
    calificacion int not null,
    fechaResena date default (current_date),
    foreign key (idCliente) references Clientes(idCliente),
    foreign key (idLibro) references Libros(idLibro)
);

-- Modifique la tabla de clientes para añadir un campo "fecha de registro". ################################################################################################
alter table Clientes
	add column fecha_registro date;
    
drop table Resenas;

-- ===================================================================================================================================================================
--  SQL para Crear, Consultar y Manipular Datos
-- ===================================================================================================================================================================

-- Inserte datos ficticios en las tablas de libros, autores, clientes y ventas.##############################################################
insert into Libros (nombre,precio,cantidad,idCategoria,idAutor,idEditorial,idEstado) values
	('Caperucita Roja', 2500, 10, 5, 1, 2, 2);
    
insert into Autores (nombre, primerApellido, segundoApellido, numContacto, correo) values 
	('Stefany', 'Forester', 'Argued', '1111-0000', 'forester@hotmail.com');

insert into Clientes (cedula, nombre, primerApellido, segunApellido, telefono, correo, idDireccion) values 
	(123456789, 'Karina', 'Mora', 'Morales', '1111-8888', 'KarM@gmail.com', 1);
    
insert into Ventas (idCliente, idEmpleado, descuento, impuesto, precioTotal, fechaVenta) values 
	(6, 1, 0, 0, 2500, '2024-02-22');

insert into Detalle_Venta (idVenta, idLibro, cantidad, precioLibro) values
	(6, 13, 1, 2500);
    
-- Realice actualizaciones para corregir errores en los datos insertados.#####################################################
update Clientes
	set nombre = 'Karolina'
		where idCliente = 6;
        
-- Elimine un registro específico que ya no es necesario.#####################################################################
delete from Autores
	where idAutor = 6;
    
    
-- ===================================================================================================================================================================
--  Vistas
-- ===================================================================================================================================================================

-- Cree una vista que muestre los libros más vendidos junto con el nombre del autor y la categoría.##############################################################
create view Vista_Libros_Mas_Comprados as
select
	l.nombre as Libro, a.nombre as Autor, c.nombre as Categoria, sum(d.cantidad)
from Autores a
	join Libros l on l.idAutor = a.idAutor
    join Categorias c on l.idCategoria = c.idCategoria
    join Detalle_Venta d on d.idLibro = l.idLibro
group by 
	l.nombre, a.nombre,c.nombre
order by 
	sum(d.cantidad) desc limit 5;
    
select * from Vista_Libros_Mas_Comprados;

-- Cree una vista que resuma las ventas mensuales de cada cliente.###################################################################
create view Vista_Compra_Por_Mes as
select
	c.nombre, c.primerApellido, c.segunApellido, year(v.fechaVenta) as anio, month(v.fechaVenta) as mes, sum(v.precioTotal) Gasto
from Clientes c
	join Ventas v on v.idCliente = c.idCliente
group by c.nombre, c.primerApellido, c.segunApellido, month(v.fechaVenta),  year(v.fechaVenta);

select * from Vista_Compra_Por_Mes;

-- ===================================================================================================================================================================
--  Procedimientos Almacenados
-- ===================================================================================================================================================================

-- cree un procedimiento almacenado que permita una nueva venta, actualizar el inventario y la info del cliente #####################################################
delimiter $$
create procedure RegistrarVenta(
    in p_idCliente int,
    in p_idEmpleado int,
    in p_descuento decimal(10,2),
    in p_impuesto decimal(10,2),
    in p_precioTotal decimal(10,2),
    in p_fecha date,
    
    -- Detalles de 1 libro
    in p_idLibro int,
    in p_cantidad int,
    in p_precioLibro decimal(10,2)
)
begin
    declare v_idVenta int;

    -- Insertar la venta
    insert into Ventas(idCliente, idEmpleado, descuento, impuesto, precioTotal, fechaVenta) values
		(p_idCliente, p_idEmpleado, p_descuento, p_impuesto, p_precioTotal, p_fecha);

    -- Obtener el ID de la venta recién insertada
    set v_idVenta = last_insert_id();

    -- Insertar el detalle de venta
    insert into Detalle_Venta(idVenta, idLibro, cantidad, precioLibro) values
		(v_idVenta, p_idLibro, p_cantidad, p_precioLibro);
    
end$$
delimiter ;

call RegistrarVenta(
    2,           -- idCliente
    1,           -- idEmpleado
    500,      -- descuento
    650,      -- impuesto
    9650,     -- precio total
    '2025-01-02',-- fecha
    9,           -- idLibro
    4,           -- cantidad
    8500      -- precio del libro
);

-- Cree un procedimiento que calcule y devuelva el total de ventas de un autor específico. ##############################################################
delimiter $$
create procedure TotalVentasAutor(
    in p_idAutor int,
    out p_totalVentas decimal(10,2)
)
begin
    select 
        ifnull(sum(dv.cantidad * dv.precioLibro), 0)
    into p_totalVentas
    from Detalle_Venta dv
		join Libros l on dv.idLibro = l.idLibro
		where l.idAutor = p_idAutor;
end$$
delimiter ;

-- se crea una variable que sera la encargada de capturar el out
set @total := 0;
call TotalVentasAutor(3, @total);

-- Mostrar el resultado
select @total as TotalVentasColones;

-- ===================================================================================================================================================================
--  Triggers
-- ===================================================================================================================================================================

-- Cree un trigger que automáticamente actualice el stock de libros cuando se realice una venta.#################################################################
delimiter $$
create trigger tr_actualizar_stock_libro
after insert on Detalle_Venta
for each row
begin
    update Libros
    set cantidad = cantidad - new.cantidad
		where idLibro = new.idLibro;
end$$
delimiter ;

-- Cree un trigger que registre en una tabla llamada log_table cada vez que se borre un cliente.#######################################################################
create table log_table (
    idLog int auto_increment primary key,
    idCliente int,
    nombre varchar(30),
    primerApellido varchar(30),
    segunApellido varchar(30),
    correo varchar(100),
    fechaEliminacion date default (current_date())
);

delimiter $$
create trigger tr_log_eliminacion_cliente
after delete on Clientes
for each row
begin
    insert into log_table (idCliente, nombre, primerApellido, segunApellido, correo)
    values (old.idCliente, old.nombre, old.primerApellido, old.segunApellido, old.correo);
end$$
delimiter ;

-- probamos el triger
insert into Clientes (cedula, nombre, primerApellido, segunApellido, telefono, correo) values 
	(00, '00', '00', '00', '00', '00');
    
delete from Clientes
	where correo = '00';
    
select * from log_table;
