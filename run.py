from flask import Flask
from config.configuracion import *
from utils.var_globales import variables_globales

#rutas importadas
from routes.inicio_routes import inicio_bp
from routes.caja_routes import caja_bp
from routes.cliente_routes import cliente_bp
from routes.venta_routes import venta_bp 

app = Flask(__name__)
#--------- configuraciones -----------------
config_bd(app)
config_key(app)
#-------------------------------------------
app.context_processor(variables_globales)
#-------- mis rutas Blueprint ---------
app.register_blueprint(inicio_bp)
app.register_blueprint(caja_bp)
app.register_blueprint(cliente_bp)
app.register_blueprint(venta_bp)

if __name__ == '__main__':
    app.run(port = 3000,debug = True)
    