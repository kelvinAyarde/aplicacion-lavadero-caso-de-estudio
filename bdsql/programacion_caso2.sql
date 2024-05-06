
/*------------------ PROCEDIMIENTOS ALMACENADOS ---------------------*/

-- verificar credenciales de usuario
DELIMITER //
CREATE PROCEDURE verificar_credencial(
    IN p_usuario VARCHAR(50),
    IN p_contrasena VARCHAR(128)
)
BEGIN	
	SELECT p.primer_nombre, p.segundo_nombre, p.primer_apellido, p.segundo_apellido, r.nombre as nombre_rol, 
		pe.id as id_personal, r.id as id_rol, pe.id_sucursal
    FROM persona p
    JOIN personal pe ON p.id = pe.id
    JOIN usuario u ON pe.id = u.id_personal
    JOIN rol r ON u.id_rol = r.id
    WHERE u.usuario = p_usuario AND u.contrasena = md5(p_contrasena);
END //
DELIMITER ;

-- registrar cliente
DELIMITER //

CREATE PROCEDURE registrar_cliente(
    IN p_primer_nombre VARCHAR(50),
    IN p_segundo_nombre VARCHAR(50),
    IN p_primer_apellido VARCHAR(50),
    IN p_segundo_apellido VARCHAR(50),
    IN p_nro_ci VARCHAR(15),
    IN p_telefono VARCHAR(15),
    IN p_email VARCHAR(150),
    -- parametro de empresa
    IN p_nit VARCHAR(15),
    IN p_razon_social VARCHAR(50)
)
BEGIN
    DECLARE v_id_cliente INT;
    DECLARE v_id_persona INT;
    DECLARE registro_exito BOOLEAN DEFAULT TRUE;

    START TRANSACTION;

    -- Insertar en la tabla cliente
    INSERT INTO cliente (estado_suscripcion) VALUES ('I'); -- el estado_suscripcion es Inactivo por defecto al crearse
    SET v_id_cliente = LAST_INSERT_ID(); -- variable id_cliente donde almacenara el insert hecho en cliente
    IF ROW_COUNT() = 0 THEN
        SET registro_exito = FALSE;
    END IF;

    -- si no se tiene un nit entonces es una persona y se registra cliente_persona
    IF p_nit IS NULL THEN 
	-- Insertar en la tabla persona
		INSERT INTO persona (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, nro_ci, telefono, email) 
		VALUES (p_primer_nombre, p_segundo_nombre, p_primer_apellido, p_segundo_apellido, p_nro_ci, p_telefono, p_email);
		SET v_id_persona = LAST_INSERT_ID(); -- variable id_persona almacena el insert hecho en persona
	-- Insertar en la tabla cliente_persona	
        INSERT INTO cliente_persona (id, id_persona) VALUES (v_id_cliente, v_id_persona);
    ELSE 
	-- si se tiene un nit entonces es una empresa y se registra cliente_empresa
        INSERT INTO cliente_empresa (id, nit, razon_social) VALUES (v_id_cliente, p_nit, p_razon_social);
    END IF;

    -- Confirmar o deshacer la transaccion
    IF registro_exito THEN
        COMMIT;
    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al registrar el cliente';
    END IF;
END //

DELIMITER ;

-- registro de venta servicio
DELIMITER //

CREATE PROCEDURE RegistrarVentaServicio(
    IN p_observacion VARCHAR(250),
    IN p_id_vehiculo INT,
    IN p_id_servicio INT,
    IN p_precio_tipo_vehiculo INT,
    IN p_id_cliente INT
)
BEGIN
    DECLARE v_monto_total NUMERIC(10,2);
    DECLARE v_descuento NUMERIC(10,2);
    DECLARE v_id_suscripcion INT;
    
    -- Verificar si el cliente tiene una suscripción activa
    IF EXISTS (
        SELECT 1
		FROM cliente c
		WHERE c.estado_suscripcion = 'A' AND c.id = p_id_cliente
    ) THEN
        -- Buscar la suscripción activa del cliente
        SELECT id_suscripcion INTO v_id_suscripcion
        FROM venta_suscripcion
        WHERE id_cliente = p_id_cliente AND estado = 'A';

        -- Calcular el descuento
        SELECT se.precio - ROUND(se.precio * s.descuento / 100, 2) INTO v_descuento
        FROM suscripcion_servicio ss
        JOIN suscripcion s ON ss.id_suscripcion = s.id
        JOIN servicio se ON se.id = ss.id_servicio
        WHERE s.id = v_id_suscripcion AND se.id = p_id_servicio;

        -- Calcular el monto total con descuento
        SELECT SUM(s.precio + ptv.precio) INTO v_monto_total
        FROM precio_tipo_vehiculo ptv 
        JOIN servicio s ON s.id = p_id_servicio
        WHERE ptv.id = p_precio_tipo_vehiculo;

        -- Aplicar el descuento al monto total
        SET v_monto_total = v_monto_total - v_descuento;
    ELSE
        -- Calcular el monto total sin descuento
        SELECT SUM(s.precio + ptv.precio) INTO v_monto_total
        FROM precio_tipo_vehiculo ptv 
        JOIN servicio s ON s.id = p_id_servicio
        WHERE ptv.id = p_precio_tipo_vehiculo;
    END IF;

    -- Insertar la nueva venta de servicio
    INSERT INTO venta_servicio (estado, observacion, monto_total, fecha_registro, id_vehiculo, id_servicio)
    VALUES ('E', p_observacion, v_monto_total, NOW(), p_id_vehiculo, p_id_servicio);
END //

DELIMITER ;



/*----------------------- TRIGGERS ----------------------------*/

-- registro_venta_suscripcion
DELIMITER //
CREATE TRIGGER registro_venta_suscripcion
AFTER INSERT ON venta_suscripcion
FOR EACH ROW
BEGIN
    UPDATE cliente
    SET estado_suscripcion = 'A'
    WHERE id = NEW.id_cliente;
END;
//
DELIMITER ;

-- actualizar_estado_suscripcion
DELIMITER //
CREATE TRIGGER actualizar_estado_suscripcion
AFTER UPDATE ON venta_suscripcion
FOR EACH ROW
BEGIN
    UPDATE cliente
    SET estado_suscripcion = NEW.estado
    WHERE id = NEW.id_cliente;
END;
//
DELIMITER ;













