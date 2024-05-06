# Función para generar el código HTML del <select>
def generar_select(datSelect,datName):
    if datSelect == 'vacio':
        #si no hay datos es vacio
        return f'<select name="{datName}"><option value="vacio">vacio</option></select>'
    else:
        select_html = f'<select name="{datName}">'
        for dato in datSelect:
            # Crear el contenido de la opción uniendo todos los elementos de la lista excepto el primero
            option_content = ' - '.join(str(elemento) for elemento in dato[1:])
            option = f'<option value="{dato[0]}">{option_content}</option>'
            select_html += option
        select_html += '</select>'
        return select_html
    
def generar_tabla(datos, nomb_columnas):
    tabla_html = '<table>'
    tabla_html += '<thead><tr>'
    for nc in nomb_columnas:
        tabla_html += '<th>' + nc + '</th>'
    tabla_html += '</tr></thead>'
    tabla_html += '<tbody>'
    for d in datos:
        tabla_html += '<tr>'
        for value in d:
            tabla_html += '<td>' + str(value) + '</td>'
        tabla_html += '</tr>'
    tabla_html += '</tbody></table>'
    return tabla_html

