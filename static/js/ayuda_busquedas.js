function crearTabla($tabla, resultados) {
    $tabla.empty();
    var tablaHTML = `
        <table>
            <thead>
                <tr>
                    ${Object.keys(resultados[0]).map(columna => `<th>${resultados[0][columna]}</th>`).join('')}
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    `;
    var $tablaHTML = $(tablaHTML).appendTo($tabla);
    var $cuerpo = $tablaHTML.find("tbody");
    for (var i = 1; i < resultados.length; i++) {
        var fila = resultados[i];
        var $filaHTML = $("<tr>").appendTo($cuerpo);
        // Ordena los campos de la fila antes de agregarlos a la tabla
        var camposOrdenados = Object.keys(fila).sort((a, b) => parseInt(a) - parseInt(b));
        camposOrdenados.forEach(function (columna) {
            $("<td>").text(fila[columna]).appendTo($filaHTML);
        });
    }
}

function crearTablaCheckBox($tabla, resultados, name) {
    $tabla.empty();
    var tablaHTML = `
        <table>
            <thead>
                <tr>
                <th></th>
                    ${Object.keys(resultados[0]).map(columna => `<th>${resultados[0][columna]}</th>`).join('')}
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    `;
    var $tablaHTML = $(tablaHTML).appendTo($tabla);
    var $cuerpo = $tablaHTML.find("tbody");
    for (var i = 1; i < resultados.length; i++) {
        var fila = resultados[i];
        var $filaHTML = $("<tr>").appendTo($cuerpo);
        // Agrega un checkbox a cada fila del cuerpo de la tabla con un valor que contenga toda la información de la fila correspondiente
        var $checkbox = $("<input>").attr("type", "checkbox").attr("value", Object.values(fila).join(',')).appendTo($("<td>").appendTo($filaHTML));
        // Ordena los campos de la fila antes de agregarlos a la tabla
        var camposOrdenados = Object.keys(fila).sort((a, b) => parseInt(a) - parseInt(b));
        camposOrdenados.forEach(function (columna) {
            $("<td>").text(fila[columna]).appendTo($filaHTML);
        });
    }
    // Agrega un campo oculto con el nombre y valor del checkbox seleccionado
    var $campoOculto = $("<input>").attr("type", "hidden").attr("name", name).appendTo($tabla);
    // Deselecciona los checkboxes previamente seleccionados y marca el checkbox actualmente seleccionado
    $tablaHTML.on('change', 'input[type="checkbox"]', function () {
        if ($(this).is(':checked')) {
            $tablaHTML.find('input[type="checkbox"]').not(this).prop('checked', false);
            $(this).prop('checked', true);
            // Actualiza el valor del campo oculto con el valor del checkbox seleccionado
            $campoOculto.val($(this).val());
        } else {
            // Si no hay ningún checkbox seleccionado, asigna un valor vacío al campo oculto
            $campoOculto.val('');
        }
    });
}

// Función para realizar la búsqueda en tiempo real
function buscarTabla($tabla, url, check_name) {
    $.ajax({
        url: url,
        method: "POST",
        success: function (response) {
            if (check_name != null) {
                crearTablaCheckBox($tabla, response, check_name);
            } else {
                //console.log(response);
                crearTabla($tabla, response);
            }
        }
    });
}
function buscarTablaInput($input, $tabla, url, check_name) {
    var busqueda = $input.val();
    $.ajax({
        url: url,
        method: "POST",
        data: { busqueda: busqueda },
        success: function (response) {
            if (check_name != null) {
                crearTablaCheckBox($tabla, response, check_name);
            } else {
                crearTabla($tabla, response);
            }
        }
    });
}

function generarTablaHTML($tabla, columnas, datos, check_name) {
    // Crea una tabla HTML con las columnas y filas correspondientes
    var tablaHTML = '<table>';
    tablaHTML += '<thead><tr>';
    if (check_name != null) {
        tablaHTML += '<th> # </th>';
    }
    for (var i = 0; i < columnas.length; i++) {
        tablaHTML += '<th>' + columnas[i] + '</th>';
    }
    tablaHTML += '</tr></thead>';
    tablaHTML += '<tbody>';
    if (typeof datos[0] !== 'undefined') {
        for (var i = 0; i < datos.length; i++) {
            tablaHTML += '<tr>';
            if (check_name != null) {
                tablaHTML += '<td><input type="checkbox" name="' + check_name + '" value="' + datos[i][0] + '"></td>';
            }
            for (var j = 0; j < columnas.length; j++) {
                tablaHTML += '<td>' + datos[i][j] + '</td>';
            }
            tablaHTML += '</tr>';
        }
    } else {
        tablaHTML += '<tr>';
        if (check_name != null) {
            tablaHTML += '<td>' + '' + '</td>';
        }
        for (var i = 0; i < columnas.length; i++) {
            tablaHTML += '<td>' + 'No datos' + '</td>';
        }
        tablaHTML += '</tr>';
    }
    tablaHTML += '</tbody></table>';
    $tabla.html(tablaHTML);

    // OBSERVACION !!!
    $tabla.on('change', 'input[type="checkbox"]', function () {
        if ($(this).is(':checked')) {
            $tabla.find('input[type="checkbox"]').not(this).prop('checked', false);
            $(this).prop('checked', true);
        }
    });
}

function generarSelect(datSelect, datName) {
    var select_html = '<select name="' + datName + '">';
    if (datSelect === 'vacio') {
        select_html += '<option value="vacio">vacio</option>';
    } else {
        $.each(datSelect, function (i, dato) {
            var option_content = dato.slice(1).join(' - ');
            var option = '<option value="' + dato[0] + '">' + option_content + '</option>';
            select_html += option;
        });
    }
    select_html += '</select>';
    return select_html;
}
