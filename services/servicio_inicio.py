from flask import session,redirect,url_for
from database.db_mysql import conectar_bd

class sesion_usuario():
    #----
    def validar_usuario(usuario,contrasena):
        try:
            conn = conectar_bd()
            cur = conn.cursor()
            cur.callproc("verificar_credencial", (usuario, contrasena))
            data = cur.fetchone()
            cur.close()
            conn.close()
            if data:
                sesion_usuario.guardar_sesion(data)
                return True
            else:
                return 'Credenciales invalidas!!'
        except Exception as ex:
            print(ex)
            
    def guardar_sesion(datos_usu):
        session['sesion_abierta'] = True
        #---------------
        session['nombre_1'] = datos_usu[0]
        session['nombre_2'] = datos_usu[1] if datos_usu[1] is not None else '' # si no es None entonces se pasa en blanco ''
        session['apellido_1'] = datos_usu[2]
        session['apellido_2'] = datos_usu[3] if datos_usu[3] is not None else '' # si no es null entonces se pasa en blanco ''
        session['rol'] = datos_usu[4]
        #---------------
        session['id_personal'] = datos_usu[5]
        session['id_rol'] = datos_usu[6]
        session['id_sucursal'] = datos_usu[7]

    def cerrar_sesion():
        session.clear()
        return redirect(url_for('inicio.inicio'))
            