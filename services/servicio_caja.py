from flask import session,redirect,url_for
from database.db_mysql import conectar_bd

class apertura_caja():
    
    def reg_apertura():
        #registrar la apertura de la caja y a su vez cambiar el estado de la Caja seleccionada a I
        pass
    
    def obtener_CajasSinApertura(id_sucursal):
        #buscar las cajas con estado A de activo
        cursor = conectar_bd().cursor()
        q = '''SELECT c.id as id, c.sigla_caja as sigla_caja
                FROM caja c WHERE c.estado = 'A' and c.id_sucursal = %s;'''
        parametros = (id_sucursal,)
        cursor.execute(q,parametros)
        resultados = cursor.fetchall()
        cursor.close()
        if resultados:
            return resultados
        else:
            return "vacio"
        
    def obtener_cajasAperturadas(id_sucursal):
        #se mostrara una tabla
        cursor = conectar_bd().cursor()
        q = '''SELECT ca.id as caja_apertura,c.sigla_caja, ca.monto_apertura,ca.fecha_apertura
                FROM caja_apertura ca
                JOIN caja c ON ca.id_caja = c.id
                WHERE ca.estado = 'A' AND c.id_sucursal = %s;'''
        parametros = (id_sucursal,)
        cursor.execute(q,parametros)
        nombre_columnas = [column[0] for column in cursor.description]
        resultados = cursor.fetchall()
        cursor.close()
        #----------
        datos_tabla = [nombre_columnas] + [list(fila) for fila in resultados]
        return datos_tabla
    


    