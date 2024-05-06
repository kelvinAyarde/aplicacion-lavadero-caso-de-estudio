from flask import session


def variables_globales():
    var_globales = {
    'sesion_abierta': session.get('sesion_abierta',False),
    'nombre_1': session.get('nombre_1',''),
    'nombre_2': session.get('nombre_2',''),
    'apellido_1': session.get('apellido_1',''),
    'apellido_2': session.get('apellido_2',''),
    'rol': session.get('rol',''),
    
    'id_personal': session.get('id_personal',''),
    'id_rol': session.get('id_rol',''),
    'id_sucursal': session.get('id_sucursal','')
    }
    return dict(var_globales=var_globales)