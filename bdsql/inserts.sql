-- datos para persona
INSERT INTO persona (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, nro_ci, telefono, email) VALUES
('Juan', 'Carlos', 'Pérez', 'García', '123477789', '1234567890', 'juan.perez@example.com'),
('María', 'Isabel', 'González', 'Martínez', '987224321', '0987654321', 'maria.gonzalez@example.com'),
('Pedro', NULL, 'Rodríguez', 'López', '456711123', '4567891230', 'pedro.rodriguez@example.com'),
('Ana', 'María', 'Martínez', 'Sánchez', '789123886', '7891234560', 'ana.martinez@example.com'),
('Carlos', 'Alberto', 'Gómez', 'Fernández', '654344987', '6541119870', 'carlos.gomez@example.com'),
('Laura', NULL, 'Díaz', 'Pérez', '321337654', '3219871000', 'laura.diaz@example.com'),
('Javier', 'Andrés', 'Hernández', 'García', '985554321', '9876003210', 'javier.hernandez@example.com'),
('Sofía', 'Alejandra', 'Pérez', 'Gómez', '654399987', '6543233870', 'sofia.perez@example.com'),
('Diego', NULL, 'García', 'Martínez', '311987654', '3999876540', 'diego.garcia@example.com'),
('Carmen', 'Luisa', 'Fernández', 'Díaz', '980054321', '9876549910', 'carmen.fernandez@example.com'),
('Pablo', NULL, 'Martínez', 'Gómez', '654327887', '6543255870', 'pablo.martinez@example.com'),
('Elena', 'María', 'Gómez', 'Fernández', '321111654', '3219876770', 'elena.gomez@example.com'),
('Luis', NULL, 'Fernández', 'Martínez', '984454321', '9833543210', 'luis.fernandez@example.com'),
('Andrea', 'Carolina', 'Martínez', 'Gómez', '659921987', '6543219870', 'andrea.martinez@example.com'),
('José', NULL, 'Gómez', 'Fernández', '321776547', '3219876540', 'jose.gomez@example.com');

-- datos para ROLES
INSERT INTO rol (id, nombre, descripcion) VALUES
(1, 'administrador', 'Rol con permisos de administración.'),
(2, 'encargado', 'Rol con permisos de gestión de tareas.');

-- datos para sucursales
INSERT INTO sucursal (nombre, telefono, direccion) 
VALUES 
('Sucursal_1', '123456789', 'Dirección_1'),
('Sucursal_2', '987654321', 'Dirección_2');

-- datos personal
INSERT INTO personal (id, estado, id_sucursal) VALUES
(1, 'A', 1),
(2, 'A', 1),
(3, 'A', 1),
(4, 'A', 1),
(5, 'A', 1),

(6, 'A', 2),
(7, 'A', 2),
(8, 'A', 2),
(9, 'A', 2),
(10, 'A', 2); 

-- datos de personal con roles encargado limpieza
INSERT INTO encargado (id, suelda, observacion) VALUES
(1, 1500.00, 'Es un administrador competente'),
(2, 1200.00, 'Encargado de operaciones');

INSERT INTO limpieza (id, observacion) VALUES
(3, 'Limpieza 1'),
(4, 'Limpieza 2'),
(5, 'Limpieza 3');

INSERT INTO encargado (id, suelda, observacion) VALUES
(6, 1500.00, 'Es un administrador competente'),
(7, 1200.00, 'Encargado de operaciones');

INSERT INTO limpieza (id, observacion) VALUES
(8, 'Limpieza 1'),
(9, 'Limpieza 2'),
(10, 'Limpieza 3');

INSERT INTO usuario (usuario, contrasena, estado, id_personal, id_rol) VALUES
('admin1', MD5('1234'), 'A', 1, 1),
('encargado1', MD5('1234'), 'A', 2, 2),
('admin2', MD5('1234'), 'A', 6, 1),
('encargado2', MD5('1234'), 'A', 7, 2);

-- datos para cliente
INSERT INTO cliente (estado_suscripcion) VALUES
('I'),
('I'),
('I'),
('I');

-- cliente_persona
INSERT INTO cliente_persona (id, id_persona) VALUES
(1, 11),
(2, 12);

-- cliente_empresa
INSERT INTO cliente_empresa (id, nit, razon_social) VALUES
(3, '111222333', 'Empresa_A'),
(4, '333222111', 'Empresa_B');

-- cajas de 5 en las 2 sucursales 
INSERT INTO caja (sigla_caja, estado, id_sucursal)
VALUES
    ('Caja1', 'A', 1),
    ('Caja2', 'A', 1),
    ('Caja3', 'A', 1),
    ('Caja4', 'A', 1),
    ('Caja5', 'A', 1),
	
    ('Caja1', 'A', 2),
    ('Caja2', 'A', 2),
    ('Caja3', 'A', 2),
    ('Caja4', 'A', 2),
    ('Caja5', 'A', 2);

-- Insertar servicios
INSERT INTO servicio (id, nombre, detalle, precio,estado) VALUES
(1, 'Lavado rápido', 'Lavado rápido del vehículo', 70.00, 'A'),
(2, 'Lavado normal', 'Lavado normal del vehículo', 30.00, 'A'),
(3, 'Lavado de motor', 'Lavado profundo del motor del vehículo', 100.00, 'A'),
(4, 'Lavado especial', 'Lavado especial con productos premium', 80.00, 'A'),
(5, 'Lavado de chasis', 'Lavado del chasis del vehículo', 60.00, 'A'),
(6, 'Lavado de alfombra', 'Lavado de alfombras interiores', 40.00, 'A'),
(7, 'Encerado', 'Encerado para protección y brillo', 40.00, 'A'),
(8, 'Pulido', 'Pulido para mejorar la apariencia de la pintura', 40.00, 'A');

-- suscripcion
INSERT INTO suscripcion (id, precio, nombre, detalle, descuento, estado) VALUES
(1, 500.00, 'Básica', 'Suscripción básica', 10, 'A'),
(2, 1000.00, 'Estándar', 'Suscripción estándar', 30, 'A'),
(3, 1500.00, 'Premium', 'Suscripción premium', 50, 'A');

-- Insertar tipos de vehículo
INSERT INTO tipo_vehiculo (nombre) VALUES
('Taxi'),
('Vagoneta'),
('Camioneta 1 cabina'),
('Camioneta 2 cabina'),
('Tundra'),
('Minibus'),
('Micro'),
('Camion'),
('Moto'),
('Cuadratrack'),
('Terix');

INSERT INTO marca (nombre) VALUES
('Toyota'),
('Honda'),
('Ford'),
('Chevrolet'),
('Nissan');

-- 
INSERT INTO precio_tipo_vehiculo (precio, id_tipo_vehiculo) VALUES
-- Taxi
(35.00, 1),
(40.00, 1),
-- Vagoneta
(50.00, 2),
-- Camioneta 1 Cabina
(60.00, 3),
-- Camioneta 2 Cabinas
(70.00, 4),
-- Tundra
(80.00, 5),
(90.00, 5),
-- Minibus
(50.00, 6),
(60.00, 6),
(70.00, 6),
-- Micro
(100.00, 7),
-- Camión
(120.00, 8),
-- Moto
(30.00, 9),
-- Cuadratrack
(60.00, 10),
-- Terix
(80.00, 11);

-- suscripcion_servicio
INSERT INTO suscripcion_servicio (id_suscripcion, id_servicio) VALUES
(1, 1), -- Básica - Lavado rápido
(1, 2), -- Básica - Lavado normal
(1, 5), -- Básica - Lavado de chasis
(2, 1), -- Estándar - Lavado rápido
(2, 2), -- Estándar - Lavado normal
(2, 3), -- Estándar - Lavado de motor
(2, 5), -- Estándar - Lavado de chasis
(2, 6), -- Estándar - Lavado de alfombra
(3, 1), -- Premium - Lavado rápido
(3, 2), -- Premium - Lavado normal
(3, 3), -- Premium - Lavado de motor
(3, 4), -- Premium - Lavado especial
(3, 5), -- Premium - Lavado de chasis
(3, 6), -- Premium - Lavado de alfombra
(3, 7), -- Premium - Encerado
(3, 8); -- Premium - Pulido




