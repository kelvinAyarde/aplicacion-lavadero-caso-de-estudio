from flask import Blueprint, jsonify,redirect, render_template, request, url_for,session

from services.servicio_caja import apertura_caja
from utils.generar_html import generar_select

#mi ruta
caja_bp = Blueprint('caja', __name__)

@caja_bp.route('/caja')
def caja():
    return render_template('caja/caja_menu.html')

@caja_bp.route('/caja/apertura_cierre')
def caja_apertura_cierre():
    id_sucursal = session['id_sucursal']
    select_cajas= generar_select(apertura_caja.obtener_CajasSinApertura(id_sucursal),"id_caja")
    tabla_cajas_aperturadas = apertura_caja.obtener_cajasAperturadas(id_sucursal)
    return render_template('caja/caja_apertura_cierre.html', select_cajas = select_cajas, 
                           tabla_cajas_aperturadas=tabla_cajas_aperturadas)

@caja_bp.route('/caja/pago_venta')
def caja_pago_venta():
    return render_template('caja/caja_pago_venta.html')

@caja_bp.route('/caja/registro_apertura', methods=['POST'])
def caja_registro_apertura():
    select_cajas= generar_select(apertura_caja.obtener_CajasSinApertura(session['id_sucursal']),"id_caja")
    
    return render_template('caja/caja_apertura_cierre.html', select_cajas = select_cajas)

