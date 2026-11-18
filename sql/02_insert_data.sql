---------------------------------
-- CATEGORIAS
---------------------------------
-- Categorias principales 
INSERT INTO categoria (nombre, descripcion)
VALUES
    ('Computadoras', NULL),
    ('Monitores y Proyectores', NULL),
    ('Celulares', NULL),
    ('Laptops', NULL),
    ('Tablets', NULL),
    ('Componentes de PC', 'Componentes internos para computadoras.'),
    ('Juegos y Consolas', NULL),
    ('Almacenamiento externo', NULL),
    ('Periféricos', NULL),
    ('Accesorios y conectividad', NULL);

-- Subcategorias
INSERT INTO categoria (super_categoria, nombre, descripcion)
VALUES
    -- Computadoras (id_categoria = 1)
    (1, 'Mini PC', NULL),
    (1, 'All in One', NULL),
    (1, 'PCs Armadas', NULL),

    -- Monitores y Proyectores (id_categoria = 2)
    (2, 'Monitores', NULL),
    (2, 'Proyectores', NULL),

    -- Componentes de PC (id_categoria = 6)
    (6, 'Procesadores', NULL),
    (6, 'Placas madre', NULL),
    (6, 'Memorias RAM', NULL),
    (6, 'Tarjetas gráficas', NULL),
    (6, 'Almacenamiento interno', NULL),
    (6, 'Fuentes de poder', NULL),
    (6, 'Gabinetes', NULL),
    (6, 'Refrigeración', NULL),
    (6, 'Tarjetas de expansión', NULL),
    (6, 'Tarjetas de sonido y red', NULL),

    -- Juegos y Consolas (id_categoria = 7)
    (7, 'Consolas', NULL),
    (7, 'Videojuegos', NULL),
    (7, 'Accesorios para consolas', NULL),

    -- Almacenamiento externo (id_categoria = 8)
    (8, 'Discos externos', NULL),
    (8, 'Memorias USB', NULL),
    (8, 'Tarjetas de memoria', NULL),

    -- Periféricos (id_categoria = 9)
    (9, 'Mouse', NULL),
    (9, 'Teclados', NULL),
    (9, 'Parlantes', NULL),
    (9, 'Audífonos', NULL),
    (9, 'Cámaras web', NULL),
    (9, 'Micrófonos', NULL),
    (9, 'Tabletas gráficas', NULL),

    -- Accesorios y conectividad (id_categoria = 10)
    (10, 'Cables y adaptadores', NULL),
    (10, 'Hubs y estaciones de acoplamiento', NULL),
    (10, 'Routers y repetidores', NULL),
    (10, 'UPS y estabilizadores', NULL);

---------------------------------
-- MARCA
---------------------------------
INSERT INTO marca (nombre, pais, descripcion)
VALUES
    ('ASUS', 'Taiwán', NULL),
    ('MSI', 'Taiwán', NULL),
    ('Gigabyte', 'Taiwán', NULL),
    ('ASRock', 'Taiwán', NULL),
    ('Intel', 'Estados Unidos', NULL),
    ('AMD', 'Estados Unidos', NULL),
    ('NVIDIA', 'Estados Unidos', NULL),
    ('Corsair', 'Estados Unidos', NULL),
    ('Kingston', 'Estados Unidos', NULL),
    ('Crucial', 'Estados Unidos', NULL),
    ('Samsung', 'Corea del Sur', NULL),
    ('Western Digital', 'Estados Unidos', NULL),
    ('Seagate', 'Estados Unidos', NULL),
    ('ADATA', 'Taiwán', NULL),
    ('TeamGroup', 'Taiwán', NULL),
    ('Cooler Master', 'Taiwán', NULL),
    ('NZXT', 'Estados Unidos', NULL),
    ('Thermaltake', 'Taiwán', NULL),
    ('Logitech', 'Suiza', NULL),
    ('Razer', 'Singapur', NULL),
    ('HyperX', 'Estados Unidos', NULL),
    ('HP', 'Estados Unidos', NULL),
    ('Dell', 'Estados Unidos', NULL),
    ('Lenovo', 'China', NULL),
    ('Acer', 'Taiwán', NULL),
    ('Apple', 'Estados Unidos', NULL),
    ('LG', 'Corea del Sur', NULL),
    ('ViewSonic', 'Estados Unidos', NULL),
    ('BenQ', 'Taiwán', NULL),
    ('Sony', 'Japón', NULL),
    ('Xiaomi', 'China', NULL),
    ('Motorola', 'Estados Unidos', NULL),
    ('JBL', 'Estados Unidos', NULL),
    ('Epson', 'Japón', NULL),
    ('Brother', 'Japón', NULL),
    ('TP-Link', 'China', NULL),
    ('Ubiquiti', 'Estados Unidos', NULL),
    ('Anker', 'China', NULL);


---------------------------------
-- METODOS DE PAGO
---------------------------------
INSERT INTO metodos_pago (nombre_metodo_pago)
VALUES
    ('Tarjeta de crédito'),
    ('Tarjeta de débito'),
    ('Transferencia bancaria'),
    ('Yape'),
    ('Plin'),
    ('Pago en efectivo'),
    ('Pago contra entrega'),
    ('PayPal'),
    ('Google Pay'),
    ('Apple Pay');


---------------------------------
-- CLIENTES
---------------------------------
INSERT INTO cliente (email, password_hash, telefono, dni, nombres, apellidos, fecha_nacimiento)
VALUES
    ('andrea.lopez@gmail.com', 'hash_demo_001', '987654321', '71234561', 'Andrea', 'Lopez Garcia', '2001-03-15'),
    ('carlos.mendoza@gmail.com', 'hash_demo_002', '976543218', '72345612', 'Carlos', 'Mendoza Torres', '1998-07-22'),
    ('valeria.rojas@gmail.com', 'hash_demo_003', '965432187', '73456123', 'Valeria', 'Rojas Flores', '2003-11-08'),
    ('diego.castillo@gmail.com', 'hash_demo_004', '954321876', '74561234', 'Diego', 'Castillo Ramos', '1999-01-30'),
    ('lucia.fernandez@gmail.com', 'hash_demo_005', '943218765', '75612345', 'Lucia', 'Fernandez Vega', '2000-06-12'),
    ('miguel.sanchez@gmail.com', 'hash_demo_006', '932187654', '76723456', 'Miguel', 'Sanchez Perez', '1997-09-25'),
    ('camila.torres@gmail.com', 'hash_demo_007', '921876543', '77834567', 'Camila', 'Torres Medina', '2002-04-19'),
    ('sebastian.ruiz@gmail.com', 'hash_demo_008', '912345678', '78945678', 'Sebastian', 'Ruiz Chavez', '1996-12-03'),
    ('daniela.vargas@gmail.com', 'hash_demo_009', '998765432', '79156789', 'Daniela', 'Vargas Silva', '2001-08-17'),
    ('gabriel.morales@gmail.com', 'hash_demo_010', '987123456', '70267891', 'Gabriel', 'Morales Diaz', '1995-02-28'),
    ('paola.herrera@gmail.com', 'hash_demo_011', '976234567', '71378912', 'Paola', 'Herrera Castro', '2004-05-06'),
    ('fernando.castro@gmail.com', 'hash_demo_012', '965345678', '72489123', 'Fernando', 'Castro Leon', '1998-10-14'),
    ('sofia.ramirez@gmail.com', 'hash_demo_013', '954456789', '73591234', 'Sofia', 'Ramirez Soto', '2000-12-21'),
    ('alejandro.vasquez@gmail.com', 'hash_demo_014', '943567890', '74612345', 'Alejandro', 'Vasquez Ruiz', '1997-04-09'),
    ('mariana.paredes@gmail.com', 'hash_demo_015', '932678901', '75723456', 'Mariana', 'Paredes Luna', '2002-07-27'),
    ('ricardo.gutierrez@gmail.com', 'hash_demo_016', '921789012', '76834567', 'Ricardo', 'Gutierrez Ramos', '1999-11-16');

---------------------------------
--  DIRECCIONES
---------------------------------
INSERT INTO direccion (departamento, provincia, distrito, direccion, codigo_postal, referencia)
VALUES
    ('Lima', 'Lima', 'San Miguel', 'Av. La Marina 1234', '15088', 'Cerca de Plaza San Miguel'),
    ('Lima', 'Lima', 'Miraflores', 'Av. Larco 456', '15074', 'A dos cuadras del parque Kennedy'),
    ('Lima', 'Lima', 'Surco', 'Jr. Monte Rosa 789', '15023', 'Cerca del centro comercial'),
    ('La Libertad', 'Trujillo', 'Trujillo', 'Jr. Pizarro 234', '13001', NULL),
    ('La Libertad', 'Trujillo', 'Víctor Larco Herrera', 'Av. Larco 567', '13012', 'Cerca de la universidad'),
    ('Lima', 'Lima', 'San Borja', 'Av. San Luis 876', '15036', NULL),
    ('Cusco', 'Cusco', 'Wanchaq', 'Av. La Cultura 432', '08002', NULL),
    ('Piura', 'Piura', 'Piura', 'Av. Grau 123', '20001', NULL),
    ('Lima', 'Lima', 'La Molina', 'Av. Javier Prado 456', '15024', 'Cerca de la universidad'),
    ('Lima', 'Lima', 'Comas', 'Av. Universitaria 789', '15301', NULL),
    ('Lima', 'Lima', 'Independencia', 'Av. Túpac Amaru 321', '15302', NULL),
    ('Junín', 'Huancayo', 'Huancayo', 'Jr. Real 654', '12001', NULL),
    ('Lima', 'Lima', 'Ate', 'Av. Separadora Industrial 159', '15038', NULL),
    ('Lima', 'Lima', 'Barranco','Jr. Domeyer 753','15063','Cerca del malecón'),
    ('Lima','Lima','Chorrillos','Av. Huaylas 852','15067','Cerca del malecón');

INSERT INTO cliente_direcciones (id_cliente, id_direccion)
VALUES
    (1, 1), -- Cliente 1
    (2, 2), -- Cliente 2
    (2, 3), -- Cliente 2    
    (5, 4), -- Cliente 5
    (5, 5), -- Cliente 5
    (6, 6), -- Cliente 6
    (7, 7), -- Cliente 7
    (9, 8), -- Cliente 9
    (10, 9), -- Cliente 10
    (11, 10), -- Cliente 11
    (11, 11), -- Cliente 11
    (12, 12), -- Cliente 12
    (14, 13), -- Cliente 14
    (15, 14), -- Cliente 15
    (15, 15); -- Cliente 15

-- Clientes sin dirección asignada (para probar la integridad referencial): 3, 4, 8, 13


---------------------------------
-- PRODUCTOS
---------------------------------
INSERT INTO producto (nombre, descripcion, id_categoria, id_marca, precio, peso) 
VALUES
    -- Componentes de la PC 1 (IDs 1 al 8)
    ('AMD Ryzen 7 7800X3D', 'Procesador tope de gama para gaming competitivo.', 16, 6, 399.99, 0.20),
    ('ASUS ROG Strix B650-A', NULL, 17, 1, 229.99, 1.20),
    ('Corsair Vengeance 32GB DDR5', 'Kit de memoria RAM 2x16GB a 6000MHz.', 18, 8, 114.99, 0.15),
    ('MSI GeForce RTX 4080', 'Tarjeta de video para jugar a 4K sin compromisos.', 19, 2, 1199.99, 2.10),
    ('Samsung 990 PRO 2TB', NULL, 20, 11, 169.99, 0.05),
    ('Corsair RM850x', 'Fuente de poder 80 Plus Gold totalmente modular.', 21, 8, 129.99, 1.70),
    ('NZXT H7 Flow', NULL, 22, 17, 129.99, 10.50),
    ('NZXT Kraken 240', 'Refrigeración líquida AIO de 240mm.', 23, 17, 139.99, 1.50),

    -- Componentes de la PC 2 (IDs 9 al 14)
    ('Intel Core i5-13400', 'Procesador balanceado para productividad y multitarea.', 16, 5, 239.99, 0.30),
    ('Gigabyte B760M DS3H', NULL, 17, 3, 109.99, 0.90),
    ('Kingston FURY Beast 16GB DDR4', NULL, 18, 9, 49.99, 0.10),
    ('Western Digital Blue SN570 1TB', 'SSD NVMe ideal para ensambles económicos.', 20, 12, 59.99, 0.05),
    ('Thermaltake Smart 500W', NULL, 21, 18, 39.99, 1.50),
    ('Cooler Master MasterBox Q300L', 'Gabinete Micro-ATX con panel magnético.', 22, 16, 49.99, 4.50),

    -- Las Computadoras Armadas en sí mismas (IDs 15 y 16)
    ('PC Armada Gaming Extreme', 'Computadora preensamblada extrema con la serie RTX 4000.', 13, 1, 2600.00, 17.50),
    ('PC Armada Office Budget', 'Computadora de oficina lista para usar.', 13, 5, 580.00, 8.10),

    -- Periféricos y Monitores adicionales para completar los 20 (IDs 17 al 20)
    ('Monitor LG UltraGear 27"', 'Monitor gaming 1440p a 165Hz con panel Nano IPS.', 14, 27, 299.99, 6.00),
    ('Mouse Logitech G502 Hero', 'El mouse gaming más vendido del mundo.', 32, 19, 49.99, 0.25),
    ('Teclado Razer BlackWidow V3', 'Teclado mecánico con switches verdes táctiles.', 33, 20, 99.99, 1.10),
    ('Audífonos HyperX Cloud II', 'Sonido envolvente 7.1 y máxima comodidad.', 35, 21, 79.99, 0.35);


---------------------------------
-- COMPONENTES DE COMPUTADORA
---------------------------------
INSERT INTO componentes_computadora (id_computadora, id_componente, cantidad)
VALUES
    -- Desglose de la PC 1 (ID_computadora = 15)
    (15, 1, 1), -- 1x AMD Ryzen 7
    (15, 2, 1), -- 1x ASUS ROG Strix
    (15, 3, 1), -- 1x Kit Corsair RAM
    (15, 4, 1), -- 1x RTX 4080
    (15, 5, 1), -- 1x SSD Samsung
    (15, 6, 1), -- 1x PSU Corsair
    (15, 7, 1), -- 1x Gabinete NZXT
    (15, 8, 1), -- 1x Refrigeración líquida

    -- Desglose de la PC 2 (ID_computadora = 16)
    (16, 9, 1),  -- 1x Intel i5
    (16, 10, 1), -- 1x Gigabyte B760M
    (16, 11, 1), -- 1x Kit Kingston RAM
    (16, 12, 1), -- 1x SSD WD Blue
    (16, 13, 1), -- 1x PSU Thermaltake
    (16, 14, 1); -- 1x Gabinete Cooler Master


---------------------------------
-- ESPECIFICACIONES DE PRODUCTOS
---------------------------------
INSERT INTO producto_especificaciones (id_producto, nombre_especificacion, valor)
VALUES
    -- Especificaciones para el Procesador AMD (ID = 1)
    (1, 'Socket', 'AM5'),
    (1, 'Núcleos / Hilos', '8 / 16'),
    (1, 'Frecuencia Turbo Máxima', '5.0 GHz'),
    (1, 'TDP', '120W'),

    -- Especificaciones para la GPU MSI (ID = 4)
    (4, 'Memoria VRAM', '16GB GDDR6X'),
    (4, 'Interfaz de memoria', '256-bit'),
    (4, 'Consumo de energía', '320W'),

    -- Especificaciones para el SSD Samsung (ID = 5)
    (5, 'Formato', 'M.2 2280'),
    (5, 'Interfaz', 'PCIe 4.0 x4'),
    (5, 'Velocidad de lectura', 'Hasta 7450 MB/s'),
    (5, 'Velocidad de escritura', 'Hasta 6900 MB/s'),

    -- Especificaciones para el Monitor LG (ID = 17)
    (17, 'Resolución', '2560 x 1440 (QHD)'),
    (17, 'Tasa de refresco', '165Hz'),
    (17, 'Tiempo de respuesta', '1ms (GtG)'),
    (17, 'Tecnología de panel', 'Nano IPS'),

    -- Especificaciones para el Mouse Logitech (ID = 18)
    (18, 'Sensor', 'HERO 25K'),
    (18, 'DPI Máximo', '25,600 DPI'),
    (18, 'Botones programables', '11 botones'),
    (18, 'Peso ajustable', 'Sí, 5 pesas de 3.6g');


---------------------------------
-- ESTABLECIMIENTOS
---------------------------------

-- DIRECCIONES DE ESTABLECIMIENTOS
INSERT INTO direccion
    (departamento, provincia, distrito, direccion, codigo_postal, referencia)
VALUES
    ('Lima', 'Lima', 'Miraflores','Av. José Larco 850', '15074','Cerca del parque Kennedy.'),
    ('Lima', 'Lima', 'San Isidro','Av. República de Panamá 3055', '15047','Zona comercial y empresarial.'),
    ('Lima', 'Lima', 'Cercado de Lima','Jr. Paruro 1250', '15001','Zona comercial de productos tecnológicos.'),
    ('Arequipa', 'Arequipa', 'Yanahuara','Av. Ejército 710', '04013','Cerca del centro comercial de la zona.'),
    ('Cusco', 'Cusco', 'Cusco','Av. de la Cultura 1850', '08003', 'Cerca de la Universidad Nacional de San Antonio Abad.'),
    ('La Libertad', 'Trujillo', 'Trujillo','Av. América Oeste 750', '13011','Cerca de la zona comercial de Trujillo.'),
    ('Piura', 'Piura', 'Piura','Av. Sánchez Cerro 1250', '20001','Zona comercial de la ciudad.'),
    ('Lambayeque', 'Chiclayo', 'Chiclayo','Av. José Leonardo Ortiz 650', '14001','Zona céntrica de Chiclayo.'),
    ('Junín', 'Huancayo', 'Huancayo','Av. Giráldez 520', '12001','Cerca del centro de Huancayo.'),
    ('Tacna', 'Tacna', 'Tacna','Av. Bolognesi 1450', '23001', 'Zona comercial de Tacna.');

-- ESTABLECIMIENTOS

INSERT INTO establecimiento
    (tipo_establecimiento, nombre, id_direccion)
VALUES
    ('tienda', 'Blueberry Miraflores', 16),
    ('almacen', 'Almacen Blueberry San Isidro', 17),
    ('almacen', ' Almacen Blueberry Lima Centro', 18),
    ('tienda', 'Blueberry Arequipa', 19),
    ('tienda', 'Blueberry Cusco', 20),
    ('tienda', 'Blueberry Trujillo', 21),
    ('tienda', 'Blueberry Piura', 22),
    ('almacen', 'Almacen Blueberry Chiclayo', 23),
    ('tienda', 'Blueberry Huancayo', 24),
    ('almacen', 'Almacen Blueberry Tacna', 25);

----------------------------------------
-- INVENTARIO DE ESTABLECIMIENTOS
----------------------------------------
INSERT INTO inventario
    (id_establecimiento, id_producto, stock)
VALUES
    -- BLUEBERRY MIRAFLORES (ID 1) - TIENDA
    (1, 16, 1),  -- 1 unidad de PC Armada Office Budget
    (1, 17, 4),  -- 4 unidades de Monitor LG UltraGear 27"
    (1, 18, 8),  -- 8 unidades de Mouse Logitech G502 Hero

    -- BLUEBERRY SAN ISIDRO (ID 2) - ALMACEN
    (2, 15, 2),  -- 2 unidades de PC Armada Gaming Extreme
    (2, 1, 8),   -- 8 unidades de AMD Ryzen 7 7800X3D
    (2, 5, 10),  -- 10 unidades de Samsung 990 PRO 2TB

    -- BLUEBERRY LIMA CENTRO (ID 3) - ALMACEN
    (3, 3, 12),  -- 12 unidades de Corsair Vengeance 32GB DDR5
    (3, 4, 5),   -- 5 unidades de MSI GeForce RTX 4080
    (3, 19, 8),  -- 8 unidades de Teclado Razer BlackWidow V3

    -- BLUEBERRY AREQUIPA (ID 4) - TIENDA
    (4, 9, 4),   -- 4 unidades de Intel Core i5-13400
    (4, 10, 3),  -- 3 unidades de Gigabyte B760M DS3H
    (4, 17, 2),  -- 2 unidades de Monitor LG UltraGear 27"

    -- BLUEBERRY CUSCO (ID 5) - TIENDA
    (5, 11, 6),  -- 6 unidades de Kingston FURY Beast 16GB DDR4
    (5, 12, 5),  -- 5 unidades de Western Digital Blue SN570 1TB
    (5, 13, 4),  -- 4 unidades de Thermaltake Smart 500W

    -- BLUEBERRY TRUJILLO (ID 6) - TIENDA
    (6, 1, 3),   -- 3 unidades de AMD Ryzen 7 7800X3D
    (6, 6, 3),   -- 3 unidades de Corsair RM850x
    (6, 20, 5),  -- 5 unidades de Audífonos HyperX Cloud II

    -- BLUEBERRY PIURA (ID 7) - TIENDA
    (7, 2, 3),   -- 3 unidades de ASUS ROG Strix B650-A
    (7, 5, 4),   -- 4 unidades de Samsung 990 PRO 2TB
    (7, 18, 6),  -- 6 unidades de Mouse Logitech G502 Hero

    -- BLUEBERRY CHICLAYO (ID 8) - ALMACEN
    (8, 6, 8),   -- 8 unidades de Corsair RM850x
    (8, 7, 6),   -- 6 unidades de NZXT H7 Flow
    (8, 19, 10), -- 10 unidades de Teclado Razer BlackWidow V3

    -- BLUEBERRY HUANCAYO (ID 9) - TIENDA
    (9, 9, 3),   -- 3 unidades de Intel Core i5-13400
    (9, 11, 4),  -- 4 unidades de Kingston FURY Beast 16GB DDR4
    (9, 20, 4),  -- 4 unidades de Audífonos HyperX Cloud II

    -- BLUEBERRY TACNA (ID 10) - ALMACEN
    (10, 10, 6), -- 6 unidades de Gigabyte B760M DS3H
    (10, 12, 8), -- 8 unidades de Western Digital Blue SN570 1TB
    (10, 14, 6); -- 6 unidades de Cooler Master MasterBox Q300L

