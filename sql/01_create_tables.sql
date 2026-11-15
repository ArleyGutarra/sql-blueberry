-------------------------
-- INSTRUCCIONES
-------------------------
-- 1. Crear la base de datos "blueberry_db" en PostgreSQL.
-- $ CREATE DATABASE blueberry_db;

-- 2. Entra a la base de datos "blueberry_db" y ejecuta este script para crear las tablas.
-- $ \c blueberry_db
-- $ psql -U tu_usuario -d blueberry_db -f /ruta/al/archivo/script.sql

----------------------------------------------------------

-- ESQUEMA DE BASE DE DATOS PARA LA TIENDA EN LÍNEA "BLUEBERRY"
-- Catálogos
-- marca(#id_marca, nombre, descripcion)
-- metodos_pago(#id_metodo_pago, nombre, descripcion)
-- categoria(#id_categoria, super_categoria, nombre, descripcion)

-- Cliente
-- cliente(#id_cliente, email, password_hash, telefono, dni, nombres, apellidos, fecha_nacimiento)
-- cliente_direcciones(#id_direccion_cliente, #id_cliente, departamento, provincia, distrito, direccion, referencia)

-- Productos
-- producto(#id_producto, nombre, descripcion, id_categoria, id_marca, precio, peso)
-- producto_especificaciones(#id_producto, nombre_especificacion, valor)
-- componentes_computadora(#id_computadora, #id_componente, cantidad)

-- Establecimientos e inventario
-- establecimiento(#id_establecimiento, tipo_establecimiento, nombre, ciudad, ubicacion)
-- inventario(#id_establecimiento, #id_producto, stock)

-- Pedidos, entregas y pagos
-- pedido(#id_pedido, #id_cliente, fecha_pedido, estado_pedido, subtotal_productos, costo_envio, descuento)
-- articulos_pedido(#id_pedido, #id_producto, #id_establecimiento, cantidad, precio_unit)
-- entrega(#id_entrega, #id_pedido, tipo_entrega, estado_entrega, fecha_entrega, lugar_origen, lugar_destino)
-- pago(#id_pago, #id_pedido, fecha_pago, id_metodo_pago, codigo_transaccion, tarjeta_last_digits, estado_pago)
-- reembolso(#id_reembolso, #id_pago, fecha_reembolso, monto, motivo, estado_reembolso)

-- Carrito de compras
-- carrito(#id_carrito, #id_cliente, fecha_creacion, estado)
-- articulos_carrito(#id_carrito, #id_producto, cantidad)



-- 0. Tablas de catálogo independientes
CREATE TABLE marca (
    id_marca SERIAL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,

    -- Restricciones
    CONSTRAINT pk_marca PRIMARY KEY (id_marca),
    CONSTRAINT uq_marca_nombre UNIQUE (nombre)
);

CREATE TABLE metodos_pago (
    id_metodo_pago SERIAL,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,

    -- Restricciones
    CONSTRAINT pk_metodos_pago PRIMARY KEY (id_metodo_pago),
    CONSTRAINT uq_metodos_pago_nombre UNIQUE (nombre)
);

CREATE TABLE categoria (
    id_categoria SERIAL,
    super_categoria INT, -- Puede ser NULL si es la categoría raíz
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,

    -- Restricciones
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria),
    CONSTRAINT fk_categoria__super_categoria FOREIGN KEY (super_categoria) REFERENCES categoria(id_categoria)
);

-- 1. Tablas relacionadas con el cliente
CREATE TABLE cliente (
    id_cliente SERIAL,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    dni VARCHAR(20) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,

    --Restricciones
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT uq_cliente_email UNIQUE (email),
    CONSTRAINT uq_cliente_dni UNIQUE (dni),
    CONSTRAINT ck_cliente_telefono CHECK (telefono ~ '^[0-9]{9}$'),
    CONSTRAINT ck_cliente_dni CHECK (dni ~ '^[0-9]{8}$'),
    CONSTRAINT ck_cliente_email CHECK (email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
);

CREATE TABLE cliente_direcciones (
    id_direccion_cliente SERIAL,
    id_cliente INT NOT NULL,
    departamento VARCHAR(100) NOT NULL,
    provincia VARCHAR(100) NOT NULL,
    distrito VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    referencia VARCHAR(255),

    --Restricciones
    CONSTRAINT pk_cliente_direcciones PRIMARY KEY (id_direccion_cliente),
    CONSTRAINT fk_cliente_direcciones__cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- 2. Tablas relacionadas con el producto
CREATE TABLE producto (
    id_producto SERIAL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    id_categoria INT NOT NULL,
    id_marca INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    peso DECIMAL(8, 2), -- Puede ser NULL o 0 si es software/servicio

    -- Restricciones
    CONSTRAINT pk_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_producto__categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    CONSTRAINT fk_producto__marca FOREIGN KEY (id_marca) REFERENCES marca(id_marca),
    CONSTRAINT ck_producto_precio CHECK (precio >= 0),
    CONSTRAINT ck_producto_peso CHECK (peso >= 0)
);

CREATE TABLE producto_especificaciones (
    id_producto INT NOT NULL,
    nombre_especificacion VARCHAR(100) NOT NULL,
    valor VARCHAR(255) NOT NULL,

    -- Restricciones
    CONSTRAINT pk_producto_especificaciones PRIMARY KEY (id_producto, nombre_especificacion),
    CONSTRAINT fk_producto_espec_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE componentes_computadora (
    id_computadora INT NOT NULL,
    id_componente INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,

    -- Restricciones
    CONSTRAINT pk_componentes_computadora PRIMARY KEY (id_computadora, id_componente),
    CONSTRAINT fk_comp_computadora FOREIGN KEY (id_computadora) REFERENCES producto(id_producto),
    CONSTRAINT fk_comp_componente FOREIGN KEY (id_componente) REFERENCES producto(id_producto),
    CONSTRAINT ck_comp_cantidad CHECK (cantidad > 0)
);

-- 3. Tablas de establecimientos e inventario
CREATE TABLE establecimiento (
    id_establecimiento SERIAL PRIMARY KEY,
    tipo_establecimiento VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(255) NOT NULL,

    CONSTRAINT ck_establecimiento_tipo
    CHECK (tipo_establecimiento IN (
        'tienda', 'almacen'))
);

CREATE TABLE inventario (
    id_establecimiento INT NOT NULL,
    id_producto INT NOT NULL,
    stock INT NOT NULL DEFAULT 0,

    -- Restricciones
    CONSTRAINT pk_inventario PRIMARY KEY (id_establecimiento, id_producto),
    CONSTRAINT fk_inventario__establecimiento FOREIGN KEY (id_establecimiento) REFERENCES establecimiento(id_establecimiento),
    CONSTRAINT fk_inventario__producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT ck_inventario_stock CHECK (stock >= 0)
);

-- 4. Tablas transaccionales principales (Pedidos, Entregas y Pagos)
CREATE TABLE pedido (
    id_pedido SERIAL,
    id_cliente INT NOT NULL,
    fecha_pedido TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_pedido VARCHAR(50) NOT NULL,
    subtotal_productos DECIMAL(10, 2) NOT NULL,
    costo_envio DECIMAL(10, 2) NOT NULL,
    descuento DECIMAL(5, 2) DEFAULT 0, -- Porcentaje de descuento aplicado al pedido (0-100)

    --Restricciones
    CONSTRAINT pk_pedido PRIMARY KEY (id_pedido),
    CONSTRAINT fk_pedido__cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT ck_pedido_estado CHECK (estado_pedido IN ('pago_pendiente', 'pagado', 'en_preparacion', 'entregado', 'cancelado')),
    CONSTRAINT ck_descuento CHECK (descuento >= 0 AND descuento <= 100)
);


CREATE TABLE articulos_pedido (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    id_establecimiento INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unit DECIMAL(10, 2) NOT NULL,

    -- Restricciones
    CONSTRAINT pk_articulos_pedido PRIMARY KEY (id_pedido, id_producto, id_establecimiento), -- incluir id_establecimiento en la clave primaria permite que un pedido pueda tener el mismo producto de diferentes establecimientos
    CONSTRAINT fk_articulos_pedido__pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_articulos_pedido__producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT fk_articulos_pedido__inventario FOREIGN KEY (id_establecimiento, id_producto) REFERENCES inventario(id_establecimiento, id_producto),
    CONSTRAINT ck_art_pedido_cantidad CHECK (cantidad > 0),
    CONSTRAINT ck_art_pedido_precio CHECK (precio_unit >= 0)
);

CREATE TABLE entrega (
    id_entrega SERIAL,
    id_pedido INT NOT NULL,
    tipo_entrega VARCHAR(50) NOT NULL,
    estado_entrega VARCHAR(50) NOT NULL,
    fecha_entrega TIMESTAMP,
    lugar_origen INT NOT NULL,
    lugar_destino INT, -- Puede ser NULL si el tipo entrega es "recojo_tienda"

    -- Restricciones
    CONSTRAINT pk_entrega PRIMARY KEY (id_entrega),
    CONSTRAINT fk_entrega__pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_entrega__origen FOREIGN KEY (lugar_origen) REFERENCES establecimiento(id_establecimiento),
    CONSTRAINT fk_entrega__destino FOREIGN KEY (lugar_destino) REFERENCES cliente_direcciones(id_direccion_cliente),
    CONSTRAINT ck_entrega_tipo CHECK (
    (tipo_entrega = 'domicilio' AND lugar_destino IS NOT NULL)
    OR
    (tipo_entrega = 'recojo_tienda' AND lugar_destino IS NULL)
    ),
    CONSTRAINT ck_entrega_estado CHECK (estado_entrega IN ('pendiente', 'en_preparacion', 'en_transito', 'listo_para_recojo', 'entregado','cancelado')
)

);

CREATE TABLE pago (
    id_pago SERIAL,
    id_pedido INT NOT NULL,
    fecha_pago TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_metodo_pago INT NOT NULL,
    codigo_transaccion VARCHAR(100),
    tarjeta_last_digits VARCHAR(4),
    estado_pago VARCHAR(50) NOT NULL,

    -- Restricciones
    CONSTRAINT pk_pago PRIMARY KEY (id_pago),
    CONSTRAINT uq_pago_transaccion UNIQUE (codigo_transaccion),
    CONSTRAINT fk_pago__pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_pago__metodo_pago FOREIGN KEY (id_metodo_pago) REFERENCES metodos_pago(id_metodo_pago),
    CONSTRAINT ck_pago_estado CHECK (estado_pago IN ('pendiente', 'aprobado', 'rechazado', 'reembolsado')),
    CONSTRAINT ck_pago_tarjeta CHECK (tarjeta_last_digits ~ '^[0-9]{4}$')
);

CREATE TABLE reembolso (
    id_reembolso SERIAL,
    id_pago INT NOT NULL,
    fecha_reembolso TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    monto DECIMAL(10, 2) NOT NULL,
    motivo TEXT,
    estado_reembolso VARCHAR(50) NOT NULL,

    -- Restricciones
    CONSTRAINT pk_reembolso PRIMARY KEY (id_reembolso),
    CONSTRAINT fk_reembolso__pago FOREIGN KEY (id_pago) REFERENCES pago(id_pago),
    CONSTRAINT ck_reembolso_monto CHECK (monto >= 0),
    CONSTRAINT ck_reembolso_estado CHECK (estado_reembolso IN ('solicitado', 'en_proceso', 'completado', 'rechazado'))
);

-- 5. Tablas de Carrito de Compras
CREATE TABLE carrito (
    id_carrito SERIAL,
    id_cliente INT NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(50) NOT NULL,

    -- Restricciones
    CONSTRAINT pk_carrito PRIMARY KEY (id_carrito),
    CONSTRAINT fk_carrito__cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT ck_carrito_estado CHECK (estado IN ('activo', 'abandonado', 'completado'))
);

CREATE TABLE articulos_carrito (
    id_carrito INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,

    -- Restricciones
    CONSTRAINT pk_articulos_carrito PRIMARY KEY (id_carrito, id_producto),
    CONSTRAINT fk_articulos_carrito__carrito FOREIGN KEY (id_carrito) REFERENCES carrito(id_carrito),
    CONSTRAINT fk_articulos_carrito__producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT ck_articulos_carrito_cantidad CHECK (cantidad > 0)
);

