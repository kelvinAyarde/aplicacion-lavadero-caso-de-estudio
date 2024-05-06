from flask import Blueprint, jsonify,redirect, render_template, request, url_for,session

from services.servicio_cliente import cliente_gral,vehiculo_cliente
from utils.generar_html import generar_select
#mi ruta
cliente_bp = Blueprint('cliente', __name__)

@cliente_bp.route('/cliente')
def cliente():
    return render_template('cliente/cliente_menu.html')

@cliente_bp.route('/cliente/registro_cliente', methods=['GET','POST'])
def registro_cliente():
    if request.method == 'POST':
        primer_nombre = request.form.get('primer_nombre', None)
        segundo_nombre = request.form.get('segundo_nombre', None)
        primer_apellido = request.form.get('primer_apellido', None)
        segundo_apellido = request.form.get('segundo_apellido', None)
        nro_ci = request.form.get('nro_ci', None)
        telefono = request.form.get('telefono', None)
        email = request.form.get('email', None)
        #--- datos de Empresa
        nit = request.form.get('nit', None)
        razon_social = request.form.get('razon_social', None)
    
        respuesta = cliente_gral.registrar_cliente(primer_nombre, segundo_nombre,primer_apellido,segundo_apellido,
                                              nro_ci,telefono,email,nit,razon_social)
        return render_template('cliente/frm_reg_cliente.html',mensaje=respuesta)
    else:
        return render_template('cliente/frm_reg_cliente.html')
    
@cliente_bp.route('/cliente/registro_vehiculo', methods=['GET','POST'])
def registro_vehiculo():
    select_tipo_vehiculo = generar_select(vehiculo_cliente.buscar_tipoVehiculo(),'id_tipo_vehiculo')
    select_marca = generar_select(vehiculo_cliente.buscar_marca(),'id_marca')
    
    if request.method == 'POST':
        placa = request.form.get('placa', None)
        id_cliente = request.form.get('id_cliente', None)
        id_marca = request.form.get('id_marca', None)
        id_tipo_vehiculo = request.form.get('id_tipo_vehiculo', None)
        respuesta = vehiculo_cliente.registrar_vehiculo(placa,id_tipo_vehiculo,id_marca,id_cliente)
        return render_template('cliente/frm_reg_vehiculo.html',mensaje=respuesta)
    else:
        return render_template('cliente/frm_reg_vehiculo.html',select_tipo_vehiculo=select_tipo_vehiculo,
                               select_marca=select_marca)
        
@cliente_bp.route('/buscar_ajax/busq_clienteEmpresa', methods=['POST'])
def busq_clienteEmpresa():
    nit = request.form.get('busqueda', None)
    repuesta = cliente_gral.buscar_clienteEmpresa(nit)
    return repuesta

@cliente_bp.route('/buscar_ajax/busq_clientePersona', methods=['POST'])
def busq_clientePersona():
    nro_ci = request.form.get('busqueda', None)
    repuesta = cliente_gral.buscar_clientePersona(nro_ci)
    return repuesta

