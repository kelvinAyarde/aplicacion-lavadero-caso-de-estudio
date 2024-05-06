from flask import Blueprint, jsonify,redirect, render_template, request, url_for,session

from services.servicio_venta import venta_suscripcion,venta_servicio
from utils.generar_html import generar_select
#mi ruta
venta_bp = Blueprint('venta', __name__)

@venta_bp.route('/venta')
def venta():
    return render_template('venta/venta_menu.html')

@venta_bp.route('/venta/reg_ven_suscripcion', methods=['GET','POST'])
def reg_ven_suscripcion():
    select_suscipcion = generar_select(venta_suscripcion.obtener_suscripcion(),'id_suscripcion')
    if request.method == 'POST':
        fecha_inicio = request.form.get('fecha_inicio', None)
        id_suscripcion = request.form.get('id_suscripcion', None)
        id_cliente = request.form.get('id_cliente', None)
        resultado= venta_suscripcion.registrar_venta_suscripcion(fecha_inicio,id_suscripcion,id_cliente)
        return render_template('venta/frm_reg_ven_suscripcion.html',select_suscipcion=select_suscipcion,
                               mensaje=resultado)
    else:
        return render_template('venta/frm_reg_ven_suscripcion.html',select_suscipcion=select_suscipcion)
    
@venta_bp.route('/buscar_ajax/busq_serviciosSubscripcion', methods=['POST'])
def busq_serviciosSubscripcion():
    id_suscripcion = request.form.get('busqueda', None)
    repuesta = venta_suscripcion.obtener_servicios_suscripcion(id_suscripcion)
    return repuesta

@venta_bp.route('/venta/reg_ven_servicio', methods=['GET','POST'])
def reg_ven_servicio():
    select_servicio = generar_select(venta_servicio.obtener_Servicios(),'id_servicio')
    if request.method == 'POST':
        observacion = request.form.get('observacion', None)
        id_vehiculo = request.form.get('id_vehiculo', None)
        id_servicio = request.form.get('id_servicio', None)
        id_cliente = request.form.get('id_cliente', None)
        precio_tipo_vehiculo = request.form.get('precio_tipo_vehiculo', None)
        resultado= venta_servicio.registrar_venta_servicio(observacion, id_vehiculo, id_servicio, 
                                                           precio_tipo_vehiculo,id_cliente)
        return render_template('venta/frm_reg_ven_servicio.html',select_servicio=select_servicio,
                               mensaje=resultado)
    else:
        return render_template('venta/frm_reg_ven_servicio.html',select_servicio=select_servicio)
    
@venta_bp.route('/buscar_ajax/busq_vehiculoCliente', methods=['POST'])
def busq_vehiculoCliente():
    id_cliente = request.form.get('busqueda', None)
    repuesta = venta_servicio.obtener_vehiculoCliente(id_cliente)
    return repuesta

@venta_bp.route('/buscar_ajax/busq_precioTipoVehiculo', methods=['POST'])
def busq_precioTipoVehiculo():
    id_vehiculo = request.form.get('busqueda', None)
    repuesta = venta_servicio.obtener_precioTipoVehiculo(id_vehiculo)
    return repuesta



