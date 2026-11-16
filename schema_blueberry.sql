--
-- PostgreSQL database dump
--

\restrict idRJPE74r2pUYB5mrXY46W2avXEepalkGwcSkeloufNRvZaoFWiq87wc316ES8e

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: articulos_carrito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.articulos_carrito (
    id_carrito integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    CONSTRAINT ck_articulos_carrito_cantidad CHECK ((cantidad > 0))
);


ALTER TABLE public.articulos_carrito OWNER TO postgres;

--
-- Name: articulos_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.articulos_pedido (
    id_pedido integer NOT NULL,
    id_producto integer NOT NULL,
    id_establecimiento integer NOT NULL,
    cantidad integer NOT NULL,
    precio_unit numeric(10,2) NOT NULL,
    CONSTRAINT ck_art_pedido_cantidad CHECK ((cantidad > 0)),
    CONSTRAINT ck_art_pedido_precio CHECK ((precio_unit >= (0)::numeric))
);


ALTER TABLE public.articulos_pedido OWNER TO postgres;

--
-- Name: carrito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carrito (
    id_carrito integer NOT NULL,
    id_cliente integer NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    estado character varying(50) NOT NULL,
    CONSTRAINT ck_carrito_estado CHECK (((estado)::text = ANY ((ARRAY['activo'::character varying, 'abandonado'::character varying, 'completado'::character varying])::text[])))
);


ALTER TABLE public.carrito OWNER TO postgres;

--
-- Name: carrito_id_carrito_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carrito_id_carrito_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carrito_id_carrito_seq OWNER TO postgres;

--
-- Name: carrito_id_carrito_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carrito_id_carrito_seq OWNED BY public.carrito.id_carrito;


--
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    super_categoria integer,
    nombre character varying(100) NOT NULL,
    descripcion text
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_id_categoria_seq OWNER TO postgres;

--
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id_cliente integer NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    telefono character varying(15) NOT NULL,
    dni character varying(20) NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    CONSTRAINT ck_cliente_dni CHECK (((dni)::text ~ '^[0-9]{8}$'::text)),
    CONSTRAINT ck_cliente_email CHECK (((email)::text ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'::text)),
    CONSTRAINT ck_cliente_telefono CHECK (((telefono)::text ~ '^[0-9]{9}$'::text))
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: cliente_direcciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente_direcciones (
    id_direccion_cliente integer NOT NULL,
    id_cliente integer NOT NULL,
    departamento character varying(100) NOT NULL,
    provincia character varying(100) NOT NULL,
    distrito character varying(100) NOT NULL,
    direccion character varying(255) NOT NULL,
    referencia character varying(255)
);


ALTER TABLE public.cliente_direcciones OWNER TO postgres;

--
-- Name: cliente_direcciones_id_direccion_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_direcciones_id_direccion_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_direcciones_id_direccion_cliente_seq OWNER TO postgres;

--
-- Name: cliente_direcciones_id_direccion_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_direcciones_id_direccion_cliente_seq OWNED BY public.cliente_direcciones.id_direccion_cliente;


--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_id_cliente_seq OWNER TO postgres;

--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_cliente_seq OWNED BY public.cliente.id_cliente;


--
-- Name: componentes_computadora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.componentes_computadora (
    id_computadora integer NOT NULL,
    id_componente integer NOT NULL,
    cantidad integer DEFAULT 1 NOT NULL,
    CONSTRAINT ck_comp_cantidad CHECK ((cantidad > 0))
);


ALTER TABLE public.componentes_computadora OWNER TO postgres;

--
-- Name: entrega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrega (
    id_entrega integer NOT NULL,
    id_pedido integer NOT NULL,
    tipo_entrega character varying(50) NOT NULL,
    estado_entrega character varying(50) NOT NULL,
    fecha_entrega timestamp without time zone,
    lugar_origen integer NOT NULL,
    lugar_destino integer,
    CONSTRAINT ck_entrega_estado CHECK (((estado_entrega)::text = ANY ((ARRAY['pendiente'::character varying, 'en_preparacion'::character varying, 'en_transito'::character varying, 'listo_para_recojo'::character varying, 'entregado'::character varying, 'cancelado'::character varying])::text[]))),
    CONSTRAINT ck_entrega_tipo CHECK (((((tipo_entrega)::text = 'domicilio'::text) AND (lugar_destino IS NOT NULL)) OR (((tipo_entrega)::text = 'recojo_tienda'::text) AND (lugar_destino IS NULL))))
);


ALTER TABLE public.entrega OWNER TO postgres;

--
-- Name: entrega_id_entrega_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entrega_id_entrega_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entrega_id_entrega_seq OWNER TO postgres;

--
-- Name: entrega_id_entrega_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entrega_id_entrega_seq OWNED BY public.entrega.id_entrega;


--
-- Name: establecimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.establecimiento (
    id_establecimiento integer NOT NULL,
    tipo_establecimiento character varying(50) NOT NULL,
    nombre character varying(100) NOT NULL,
    ciudad character varying(100) NOT NULL,
    ubicacion character varying(255) NOT NULL,
    CONSTRAINT ck_establecimiento_tipo CHECK (((tipo_establecimiento)::text = ANY ((ARRAY['tienda'::character varying, 'almacen'::character varying])::text[])))
);


ALTER TABLE public.establecimiento OWNER TO postgres;

--
-- Name: establecimiento_id_establecimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.establecimiento_id_establecimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.establecimiento_id_establecimiento_seq OWNER TO postgres;

--
-- Name: establecimiento_id_establecimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.establecimiento_id_establecimiento_seq OWNED BY public.establecimiento.id_establecimiento;


--
-- Name: inventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventario (
    id_establecimiento integer NOT NULL,
    id_producto integer NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    CONSTRAINT ck_inventario_stock CHECK ((stock >= 0))
);


ALTER TABLE public.inventario OWNER TO postgres;

--
-- Name: marca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca (
    id_marca integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text
);


ALTER TABLE public.marca OWNER TO postgres;

--
-- Name: marca_id_marca_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marca_id_marca_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.marca_id_marca_seq OWNER TO postgres;

--
-- Name: marca_id_marca_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.marca_id_marca_seq OWNED BY public.marca.id_marca;


--
-- Name: metodos_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.metodos_pago (
    id_metodo_pago integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text
);


ALTER TABLE public.metodos_pago OWNER TO postgres;

--
-- Name: metodos_pago_id_metodo_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.metodos_pago_id_metodo_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metodos_pago_id_metodo_pago_seq OWNER TO postgres;

--
-- Name: metodos_pago_id_metodo_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.metodos_pago_id_metodo_pago_seq OWNED BY public.metodos_pago.id_metodo_pago;


--
-- Name: pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pago (
    id_pago integer NOT NULL,
    id_pedido integer NOT NULL,
    fecha_pago timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_metodo_pago integer NOT NULL,
    codigo_transaccion character varying(100),
    tarjeta_last_digits character varying(4),
    estado_pago character varying(50) NOT NULL,
    CONSTRAINT ck_pago_estado CHECK (((estado_pago)::text = ANY ((ARRAY['pendiente'::character varying, 'aprobado'::character varying, 'rechazado'::character varying, 'reembolsado'::character varying])::text[]))),
    CONSTRAINT ck_pago_tarjeta CHECK (((tarjeta_last_digits)::text ~ '^[0-9]{4}$'::text))
);


ALTER TABLE public.pago OWNER TO postgres;

--
-- Name: pago_id_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pago_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pago_id_pago_seq OWNER TO postgres;

--
-- Name: pago_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pago_id_pago_seq OWNED BY public.pago.id_pago;


--
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido (
    id_pedido integer NOT NULL,
    id_cliente integer NOT NULL,
    fecha_pedido timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    estado_pedido character varying(50) NOT NULL,
    subtotal_productos numeric(10,2) NOT NULL,
    costo_envio numeric(10,2) NOT NULL,
    descuento numeric(5,2) DEFAULT 0,
    CONSTRAINT ck_descuento CHECK (((descuento >= (0)::numeric) AND (descuento <= (100)::numeric))),
    CONSTRAINT ck_pedido_estado CHECK (((estado_pedido)::text = ANY ((ARRAY['pago_pendiente'::character varying, 'pagado'::character varying, 'en_preparacion'::character varying, 'entregado'::character varying, 'cancelado'::character varying])::text[])))
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- Name: pedido_id_pedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedido_id_pedido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedido_id_pedido_seq OWNER TO postgres;

--
-- Name: pedido_id_pedido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedido_id_pedido_seq OWNED BY public.pedido.id_pedido;


--
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    id_producto integer NOT NULL,
    nombre character varying(150) NOT NULL,
    descripcion text,
    id_categoria integer NOT NULL,
    id_marca integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    peso numeric(8,2),
    CONSTRAINT ck_producto_peso CHECK ((peso >= (0)::numeric)),
    CONSTRAINT ck_producto_precio CHECK ((precio >= (0)::numeric))
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- Name: producto_especificaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto_especificaciones (
    id_producto integer NOT NULL,
    nombre_especificacion character varying(100) NOT NULL,
    valor character varying(255) NOT NULL
);


ALTER TABLE public.producto_especificaciones OWNER TO postgres;

--
-- Name: producto_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producto_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producto_id_producto_seq OWNER TO postgres;

--
-- Name: producto_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producto_id_producto_seq OWNED BY public.producto.id_producto;


--
-- Name: reembolso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reembolso (
    id_reembolso integer NOT NULL,
    id_pago integer NOT NULL,
    fecha_reembolso timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    monto numeric(10,2) NOT NULL,
    motivo text,
    estado_reembolso character varying(50) NOT NULL,
    CONSTRAINT ck_reembolso_estado CHECK (((estado_reembolso)::text = ANY ((ARRAY['solicitado'::character varying, 'en_proceso'::character varying, 'completado'::character varying, 'rechazado'::character varying])::text[]))),
    CONSTRAINT ck_reembolso_monto CHECK ((monto >= (0)::numeric))
);


ALTER TABLE public.reembolso OWNER TO postgres;

--
-- Name: reembolso_id_reembolso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reembolso_id_reembolso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reembolso_id_reembolso_seq OWNER TO postgres;

--
-- Name: reembolso_id_reembolso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reembolso_id_reembolso_seq OWNED BY public.reembolso.id_reembolso;


--
-- Name: carrito id_carrito; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrito ALTER COLUMN id_carrito SET DEFAULT nextval('public.carrito_id_carrito_seq'::regclass);


--
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- Name: cliente id_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id_cliente SET DEFAULT nextval('public.cliente_id_cliente_seq'::regclass);


--
-- Name: cliente_direcciones id_direccion_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_direcciones ALTER COLUMN id_direccion_cliente SET DEFAULT nextval('public.cliente_direcciones_id_direccion_cliente_seq'::regclass);


--
-- Name: entrega id_entrega; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega ALTER COLUMN id_entrega SET DEFAULT nextval('public.entrega_id_entrega_seq'::regclass);


--
-- Name: establecimiento id_establecimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.establecimiento ALTER COLUMN id_establecimiento SET DEFAULT nextval('public.establecimiento_id_establecimiento_seq'::regclass);


--
-- Name: marca id_marca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca ALTER COLUMN id_marca SET DEFAULT nextval('public.marca_id_marca_seq'::regclass);


--
-- Name: metodos_pago id_metodo_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pago ALTER COLUMN id_metodo_pago SET DEFAULT nextval('public.metodos_pago_id_metodo_pago_seq'::regclass);


--
-- Name: pago id_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago ALTER COLUMN id_pago SET DEFAULT nextval('public.pago_id_pago_seq'::regclass);


--
-- Name: pedido id_pedido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido ALTER COLUMN id_pedido SET DEFAULT nextval('public.pedido_id_pedido_seq'::regclass);


--
-- Name: producto id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto ALTER COLUMN id_producto SET DEFAULT nextval('public.producto_id_producto_seq'::regclass);


--
-- Name: reembolso id_reembolso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reembolso ALTER COLUMN id_reembolso SET DEFAULT nextval('public.reembolso_id_reembolso_seq'::regclass);


--
-- Name: establecimiento establecimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.establecimiento
    ADD CONSTRAINT establecimiento_pkey PRIMARY KEY (id_establecimiento);


--
-- Name: articulos_carrito pk_articulos_carrito; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articulos_carrito
    ADD CONSTRAINT pk_articulos_carrito PRIMARY KEY (id_carrito, id_producto);


--
-- Name: articulos_pedido pk_articulos_pedido; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articulos_pedido
    ADD CONSTRAINT pk_articulos_pedido PRIMARY KEY (id_pedido, id_producto, id_establecimiento);


--
-- Name: carrito pk_carrito; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrito
    ADD CONSTRAINT pk_carrito PRIMARY KEY (id_carrito);


--
-- Name: categoria pk_categoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT pk_categoria PRIMARY KEY (id_categoria);


--
-- Name: cliente pk_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cliente PRIMARY KEY (id_cliente);


--
-- Name: cliente_direcciones pk_cliente_direcciones; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_direcciones
    ADD CONSTRAINT pk_cliente_direcciones PRIMARY KEY (id_direccion_cliente);


--
-- Name: componentes_computadora pk_componentes_computadora; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.componentes_computadora
    ADD CONSTRAINT pk_componentes_computadora PRIMARY KEY (id_computadora, id_componente);


--
-- Name: entrega pk_entrega; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT pk_entrega PRIMARY KEY (id_entrega);


--
-- Name: inventario pk_inventario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT pk_inventario PRIMARY KEY (id_establecimiento, id_producto);


--
-- Name: marca pk_marca; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca
    ADD CONSTRAINT pk_marca PRIMARY KEY (id_marca);


--
-- Name: metodos_pago pk_metodos_pago; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pago
    ADD CONSTRAINT pk_metodos_pago PRIMARY KEY (id_metodo_pago);


--
-- Name: pago pk_pago; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pk_pago PRIMARY KEY (id_pago);


--
-- Name: pedido pk_pedido; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pk_pedido PRIMARY KEY (id_pedido);


--
-- Name: producto pk_producto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT pk_producto PRIMARY KEY (id_producto);


--
-- Name: producto_especificaciones pk_producto_especificaciones; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_especificaciones
    ADD CONSTRAINT pk_producto_especificaciones PRIMARY KEY (id_producto, nombre_especificacion);


--
-- Name: reembolso pk_reembolso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reembolso
    ADD CONSTRAINT pk_reembolso PRIMARY KEY (id_reembolso);


--
-- Name: cliente uq_cliente_dni; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT uq_cliente_dni UNIQUE (dni);


--
-- Name: cliente uq_cliente_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT uq_cliente_email UNIQUE (email);


--
-- Name: marca uq_marca_nombre; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca
    ADD CONSTRAINT uq_marca_nombre UNIQUE (nombre);


--
-- Name: metodos_pago uq_metodos_pago_nombre; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pago
    ADD CONSTRAINT uq_metodos_pago_nombre UNIQUE (nombre);


--
-- Name: pago uq_pago_transaccion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT uq_pago_transaccion UNIQUE (codigo_transaccion);


--
-- Name: articulos_carrito fk_articulos_carrito__carrito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articulos_carrito
    ADD CONSTRAINT fk_articulos_carrito__carrito FOREIGN KEY (id_carrito) REFERENCES public.carrito(id_carrito);


--
-- Name: articulos_carrito fk_articulos_carrito__producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articulos_carrito
    ADD CONSTRAINT fk_articulos_carrito__producto FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);


--
-- Name: articulos_pedido fk_articulos_pedido__inventario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articulos_pedido
    ADD CONSTRAINT fk_articulos_pedido__inventario FOREIGN KEY (id_establecimiento, id_producto) REFERENCES public.inventario(id_establecimiento, id_producto);


--
-- Name: articulos_pedido fk_articulos_pedido__pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articulos_pedido
    ADD CONSTRAINT fk_articulos_pedido__pedido FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- Name: articulos_pedido fk_articulos_pedido__producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articulos_pedido
    ADD CONSTRAINT fk_articulos_pedido__producto FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);


--
-- Name: carrito fk_carrito__cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrito
    ADD CONSTRAINT fk_carrito__cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- Name: categoria fk_categoria__super_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_categoria__super_categoria FOREIGN KEY (super_categoria) REFERENCES public.categoria(id_categoria);


--
-- Name: cliente_direcciones fk_cliente_direcciones__cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_direcciones
    ADD CONSTRAINT fk_cliente_direcciones__cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- Name: componentes_computadora fk_comp_componente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.componentes_computadora
    ADD CONSTRAINT fk_comp_componente FOREIGN KEY (id_componente) REFERENCES public.producto(id_producto);


--
-- Name: componentes_computadora fk_comp_computadora; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.componentes_computadora
    ADD CONSTRAINT fk_comp_computadora FOREIGN KEY (id_computadora) REFERENCES public.producto(id_producto);


--
-- Name: entrega fk_entrega__destino; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT fk_entrega__destino FOREIGN KEY (lugar_destino) REFERENCES public.cliente_direcciones(id_direccion_cliente);


--
-- Name: entrega fk_entrega__origen; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT fk_entrega__origen FOREIGN KEY (lugar_origen) REFERENCES public.establecimiento(id_establecimiento);


--
-- Name: entrega fk_entrega__pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT fk_entrega__pedido FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- Name: inventario fk_inventario__establecimiento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT fk_inventario__establecimiento FOREIGN KEY (id_establecimiento) REFERENCES public.establecimiento(id_establecimiento);


--
-- Name: inventario fk_inventario__producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT fk_inventario__producto FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);


--
-- Name: pago fk_pago__metodo_pago; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT fk_pago__metodo_pago FOREIGN KEY (id_metodo_pago) REFERENCES public.metodos_pago(id_metodo_pago);


--
-- Name: pago fk_pago__pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT fk_pago__pedido FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- Name: pedido fk_pedido__cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido__cliente FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- Name: producto fk_producto__categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto__categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);


--
-- Name: producto fk_producto__marca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto__marca FOREIGN KEY (id_marca) REFERENCES public.marca(id_marca);


--
-- Name: producto_especificaciones fk_producto_espec_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_especificaciones
    ADD CONSTRAINT fk_producto_espec_producto FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);


--
-- Name: reembolso fk_reembolso__pago; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reembolso
    ADD CONSTRAINT fk_reembolso__pago FOREIGN KEY (id_pago) REFERENCES public.pago(id_pago);


--
-- PostgreSQL database dump complete
--

\unrestrict idRJPE74r2pUYB5mrXY46W2avXEepalkGwcSkeloufNRvZaoFWiq87wc316ES8e

