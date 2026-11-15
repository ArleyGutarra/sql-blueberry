-- CATEGORIAS
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

-- MARCA
INSERT INTO marca (nombre, descripcion)
VALUES
    ('ASUS', NULL),
    ('MSI', NULL),
    ('Gigabyte', NULL),
    ('ASRock', NULL),
    ('Intel', NULL),
    ('AMD', NULL),
    ('NVIDIA', NULL),
    ('Corsair', NULL),
    ('Kingston', NULL),
    ('Crucial', NULL),
    ('Samsung', NULL),
    ('Western Digital', NULL),
    ('Seagate', NULL),
    ('ADATA', NULL),
    ('TeamGroup', NULL),
    ('Cooler Master', NULL),
    ('NZXT', NULL),
    ('Thermaltake', NULL),
    ('Logitech', NULL),
    ('Razer', NULL),
    ('HyperX', NULL),
    ('HP', NULL),
    ('Dell', NULL),
    ('Lenovo', NULL),
    ('Acer', NULL),
    ('Apple', NULL),
    ('LG', NULL),
    ('ViewSonic', NULL),
    ('BenQ', NULL),
    ('Sony', NULL),
    ('Samsung', NULL),
    ('Xiaomi', NULL),
    ('Motorola', NULL),
    ('JBL', NULL),
    ('Epson', NULL),
    ('Brother', NULL),
    ('TP-Link', NULL),
    ('Ubiquiti', NULL),
    ('Anker', NULL),
    ('Western Digital', NULL);


-- METODOS DE PAGO
INSERT INTO metodos_pago (nombre, descripcion)
VALUES
    ('Tarjeta de crédito', NULL),
    ('Tarjeta de débito', NULL),
    ('Transferencia bancaria', NULL),
    ('Yape', 'Billetera digital peruana.'),
    ('Plin', 'Billetera digital peruana.'),
    ('Pago en efectivo', NULL),
    ('Pago contra entrega', NULL);

-- CLIENTES
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

--  DIRECCIONES
INSERT INTO cliente_direcciones (id_cliente, departamento, provincia, distrito, direccion, referencia)
VALUES
    -- Cliente 1
    (1, 'Lima', 'Lima', 'San Miguel', 'Av. La Marina 1234', 'Cerca de Plaza San Miguel'),

    -- Cliente 2
    (2, 'Lima', 'Lima', 'Miraflores', 'Av. Larco 456', 'A dos cuadras del parque Kennedy'),
    (2, 'Lima', 'Lima', 'Surco', 'Jr. Monte Rosa 789', 'Cerca del centro comercial'),

    -- Cliente 5
    (5, 'La Libertad', 'Trujillo', 'Trujillo', 'Jr. Pizarro 234', NULL),
    (5, 'La Libertad', 'Trujillo', 'Víctor Larco Herrera', 'Av. Larco 567', 'Cerca de la universidad'),

    -- Cliente 6
    (6, 'Lima', 'Lima', 'San Borja', 'Av. San Luis 876', NULL),

    -- Cliente 7
    (7, 'Cusco', 'Cusco', 'Wanchaq', 'Av. La Cultura 432', NULL),

    -- Cliente 9
    (9, 'Piura', 'Piura', 'Piura', 'Av. Grau 123', NULL),

    -- Cliente 10
    (10, 'Lima', 'Lima', 'La Molina', 'Av. Javier Prado 456', 'Cerca de la universidad'),

    -- Cliente 11
    (11, 'Lima', 'Lima', 'Comas', 'Av. Universitaria 789', NULL),
    (11, 'Lima', 'Lima', 'Independencia', 'Av. Túpac Amaru 321', NULL),

    -- Cliente 12
    (12, 'Junín', 'Huancayo', 'Huancayo', 'Jr. Real 654', NULL),

    -- Cliente 14
    (14, 'Lima', 'Lima', 'Ate', 'Av. Separadora Industrial 159', NULL),

    -- Cliente 15
    (15, 'Lima', 'Lima', 'Barranco', 'Jr. Domeyer 753', NULL),
    (15, 'Lima', 'Lima', 'Chorrillos', 'Av. Huaylas 852', 'Cerca del malecón');


-- PRODUCTOS
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

-- COMPONENTES DE COMPUTADORA
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

    -- ESPECIFICACIONES DE PRODUCTOS
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