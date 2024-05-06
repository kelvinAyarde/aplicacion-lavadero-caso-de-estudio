from flask import session,redirect,url_for
from database.db_mysql import conectar_bd

class cliente_gral():
    
    def registrar_cliente(p_primer_nombre,p_segundo_nombre,p_primer_apellido,p_segundo_apellido,
                          p_nro_ci,p_telefono,p_email,p_nit,p_razon_social):
        try:
            conn = conectar_bd()
            cur = conn.cursor()
            cur.callproc("registrar_cliente", (p_primer_nombre,p_segundo_nombre,p_primer_apellido,p_segundo_apellido,
                                               p_nro_ci,p_telefono,p_email,p_nit,p_razon_social))
            cur.close()
            conn.close()
            return 'registro exitoso'
        except Exception as ex:
            print(ex)
            return ex
    
    def buscar_clientePersona(nro_ci):
        cursor = conectar_bd().cursor()
        cursor.execute('''SELECT cp.id as id_cliente, p.primer_nombre, p.primer_apellido, p.nro_ci
            FROM persona p JOIN cliente_persona cp ON p.id = cp.id_persona
            JOIN cliente c ON cp.id = c.id
            WHERE p.nro_ci = %s;''',(nro_ci,))
        nombre_columnas = [column[0] for column in cursor.description]
        resultados = cursor.fetchall()
        cursor.close()
        datos_tabla = [nombre_columnas] + [list(fila) for fila in resultados]
        return datos_tabla
    
    def buscar_clienteEmpresa(nit):
        cursor = conectar_bd().cursor()
        cursor.execute('''SELECT ce.id, ce.nit , ce.razon_social
            FROM cliente_empresa ce JOIN cliente c ON c.id = ce.id
            WHERE ce.nit = %s;''',(nit,))
        nombre_columnas = [column[0] for column in cursor.description]
        resultados = cursor.fetchall()
        cursor.close()
        datos_tabla = [nombre_columnas] + [list(fila) for fila in resultados]
        return datos_tabla

    
class vehiculo_cliente():
    
    def registrar_vehiculo(placa,id_tipo_vehiculo,id_marca,id_cliente):
        try:
            conn = conectar_bd()
            cur = conn.cursor()
            cur.execute('''INSERT INTO vehiculo (placa, id_tipo_vehiculo, id_marca, id_cliente) 
                         VALUES (%s, %s, %s, %s);''', (placa,id_tipo_vehiculo,id_marca,id_cliente))
            conn.commit()
            cur.close()
            conn.close()
            return 'registro exitoso'
        except Exception as ex:
            print(ex)
            return ex
    
    def buscar_marca():
        cursor = conectar_bd().cursor()
        q = '''SELECT m.id,m.nombre FROM marca m;'''
        cursor.execute(q)
        resultados = cursor.fetchall()
        cursor.close()
        if resultados:
            return resultados
        else:
            return "vacio"
            
    def buscar_tipoVehiculo():
        cursor = conectar_bd().cursor()
        q = '''SELECT tv.id, tv.nombre FROM tipo_vehiculo tv;'''
        cursor.execute(q)
        resultados = cursor.fetchall()
        cursor.close()
        if resultados:
            return resultados
        else:
            return "vacio"
