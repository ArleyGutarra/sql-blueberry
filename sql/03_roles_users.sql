-- =====================================================================
--  SEGURIDAD DE LA BASE DE DATOS: ROLES, USUARIOS Y PERMISOS
--  Motor: PostgreSQL (probado en PostgreSQL 18)
--  Esquema: tablas en el esquema "public"
--
--  COMO USAR ESTE ARCHIVO
--    * Conectate a la base de datos blueberry_db con un usuario administrador
--      (por ejemplo "postgres"). Las tablas ya deben existir, caso contrario
--      utilizar el archivo 01_create_tables.sql del repositorio
--      https://github.com/ArleyGutarra/sql-blueberry.
--    * Ejecuta POR SECCIONES, en este orden: A, B,C y D
--      No ejecute todo de corrido: la seccion C revoca lo que
--      otorgo la B, y la D elimina lo que creo la A.
--    * La seccion D tiene dos partes: D.1 elimina un usuario de cada rol
--      (el otro sigue funcionando) y D.2 elimina el resto y los roles.
--      Ejecuta D.1 antes que D.2.
-- =====================================================================


-- =====================================================================
-- A) CREACION DE ROLES Y USUARIOS
-- =====================================================================
--
--  ROLES (grupos de permisos, sin login) Y SU TIPO DE ACCESO
--  ---------------------------------------------------------------------
--  rol_administrador : acceso TOTAL a todas las tablas (lectura,
--                      insercion, actualizacion, eliminacion) y permiso
--                      para crear bases de datos (CREATEDB).
--  rol_ventas        : atiende clientes y pedidos. Lee casi todo (sin
--                      password_hash), registra pedidos, pagos, entregas,
--                      reembolsos y carritos, y limpia carritos.
--  rol_almacen       : maneja el inventario. Lee catalogo, pedidos y
--                      entregas; agrega filas de inventario y actualiza stock.
--                      No ve clientes ni pagos.
--  rol_analista      : SOLO LECTURA para reportes. No ve password_hash,dni,
--                      datos de tarjeta y de de direccion solo ve departamento,
--                      provincia, distrito y código postal, no la dirección exacta.
--
--  USUARIOS (con login) Y ROL QUE TIENEN
--  ---------------------------------------------------------------------
--  carlos_admin   -> rol_administrador
--  diana_admin    -> rol_administrador
--  lucia_analista -> rol_analista
--  pedro_analista -> rol_analista
--  juan_ventas    -> rol_ventas
--  rosa_ventas    -> rol_ventas
--  maria_almacen  -> rol_almacen
--  jose_almacen   -> rol_almacen
--
--  PERMISOS POR TABLA (R=SELECT, I=INSERT, U=UPDATE, D=DELETE, -=sin acceso)
--  * = solo algunas columnas (ver detalle en la seccion B)
--  ---------------------------------------------------------------------
--  Tabla                     | administrador | ventas      | almacen   | analista
--  --------------------------+---------------+-------------+-----------+---------
--  cliente                   | R I U D       | R*          | -         | R*
--  direccion                 | R I U D       | R I         | R         | R*
--  cliente_direcciones       | R I U D       | R I         | -         | -
--  pedido                    | R I U D       | R I U*      | R* U*     | R
--  articulos_pedido          | R I U D       | R I         | R         | R
--  entrega                   | R I U D       | R I U*      | R U*      | R
--  pago                      | R I U D       | R I U*      | -         | R*
--  reembolso                 | R I U D       | R I U*      | -         | R
--  producto                  | R I U D       | R           | R         | R
--  producto_especificaciones | R I U D       | R           | R         | R
--  categoria                 | R I U D       | R           | R         | R
--  marca                     | R I U D       | R           | R         | R
--  metodos_pago              | R I U D       | R           | -         | R
--  establecimiento           | R I U D       | R           | R         | R
--  inventario                | R I U D       | R           | R I U*    | R
--  componentes_computadora   | R I U D       | R           | R         | R
--  carrito                   | R I U D       | R I U* D    | -         | R
--  articulos_carrito         | R I U D       | R I U* D    | -         | R
--  ---------------------------------------------------------------------

-- A.1) Roles (grupos de permisos). NOLOGIN: no pueden iniciar sesion.
CREATE ROLE rol_administrador NOLOGIN;
CREATE ROLE rol_ventas        NOLOGIN;
CREATE ROLE rol_almacen       NOLOGIN;
CREATE ROLE rol_analista      NOLOGIN;

-- A.2) Usuarios (con login), cada uno asociado a su rol con IN ROLE.
--      CREATEDB se da al usuario administrador directamente porque los
--      atributos de rol (CREATEDB, LOGIN...) NO se heredan por pertenencia
--      a un grupo; solo se heredan los privilegios sobre objetos.
CREATE USER carlos_admin   WITH PASSWORD 'Admin1#2026'   CREATEDB IN ROLE rol_administrador;
CREATE USER diana_admin    WITH PASSWORD 'Admin2#2026'   CREATEDB IN ROLE rol_administrador;
CREATE USER lucia_analista WITH PASSWORD 'Analista1#2026'         IN ROLE rol_analista;
CREATE USER pedro_analista WITH PASSWORD 'Analista2#2026'         IN ROLE rol_analista;
CREATE USER juan_ventas    WITH PASSWORD 'Ventas1#2026'           IN ROLE rol_ventas;
CREATE USER rosa_ventas    WITH PASSWORD 'Ventas2#2026'           IN ROLE rol_ventas;
CREATE USER maria_almacen  WITH PASSWORD 'Almacen1#2026'          IN ROLE rol_almacen;
CREATE USER jose_almacen   WITH PASSWORD 'Almacen2#2026'          IN ROLE rol_almacen;

-- A.3) Acceso al esquema donde estan las tablas (sin esto no ven nada).
GRANT USAGE ON SCHEMA public TO rol_administrador, rol_ventas, rol_almacen, rol_analista;


-- =====================================================================
-- B) OTORGAR PERMISOS (GRANT)
--    Los permisos se dan a los ROLES; los usuarios los heredan.
-- =====================================================================

-- ---------------------------------------------------------------------
-- B.1) SOLO LECTURA (SELECT)
-- ---------------------------------------------------------------------

-- rol_analista: solo lectura. En cliente y pago, solo columnas no sensibles.
GRANT SELECT (id_cliente, email, telefono, nombres, apellidos, fecha_nacimiento)
    ON cliente TO rol_analista;                          -- sin password_hash ni dni
GRANT SELECT (id_pago, id_pedido, fecha_pago, id_metodo_pago, estado_pago)
    ON pago TO rol_analista;                             -- sin codigo_transaccion ni tarjeta_last_digits
GRANT SELECT ON
    pedido, articulos_pedido, entrega, reembolso,
    producto, producto_especificaciones, categoria, marca, metodos_pago,
    establecimiento, inventario, componentes_computadora,
    carrito, articulos_carrito
    TO rol_analista;
GRANT SELECT (id_direccion, departamento, provincia, distrito, codigo_postal)
    ON direccion TO rol_analista;

-- rol_ventas: lectura de casi todo (sin password_hash y sin movimiento_inventario).
GRANT SELECT (id_cliente, email, telefono, dni, nombres, apellidos, fecha_nacimiento)
    ON cliente TO rol_ventas;                            -- sin password_hash
GRANT SELECT ON
    direccion, cliente_direcciones,
    pedido, articulos_pedido, entrega, pago, reembolso,
    producto, producto_especificaciones, categoria, marca, metodos_pago,
    establecimiento, inventario, componentes_computadora,
    carrito, articulos_carrito
    TO rol_ventas;

-- rol_almacen: lectura de catalogo, inventario y logistica.
GRANT SELECT (id_pedido, fecha_pedido, estado_pedido)
    ON pedido TO rol_almacen;                            -- solo lo necesario para despachar
GRANT SELECT ON
    producto, producto_especificaciones, categoria, marca,
    componentes_computadora, establecimiento, inventario,
    articulos_pedido, entrega, direccion
    TO rol_almacen;

-- ---------------------------------------------------------------------
-- B.2) INSERCION (INSERT)
-- ---------------------------------------------------------------------

-- rol_ventas: registra direcciones, pedidos, pagos, entregas, reembolsos y carritos.
GRANT INSERT ON
    direccion, cliente_direcciones, pedido, articulos_pedido,
    entrega, pago, reembolso, carrito, articulos_carrito
    TO rol_ventas;

-- rol_almacen: registra movimientos y filas de inventario.
GRANT INSERT ON inventario TO rol_almacen;

-- Para insertar en tablas con ids autoincrementales (SERIAL) se necesita
-- uso de las secuencias. Si tus ids son IDENTITY, esta linea no hace dano.
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO rol_ventas, rol_almacen;

-- ---------------------------------------------------------------------
-- B.3) ELIMINACION (DELETE)
-- ---------------------------------------------------------------------

-- rol_ventas: solo puede vaciar y borrar carritos (no pedidos ni pagos).
GRANT DELETE ON articulos_carrito, carrito TO rol_ventas;

-- ---------------------------------------------------------------------
-- B.4) ACTUALIZACION (UPDATE)
-- ---------------------------------------------------------------------

-- rol_ventas: solo columnas de gestion (no puede alterar ids ni montos de lineas).
GRANT UPDATE (estado_pedido, costo_envio, descuento)    ON pedido            TO rol_ventas;
GRANT UPDATE (tipo_entrega, fecha_entrega)              ON entrega           TO rol_ventas;
GRANT UPDATE (estado_pago)                              ON pago              TO rol_ventas;
GRANT UPDATE (estado_reembolso)                         ON reembolso         TO rol_ventas;
GRANT UPDATE (estado)                                   ON carrito           TO rol_ventas;
GRANT UPDATE (cantidad)                                 ON articulos_carrito TO rol_ventas;

-- rol_almacen: stock, estado del pedido y fecha de entrega.
GRANT UPDATE (stock)         ON inventario TO rol_almacen;
GRANT UPDATE (estado_pedido) ON pedido     TO rol_almacen;
GRANT UPDATE (fecha_entrega) ON entrega    TO rol_almacen;

-- ---------------------------------------------------------------------
-- B.5) CREACION DE BASE DE DATOS (CREATEDB)
-- ---------------------------------------------------------------------
-- Es un atributo del rol, no un privilegio sobre una tabla.
ALTER ROLE carlos_admin       CREATEDB;   -- los usuarios (los atributos no se heredan del grupo)
ALTER ROLE diana_admin        CREATEDB;
ALTER ROLE rol_administrador  CREATEDB;   -- el rol, para dejarlo documentado

-- ---------------------------------------------------------------------
-- B.6) ADMINISTRADOR: todos los privilegios sobre todas las tablas
-- ---------------------------------------------------------------------
GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA public TO rol_administrador;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO rol_administrador;


-- =====================================================================
-- E) VERIFICACION (opcional: ejecutar despues de B y de C)
-- =====================================================================

-- Usuarios, rol al que pertenecen y atributos
SELECT r.rolname AS usuario, g.rolname AS rol, r.rolcanlogin, r.rolcreatedb
FROM pg_auth_members m
JOIN pg_roles r ON r.oid = m.member
JOIN pg_roles g ON g.oid = m.roleid
WHERE g.rolname LIKE 'rol\_%'
ORDER BY g.rolname, r.rolname;

-- Permisos de tabla por rol (los permisos por columna, como los de cliente y
-- pago, no salen aqui: se ven en la consulta siguiente)
SELECT grantee, table_name, string_agg(privilege_type, ', ' ORDER BY privilege_type) AS permisos
FROM information_schema.role_table_grants
WHERE grantee LIKE 'rol\_%' AND table_schema = 'public'
GROUP BY grantee, table_name
ORDER BY grantee, table_name;

-- Permisos por columna (muestra las restricciones en cliente y pago)
SELECT grantee, table_name, column_name, privilege_type
FROM information_schema.column_privileges
WHERE grantee LIKE 'rol\_%' AND table_name IN ('cliente', 'pago')
ORDER BY grantee, table_name, column_name, privilege_type;

-- Prueba puntual: true = tiene el permiso, false = no lo tiene
SELECT has_table_privilege('juan_ventas',  'pedido',                'INSERT') AS ventas_inserta_pedido,
       has_table_privilege('juan_ventas',  'pedido',                'DELETE') AS ventas_borra_pedido,
       has_table_privilege('maria_almacen','movimiento_inventario', 'INSERT') AS almacen_inserta_mov,
       has_table_privilege('maria_almacen','cliente',               'SELECT') AS almacen_lee_cliente,
       has_table_privilege('lucia_analista','pedido',               'UPDATE') AS analista_actualiza_pedido;

-- =====================================================================
-- C) REVOCAR PERMISOS (REVOKE)
-- =====================================================================

-- ---------------------------------------------------------------------
-- C.1) Revocar LECTURA (SELECT)
-- ---------------------------------------------------------------------
REVOKE SELECT ON pago FROM rol_analista;
-- Revocacion completa de lectura para los tres roles operativos:
REVOKE SELECT ON ALL TABLES IN SCHEMA public FROM rol_ventas, rol_almacen, rol_analista;
-- ---------------------------------------------------------------------
-- C.2) Revocar INSERCION (INSERT)
-- ---------------------------------------------------------------------
REVOKE INSERT ON inventario FROM rol_almacen;
-- Revocacion completa:
REVOKE INSERT ON ALL TABLES IN SCHEMA public FROM rol_ventas, rol_almacen;
REVOKE USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public FROM rol_ventas, rol_almacen;

-- ---------------------------------------------------------------------
-- C.3) Revocar ELIMINACION (DELETE)
-- ---------------------------------------------------------------------
REVOKE DELETE ON carrito FROM rol_ventas;
-- Revocacion completa:
REVOKE DELETE ON ALL TABLES IN SCHEMA public FROM rol_ventas;

-- ---------------------------------------------------------------------
-- C.4) Revocar ACTUALIZACION (UPDATE)
-- ---------------------------------------------------------------------
REVOKE UPDATE ON inventario FROM rol_almacen;
-- Revocacion completa:
REVOKE UPDATE ON ALL TABLES IN SCHEMA public FROM rol_ventas, rol_almacen;

-- ---------------------------------------------------------------------
-- C.5) Revocar CREACION DE BASE DE DATOS (CREATEDB)
-- ---------------------------------------------------------------------
ALTER ROLE carlos_admin       NOCREATEDB;
ALTER ROLE diana_admin        NOCREATEDB;
ALTER ROLE rol_administrador  NOCREATEDB;

-- ---------------------------------------------------------------------
-- C.6) Revocar todos los privilegios del administrador
-- ---------------------------------------------------------------------
REVOKE ALL PRIVILEGES ON ALL TABLES    IN SCHEMA public FROM rol_administrador;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM rol_administrador;

-- C.7) Revocar la pertenencia de un usuario a su rol (ejemplo puntual).
--      El usuario sigue existiendo pero pierde todo lo que heredaba del rol.
REVOKE rol_ventas FROM juan_ventas;


-- =====================================================================
-- D) ELIMINACION DE USUARIOS Y ROLES
--    Orden: primero los usuarios, despues los roles. Antes de borrar un
--    rol hay que quitarle sus privilegios y reasignar lo que posea; si no,
--    PostgreSQL responde "role cannot be dropped because some objects
--    depend on it". DROP OWNED debe ejecutarse en cada base de datos
--    donde el rol tenga privilegios.
-- =====================================================================

-- D.1) Eliminar UN usuario de cada rol. Los otros usuarios de esos roles
--      siguen existiendo y conservan sus permisos.
REASSIGN OWNED BY diana_admin, pedro_analista, rosa_ventas, jose_almacen TO CURRENT_USER;
DROP OWNED BY diana_admin, pedro_analista, rosa_ventas, jose_almacen;
DROP ROLE IF EXISTS diana_admin, pedro_analista, rosa_ventas, jose_almacen;

-- Comprobacion: deben quedar carlos_admin, lucia_analista, juan_ventas y maria_almacen
SELECT g.rolname AS rol, string_agg(r.rolname, ', ' ORDER BY r.rolname) AS usuarios
FROM pg_roles g
LEFT JOIN pg_auth_members m ON m.roleid = g.oid
LEFT JOIN pg_roles r ON r.oid = m.member
WHERE g.rolname LIKE 'rol\_%'
GROUP BY g.rolname
ORDER BY g.rolname;

-- D.2) Eliminar los usuarios que quedan y despues los roles (grupos).
--      Ejecutar despues de D.1.
REASSIGN OWNED BY carlos_admin, lucia_analista, juan_ventas, maria_almacen TO CURRENT_USER;
DROP OWNED BY carlos_admin, lucia_analista, juan_ventas, maria_almacen;
DROP ROLE IF EXISTS carlos_admin, lucia_analista, juan_ventas, maria_almacen;

REASSIGN OWNED BY rol_administrador, rol_ventas, rol_almacen, rol_analista TO CURRENT_USER;
DROP OWNED BY rol_administrador, rol_ventas, rol_almacen, rol_analista;
DROP ROLE IF EXISTS rol_administrador, rol_ventas, rol_almacen, rol_analista;
