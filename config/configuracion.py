from flask_mysqldb import MySQL

def config_bd(app):
    app.config['MYSQL_HOST'] = 'localhost'
    app.config['MYSQL_USER'] = 'root'
    app.config['MYSQL_PASSWORD'] = ''
    app.config['MYSQL_DB'] = 'exg_caso2_v2'
    MySQL(app)   
        
def config_key(app):
    app.config['SECRET_KEY'] = 'mi_clave_secreta'