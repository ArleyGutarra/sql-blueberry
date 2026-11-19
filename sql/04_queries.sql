--  sigma

SELECT id_pedido, id_cliente, subtotal_productos
FROM pedido
WHERE estado_pedido = 'pago_pendiente' AND subtotal_productos > 1000;

-- pi

SELECT nombre, ubicacion
FROM establecimiento
WHERE tipo_establecimiento = 'tienda';

-- unión

SELECT nombre AS concepto_catalogo FROM marca
UNION
SELECT nombre AS concepto_catalogo FROM categoria;

-- intersección

SELECT id_cliente FROM cliente_direcciones
INTERSECT
SELECT id_cliente FROM carrito WHERE estado = 'activo';

-- diferencia

SELECT id_producto FROM producto
EXCEPT
SELECT id_producto FROM inventario WHERE stock > 0;

-- producto cartesiano

SELECT mp.nombre AS metodo_pago, est.ciudad
FROM metodos_pago mp
CROSS JOIN establecimiento est;

-- theta join

SELECT p1.nombre AS producto_caro, p1.precio AS precio_mayor,
       p2.nombre AS producto_barato, p2.precio AS precio_menor
FROM producto p1
JOIN producto p2 ON p1.precio > p2.precio AND p1.id_producto <> p2.id_producto;

-- left join

SELECT p.nombre AS producto, pe.nombre_especificacion, pe.valor
FROM producto p
LEFT JOIN producto_especificaciones pe ON p.id_producto = pe.id_producto;

-- right join

SELECT c.nombre AS categoria, p.nombre AS producto
FROM producto p
RIGHT JOIN categoria c ON p.id_categoria = c.id_categoria;

-- ejemplo

SELECT c.nombres AS nombres_cliente,
       c.apellidos AS apellidos_cliente,
       cd.direccion AS direccion_destino,
       est.nombre AS tienda_origen,
       e.estado_entrega
FROM entrega e
JOIN pedido p ON e.id_pedido = p.id_pedido
JOIN cliente c ON p.id_cliente = c.id_cliente
LEFT JOIN cliente_direcciones cd ON e.lugar_destino = cd.id_direccion_cliente
JOIN establecimiento est ON e.lugar_origen = est.id_establecimiento
WHERE e.estado_entrega = 'pendiente';

-- ejemplo

SELECT c.nombre AS categoria, SUM(ap.cantidad) AS total_unidades_vendidas
FROM categoria c
JOIN producto p ON c.id_categoria = p.id_categoria
JOIN articulos_pedido ap ON p.id_producto = ap.id_producto
GROUP BY c.nombre;

-- having

SELECT c.nombres || ' ' || c.apellidos AS cliente, COUNT(p.id_pedido) AS cantidad_pedidos
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombres, c.apellidos
HAVING COUNT(p.id_pedido) > 1;

-- sum

SELECT mp.nombre AS metodo_pago, SUM(p.subtotal_productos) AS total_recaudado
FROM metodos_pago mp
JOIN pago pg ON mp.id_metodo_pago = pg.id_metodo_pago
JOIN pedido p ON pg.id_pedido = p.id_pedido
WHERE pg.estado_pago = 'aprobado'
GROUP BY mp.nombre;

-- count

SELECT p.nombre AS producto, COUNT(ap.id_pedido) AS veces_vendido
FROM producto p
LEFT JOIN articulos_pedido ap ON p.id_producto = ap.id_producto
GROUP BY p.id_producto, p.nombre;

-- avg

SELECT e.tipo_establecimiento, AVG(i.stock) AS stock_promedio
FROM establecimiento e
JOIN inventario i ON e.id_establecimiento = i.id_establecimiento
GROUP BY e.tipo_establecimiento;
