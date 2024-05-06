
CREATE TABLE persona(
    id int NOT null auto_increment,
    primer_nombre varchar(50) not null,
	segundo_nombre varchar(50),
	primer_apellido varchar(50) not null,
	segundo_apellido varchar(50),
    nro_ci varchar(15) not null unique,
    telefono varchar(15),
	email varchar(150),
    PRIMARY KEY(id)
)engine=innodb;

CREATE TABLE rol(
    id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    PRIMARY KEY(id)
)engine = innodb;

CREATE TABLE sucursal(
    id INT NOT NULL auto_increment,
    nombre VARCHAR(50) NOT NULL,
	telefono VARCHAR(15),
    direccion VARCHAR(250) NOT NULL,
    PRIMARY KEY(id)
)engine = innodb;
/*---------------modificaciones---------------*/
CREATE TABLE cliente (
    id INT NOT NULL auto_increment,
    estado_suscripcion char(1) check(estado_suscripcion='A' OR estado_suscripcion = 'I'),
	PRIMARY KEY(id)
) ENGINE=InnoDB;

CREATE TABLE cliente_persona (
    id INT NOT NULL PRIMARY KEY,
	id_persona int not null,
    FOREIGN KEY (id_persona) REFERENCES persona(id),
    FOREIGN KEY (id) REFERENCES cliente(id)
) ENGINE=InnoDB;

CREATE TABLE cliente_empresa (
    id INT NOT NULL PRIMARY KEY,
    nit VARCHAR(15) not null unique,
	razon_social VARCHAR(50) not null,
    FOREIGN KEY (id) REFERENCES cliente(id)
) ENGINE=InnoDB;
/*---------------------------*/
CREATE TABLE personal (
    id INT NOT NULL PRIMARY KEY,
    estado char(1) not null check(estado='A' OR estado = 'I'),
	id_sucursal int not null,
	FOREIGN KEY (id_sucursal) REFERENCES sucursal(id),
    FOREIGN KEY (id) REFERENCES persona(id)
) ENGINE=InnoDB;

CREATE TABLE usuario(
    id int NOT null auto_increment,
    usuario varchar(50) not null UNIQUE,
    contrasena varchar(130) not null,
    estado char(1) not null check(estado='A' OR estado = 'I'),
    id_personal int not null,
    id_rol int not null,
    foreign key (id_personal) references personal(id),
    foreign key (id_rol) references rol(id),
    PRIMARY KEY(id)
)engine = innodb;

CREATE TABLE encargado (
    id INT NOT NULL PRIMARY KEY,
	suelda NUMERIC(10, 2) not null,	
	observacion VARCHAR(250),
    FOREIGN KEY (id) REFERENCES personal(id)
) ENGINE=InnoDB;

CREATE TABLE limpieza (
    id INT NOT NULL PRIMARY KEY,
	observacion VARCHAR(250),
    FOREIGN KEY (id) REFERENCES personal(id)
) ENGINE=InnoDB;

CREATE TABLE caja (
    id INT NOT NULL auto_increment,
	sigla_caja VARCHAR(10),
	estado char(1) not null check(estado='A' OR estado = 'I'),
	id_sucursal INT NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id),
	PRIMARY KEY(id)
) ENGINE=InnoDB;

CREATE TABLE caja_apertura (
    id INT NOT NULL auto_increment,
	monto_apertura NUMERIC(10, 2) not null,
	estado char(1) not null check(estado='A' OR estado = 'I'),
	fecha_apertura DATETIME not null,
	id_caja INT NOT NULL,
    FOREIGN KEY (id_caja) REFERENCES caja(id),
	PRIMARY KEY(id)
) ENGINE=InnoDB;

CREATE TABLE caja_cierre (
    id INT NOT NULL auto_increment,
	monto_cierre NUMERIC(10, 2) not null,
	fecha_cierre DATETIME not null,
	monto_cierre_sistema NUMERIC(10, 2) not null,
	observacion VARCHAR(250),
	id_caja_apertura INT NOT NULL,
    FOREIGN KEY (id_caja_apertura) REFERENCES caja_apertura(id),
	PRIMARY KEY(id)
) ENGINE=InnoDB;

CREATE TABLE servicio(
    id INT NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    detalle VARCHAR(250) NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
	estado char(1) not null check(estado='A' OR estado = 'I'),
    PRIMARY KEY (id)
)engine=innodb;

CREATE TABLE suscripcion(
    id INT NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    detalle VARCHAR(250) NOT NULL,
    descuento INT NOT NULL,
	estado char(1) not null check(estado='A' OR estado = 'I'),
    PRIMARY KEY (id)
)engine=innodb;

CREATE TABLE tipo_vehiculo(
    id INT NOT NULL auto_increment,
    nombre VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
)engine=innodb;

CREATE TABLE marca(
    id INT NOT NULL auto_increment,
    nombre VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
)engine=innodb;

CREATE TABLE vehiculo(
    id INT NOT NULL auto_increment,
    placa VARCHAR(10) NOT NULL UNIQUE,
    id_tipo_vehiculo INT NOT NULL,
    id_marca INT NOT NULL,
    id_cliente INT NOT NULL,
    foreign key (id_tipo_vehiculo) references tipo_vehiculo(id),
    foreign key (id_marca) references marca(id),
    foreign key (id_cliente) references cliente(id),
    PRIMARY KEY (id)
)engine = innodb;

CREATE TABLE venta_servicio(
    id INT NOT NULL auto_increment,
    estado char(1) NOT NULL check(estado='E' OR estado = 'P'  OR estado = 'T' OR estado = 'A'),
    observacion VARCHAR(250) NOT NULL,
    monto_total NUMERIC(10,2) NOT NULL,
    fecha_registro DATETIME NOT NULL,
    id_vehiculo INT NOT NULL,
    id_servicio INT NOT NULL,
    foreign key (id_vehiculo) references vehiculo(id),
    foreign key (id_servicio) references servicio(id),
    PRIMARY KEY (id)
)engine = innodb;

CREATE TABLE suscripcion_servicio(
    id_suscripcion INT NOT NULL,
    id_servicio INT NOT NULL,
    foreign key (id_suscripcion) references suscripcion(id),
    foreign key (id_servicio) references servicio(id),
	PRIMARY KEY(id_suscripcion, id_servicio)
)engine = innodb;

CREATE TABLE encuesta(
    id INT NOT NULL auto_increment,
    puntuacion INT NOT NULL,
    observacion VARCHAR(250),
    id_venta_servicio INT NOT NULL,
    foreign key (id_venta_servicio) references venta_servicio(id),
    PRIMARY KEY (id)
)engine = innodb;

CREATE TABLE precio_tipo_vehiculo(
    id INT NOT NULL auto_increment,
    precio NUMERIC(10,2) NOT NULL,
    id_tipo_vehiculo INT NOT NULL,
    foreign key (id_tipo_vehiculo) references tipo_vehiculo(id),
    PRIMARY KEY (id)
)engine = innodb;

CREATE TABLE servicio_limpieza(
    id_limpieza INT NOT NULL,
    id_venta_servicio INT NOT NULL,
    foreign key (id_limpieza) references limpieza(id),
    foreign key (id_venta_servicio) references venta_servicio(id),
	PRIMARY KEY(id_limpieza, id_venta_servicio)
)engine = innodb;

CREATE TABLE pago_venta_servicio(
    id INT NOT NULL auto_increment,
    monto NUMERIC(10,2) NOT NULL,
	fecha_registro DATETIME not null,
    id_venta_servicio INT NOT NULL,
    id_caja_apertura INT NOT NULL,
    foreign key (id_venta_servicio) references venta_servicio(id),
    foreign key (id_caja_apertura) references caja_apertura(id),
    PRIMARY KEY (id)
)engine = innodb;

CREATE TABLE venta_suscripcion(
    id INT NOT NULL auto_increment,
    fecha_registro DATETIME NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado char(1) NOT NULL check(estado = 'I' OR estado = 'A'),
    id_suscripcion INT NOT NULL,
    id_cliente INT NOT NULL,
    foreign key (id_suscripcion) references suscripcion(id),
    foreign key (id_cliente) references cliente(id),
    PRIMARY KEY (id)
)engine = innodb;

CREATE TABLE pago_venta_suscripcion(
    id INT NOT NULL auto_increment,
    monto NUMERIC(10,2) NOT NULL,
	fecha_registro DATETIME not null,
    id_venta_suscripcion INT NOT NULL,
    id_caja_apertura INT NOT NULL,
    foreign key (id_venta_suscripcion) references venta_suscripcion(id),
    foreign key (id_caja_apertura) references caja_apertura(id),
    PRIMARY KEY (id)
)engine = innodb;

-- 
CREATE TABLE pago_personal(
    id INT NOT NULL auto_increment,
    monto NUMERIC(10,2) NOT NULL,
	fecha_registro DATETIME not null,
    id_caja_apertura INT NOT NULL,
    id_personal INT NOT NULL,
    foreign key (id_caja_apertura) references caja_apertura(id),
    foreign key (id_personal) references personal(id),
    PRIMARY KEY (id)
)engine = innodb;

