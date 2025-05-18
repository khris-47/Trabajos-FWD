## 📝 Mini Proyecto, sistema de gestion de inventario

Este proyecto es un sistema basico de gestion de productos que permite administrar las categorias, proveedores y productos mediante una API REST construida con Django

## 🧰 Tecnologias

Backend - Django - Django REST Framework - MySql

Frontend
-React
-Vite
-Bootstrap 5

## 📁 Backend (Django)

📄 models.py
Contiene los modelos:

    Categoria
    Proveedor
    Producto
    CategoriaProducto (tabla intermedia  ManyToMany para Producto - Categoría)

📄 serializers.py

    Serializa los modelos para exponerlos en formato JSON.

📄 views.py
Vistas basadas en clases que exponen CRUD completo para cada modelo.

📄 urls.py
Usa routers para registrar las rutas automáticamente

## 📁 Frontend (React)

🧾 Formularios
Cada formulario tiene funcionalidad para:

    Mostrar lista actualizada
    Crear
    Editar
    Eliminar

Utiliza modales Bootstrap para las acciones de creación/edicion/eliminacion.

🔌 Servicios
Cada archivo en services/ expone funciones para interactuar con la API:

    obtenerXXX()
    crearXXX()
    actualizarXXX()
    eliminarXXX()

# ⚙️ Instalacion

🔧 Backend

pip install django djangorestframework
pip install mysqlclient
pip install django-cors-headers
python manage.py makemigrations
python manage.py migrate
python manage.py runserver

💻 Frontend

npm create vite@latest
npm install
npm install react-router-dom
npm install bootstrap (esto es opcional, pero si presenta algun error, es mejor instalarlo)

# 📌 Funcionalidades

    ✅ CRUD completo de Categorias
    ✅ CRUD completo de Proveedores
    ✅ CRUD de Productos con relaciones a multiples Categorias y un Proveedor
    ✅ Uso de modales para operaciones sin recargar la pagina
    ✅ Separacion clara entre frontend y backend

# 📘 Uso de la API con Postman

A continuacion se presentan ejemplo para probar la API usando postman, empezando primeramento por la URL base:
http://localhost:8000/

🔹 📂 Categorias

    GET: http://localhost:8000/api/categoria/

➕ Crear una nueva categoría (POST)

    POST:  http://localhost:8000/api/categoria/

escribe en el body(JSON)

{
"nombre": "Oficina",
"descripcion": " Productos de Oficina"
}

📌 Nota: Intenta hacer varios, asi podrias usar con mayor disponibilidad los siguientes metodos

✏️ Actualizar una categoria (PUT)

    PUT:  http://localhost:8000/api/categoria/3/

    ten en cuenta que debemos llamar a "ids" que existan, ahora, al igual que en el POST, escribimos en el body

{
"nombre": "Electrodomestico",
"descripcion": " Productos de Oficina"
}

    y se deberia de haber actualizado la categoria con el id 1

❌ Eliminar una categoria (DELETE)

     http://localhost:8000/api/categoria/3/

con esto estariamos eliminando a la categoria con el id 3

🔹 📂 Proveedores

los procesos son los mismos, las diferencias son el body y url

    GET:  http://localhost:8000/api/proveedor/

➕ Crear un nuevo proveedor (POST)

    POST:  http://localhost:8000/api/proveedor/


    {
    "id": 0,
    "nombre": "ExtremeTech",
    "contacto": "Juan Perez",
    "telefono": "555-1234",
    "correo": "ext@gmail.com",
    "cedulaJuridica" : "929292929"
    }

❌ Eliminar un proveedor (DELETE)

    DELETE:  http://localhost:8000/api/proveedor/8/

🔹 📂 Productos

    GET: http://localhost:8000/api/producto/

➕ Crear un nuevo producto (POST)
    POST: http://localhost:8000/api/producto/

{
"nombre": "Monitor Samsung",
"descripcion": "24 pulgadas",
"precio": 180.5,
"cantidad": 15,
"codigoBarras": "987654321",
"proveedores": 1,
"categorias_ids": [1, 2]
}

❌ Eliminar un producto (DELETE)
DELETE: http://localhost:8000/api/producto/2/

📌 Nota: recuerda que los links para eliminar tambien son para el PUT

# 📘 Uso de la API con React

con react es mucho mas sencilla la prueba, en el menu de navegacion tendras 4 opciones

    -Inicio
    -Categorias
    -Proveedores
    -Productos

prueba alguno de los modulos, si primeramente haz realizado las pruebas con postman, te saldran en cada una de las ventanas los objetos que ya hayas creado.

🔹 📂 Categorias

    tendras un boton de Agregar, al precionarlo se te abrira un modal donde podras escoger el nombre y la descripcion (no debe estar en blanco), al presionar guardar, se cerrara el modal y te aparecera auomaticamente en la lista, ahora, desde la lista tendras un boton para editar o eliminar, Disfruta haciendo POST, PUT y DELETE de una forma mas comoda.

🔹 📂 Proveedores

    De igual forma que con categorias, las opciones son las mismas (exceptuando, claro, los inputs para proveedores).

🔹 📂 Productos

    Ahora si, aqui viene lo curioso, recuerdas que productos tenia una relacion ManyToMany con categorias?
    Para no perder eso, se agrego una lista con todas las categorias ya existentes, para que puedas escoger varias, y para los proveedores tambien tenemos un menu desplegable, solo que, al ser de Uno a Uno, se selecciona solo uno de la lista existentes, y esto tambien aplica al omento de editar.




