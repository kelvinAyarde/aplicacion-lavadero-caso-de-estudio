from flask import session,redirect,url_for
from database.db_mysql import conectar_bd

class venta_suscripcion():
    
    def registrar_venta_suscripcion(fecha_inicio,id_suscripcion,id_cliente):
        try:
            conn = conectar_bd()
            cur = conn.cursor()
            cur.execute('''INSERT INTO venta_suscripcion (fecha_registro, fecha_inicio, fecha_fin, 
                estado, id_suscripcion, id_cliente)
                VALUES (NOW(), %s, DATE_ADD(%s, INTERVAL 1 MONTH), 'A', %s, %s);''', 
                (fecha_inicio, fecha_inicio, id_suscripcion, id_cliente))
            conn.commit()
            cur.close()
            conn.close()
            return 'registro exitoso'
        except Exception as ex:
            print(ex)
            return ex
    
    def obtener_suscripcion():
        cursor = conectar_bd().cursor()
        cursor.execute('''SELECT s.id, s.nombre , s.precio FROM suscripcion s
            WHERE s.estado = 'A';''')
        resultados = cursor.fetchall()
        cursor.close()
        if resultados:
            return resultados
        else:
            return "vacio"
        
    def obtener_servicios_suscripcion(id_suscripcion):
        cursor = conectar_bd().cursor()
        cursor.execute('''SELECT se.nombre, se.detalle , se.precio , s.descuento as descuento_porcentaje, 
                       se.precio - ROUND(se.precio * s.descuento / 100, 2) AS con_descuento
            FROM suscripcion_servicio ss
            JOIN suscripcion s ON ss.id_suscripcion = s.id
            JOIN servicio se ON se.id = ss.id_servicio
            WHERE s.id = %s;''',(id_suscripcion,))
        nombre_columnas = [column[0] for column in cursor.description]
        resultados = cursor.fetchall()
        cursor.close()
        datos_tabla = [nombre_columnas] + [list(fila) for fila in resultados]
        return datos_tabla
    
class venta_servicio():
    def registrar_venta_servicio(p_observacion, p_id_vehiculo, p_id_servicio, p_precio_tipo_vehiculo,p_id_cliente):
        try:
            conn = conectar_bd()
            cur = conn.cursor()
            print(p_observacion, p_id_vehiculo,p_id_servicio,p_precio_tipo_vehiculo,
                                                    p_id_cliente)
            cur.callproc("RegistrarVentaServicio", (p_observacion, p_id_vehiculo,p_id_servicio,p_precio_tipo_vehiculo,
                                                    p_id_cliente))
            conn.commit()
            cur.close()
            conn.close()
            return 'registro exitoso'
        except Exception as ex:
            print(ex)
            return ex
    
    def obtener_vehiculoCliente(id_cliente):
        cursor = conectar_bd().cursor()
        cursor.execute('''SELECT v.id as id_vehiculo, v.placa as placa, tv.nombre as tipo_vehiculo, m.nombre as marca
            FROM cliente c 
            JOIN vehiculo v ON v.id_cliente = c.id
            JOIN marca m ON m.id = v.id_marca
            JOIN tipo_vehiculo tv ON tv.id = v.id_tipo_vehiculo
            WHERE c.id = %s ;''',(id_cliente,))
        nombre_columnas = [column[0] for column in cursor.description]
        resultados = cursor.fetchall()
        cursor.close()
        datos_tabla = [nombre_columnas] + [list(fila) for fila in resultados]
        return datos_tabla
    
    def obtener_precioTipoVehiculo(id_vehiculo):
        cursor = conectar_bd().cursor()
        cursor.execute('''SELECT ptv.id,tv.nombre,  ptv.precio
            FROM vehiculo v
            JOIN tipo_vehiculo tv ON tv.id = v.id_tipo_vehiculo
            JOIN precio_tipo_vehiculo ptv ON tv.id = ptv.id_tipo_vehiculo
            WHERE v.id = %s''',(id_vehiculo,))
        resultados = cursor.fetchall()
        cursor.close()
        if resultados:
            return [list(fila) for fila in resultados]
        else:
            return "vacio"
    
    def obtener_Servicios():
        cursor = conectar_bd().cursor()
        cursor.execute('''SELECT s.id, s.nombre, s.precio FROM servicio s WHERE s.estado = 'A';''')
        resultados = cursor.fetchall()
        cursor.close()
        if resultados:
            return resultados
        else:
            return "vacio"
        
        
   
    
    