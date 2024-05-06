from flask import Blueprint, jsonify,redirect, render_template, request, url_for,session

from services.servicio_inicio import sesion_usuario

#mi ruta
inicio_bp = Blueprint('inicio', __name__)


@inicio_bp.route('/')
def inicio():
    if 'sesion_abierta' in session:
        return render_template('inicio/base.html')
    else:      
        return redirect(url_for('inicio.login'))

@inicio_bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        nombre = request.form['nombre']
        password = request.form['password']
        respuesta = sesion_usuario.validar_usuario(nombre, password)
        if respuesta == True:
            return redirect(url_for('inicio.inicio'))
        else:
            return render_template('inicio/login.html',mensaje=respuesta)
    else:
        return render_template('inicio/login.html')

@inicio_bp.route('/cerrar_sesion')
def cerrar_sesion():
    response = sesion_usuario.cerrar_sesion()
    return response