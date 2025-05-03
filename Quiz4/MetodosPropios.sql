use Libreria;
-- ===================================================================================================================================================================
--  Analisis de base de datos
-- ===================================================================================================================================================================

-- Como parte de su proceso de aprendizaje, analice la base de datos creada y desarrolle vistas,
-- procedimientos almacenados y triggers que considere útiles para facilitar la gestión futura por
-- parte de los administradores de bases de datos.


-- ===================================================================================================================================================================
--  Vistas
-- ===================================================================================================================================================================

-- ##########################################################################################################################
-- Vista para mostrar todos aquellos libros que tengan un stock muy bajo.
-- Esto se puede usar para futuras "alertas" y poder saber que libros estan proximos a acabarse y/o se acabaron
create view Vista_Stock_Minimo as
select 
	l.idLibro, l.nombre as Libro, l.cantidad as Stock, c.nombre as Categoria,e.nombre as Editorial
from Libros l
	join Categorias c on l.idCategoria = c.idCategoria
	join Editoriales e on l.idEditorial = e.idEditorial
	where l.cantidad < 5;

select * from Vista_Stock_Minimo;


-- ##########################################################################################################################

-- Clientes ordenados por cantidad de compras
-- esto con el fin de saber quienes han sido los clientes mas activos
create view Vista_Clientes_Mas_Activos as
select 
    c.idCliente, c.nombre, c.primerApellido, c.segunApellido, count(v.idVenta) as TotalCompras, sum(v.precioTotal) as TotalGastado
from Clientes c
	join Ventas v on v.idCliente = c.idCliente
group by c.idCliente
order by TotalCompras desc;

select * from Vista_Clientes_Mas_Activos;


-- ##########################################################################################################################
-- tomando de ejemplo a los clientes...
-- esta vista es para ver a los empleados que mas han vendido
create view Vista_Empleados_Mas_Ventas as
select 
    e.idEmpleado, e.nombre as Empleado, e.rol, count(v.idVenta) as CantidadVentas, sum(v.precioTotal) as MontoTotalVendido
from Empleados e
	join Ventas v on e.idEmpleado = v.idEmpleado
group by e.idEmpleado, e.nombre, e.rol
order by MontoTotalVendido desc;

select * from Vista_Empleados_Mas_Ventas;

-- ##########################################################################################################################

-- Una vista para detectar estados inconsistentes
-- es decir, si hay libros con stock pero que en su id de estado es agotado, o viceversa

create view Vista_Estado_Inconsistente as
select 
	l.idLibro, l.nombre as Libro,a.nombre as Autor, l.cantidad as Stock, el.descripcion as Estado
from Libros l
join EstadoLibro el on l.idEstado = el.idEstado
join Autores a on l.idAutor = a.idAutor
where l.idEstado = 2 and l.cantidad > 0 
	or l.idEstado = 1 and l.cantidad = 0;

select * from Vista_Estado_Inconsistente;

-- update para probar el estado insconsistente
update Libros
	set idEstado = 1, cantidad= 0
		where nombre = 'Introduccion a MySQL';
        

-- ===================================================================================================================================================================
--  Procedimientos
-- ===================================================================================================================================================================

-- ##########################################################################################################################
-- tomando en cuenta la vista de estados inconsistentes
-- se crea un procedimiento que actualiza todos aquellos libro que tenga inconsistencia en el estado

delimiter $$
create procedure CorregirEstadoLibrosInconsistentes()
begin
    -- Corregir libros marcados como "agotados" pero con stock
    update Libros
    set idEstado = 1
		where idEstado = 2 and cantidad > 0;
    
    -- Corregir libros marcados como "disponibles" pero sin stock
    update Libros
    set idEstado = 2
		where idEstado = 1 and cantidad = 0;
end$$
delimiter ;

call CorregirEstadoLibrosInconsistentes();
select * from Vista_Estado_Inconsistente; -- comprobamos si funciono


-- ##########################################################################################################################
-- Un procedimiento almacenado que corrige manualmente el stock de un libro
-- en caso de que hayn devoluciones o algun error

delimiter $$
create procedure ActualizarStockManual(
    in p_idLibro int,
    in p_nuevoStock int
)
begin
    update Libros
		set cantidad = p_nuevoStock
		where idLibro = p_idLibro;
end$$
delimiter ;

call ActualizarStockManual(13,13);

-- ##########################################################################################################################
-- en caso de que se vaya a registrar un cliente completo, es decir
-- que el cliente decidio dar una direccion, se aplica este procedimiento  

delimiter $$
create procedure RegistrarClienteCompleto(
    in p_cedula int,
    in p_nombre varchar(30),
    in p_primerApellido varchar(30),
    in p_segunApellido varchar(30),
    in p_telefono varchar(20),
    in p_correo varchar(100),
    in p_provincia varchar(50),
    in p_canton varchar(50),
    in p_distrito varchar(50),
    in p_direccionExacta text
)
begin
	-- primeramente se debe de insertar la direccion 
    declare v_idDireccion int;

    insert into Direcciones(provincia, canton, distrito, direccionExacta) values
		(p_provincia, p_canton, p_distrito, p_direccionExacta);

    set v_idDireccion = last_insert_id();
	
    insert into Clientes(cedula, nombre, primerApellido, segunApellido, telefono, correo, idDireccion) values
		(p_cedula, p_nombre, p_primerApellido, p_segunApellido, p_telefono, p_correo, v_idDireccion);
end$$
delimiter ;

call RegistrarClienteCompleto(
    987654321,           -- p_cedula
    'Khris',              -- p_nombre
    'Rodriguez',             -- p_primerApellido
    'Ruiz',          -- p_segunApellido
    '1234-4321',          -- p_telefono
    'Khrs@gmail.com',  -- p_correo
    'Puntarenas',          -- p_provincia
    'Central',           -- p_canton
    'Chacarita',            -- p_distrito
    'Contiguo al cementerio' -- p_direccionExacta
);

-- ===================================================================================================================================================================
--  Triggers
-- ===================================================================================================================================================================

-- ##########################################################################################################################
-- un trigger que valida si se esta realizando una venta con un
-- libro que no tenga suficiente cantidad

delimiter $$
create trigger tr_validar_stock
before insert on Detalle_Venta
for each row
begin
	declare stock int;
    select cantidad into stock from Libros where idLibro = new.idLibro;
    
    if stock < new.cantidad then
        signal sqlstate '45000' set message_text = 'No hay suficiente stock para realizar la venta.';
    end if;
end$$
delimiter ;

-- select para saber que tenemos en ventas y libros
select * from Ventas;
select * from Libros;
-- probamos el trigger haciendo una venta para libro con stock en 0 
insert into Detalle_Venta (idVenta, idLibro, cantidad, precioLibro)
values (6, 14, 5, 12500);



-- ##########################################################################################################################
-- dos trigger que convierten el correo ingresado a minusculas
-- uno cuando se hace un inset y otro cuando se hace un update

delimiter $$
create trigger tr_normalizar_correo_insert
before insert on Clientes
for each row
begin
    set new.correo = lower(new.correo);
end$$
delimiter ;

delimiter $$
create trigger tr_normalizar_correo_update
before update on Clientes
for each row
begin
    set new.correo = lower(new.correo);
end$$
delimiter ;



