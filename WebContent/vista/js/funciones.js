/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
//    setTimeout(function() {
//        $(".mensaje").fadeOut(1500);
//    },2000);
//    
//    
//        $('#busqueda').keyup(function() {
//            var $rows = $('.tablacancion');
//            var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();
//            
//            $rows.show().filter(function() {
//                var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
//                return !~text.indexOf(val);
//            }).hide();
//    });
//
//    $("#contenido").load("CancionesServlet?type=pagina");
    
    //Datepicker
    $('.input-group.date').datepicker({
                        format: "dd/mm/yyyy",
                        startDate: "today",
                        endDate: "+100d",
                        orientation: "top auto",
                        autoclose: true,
                        todayBtn: "linked",
                        language: "es"
    });
    
    
});

    function cambiarTipoBusqueda() {
        
        if($("#selectTipo").val()==="medico"){
            $("#medico").show();
            $("#especialidad").hide();
        }
        else if($("#selectTipo").val()==="especialidad"){
            $("#medico").hide();
            $("#especialidad").show();
        }
        
    }

    



//function agregarPlayList (){
//    var insert = "<form class='form-inline' method='post' action='PlayListServlet' >\n\
//                   <div class='form-group'> <b>Nombre: </b><input type='text' class='form-control' name='nombre'>\n\
//    <input type='hidden' name='type' value='nuevo'>\n\
//        <input type='submit' class='form-control' value='Crear'> </div>\n\
//<form>";
//    document.getElementById("agregarPlayList").innerHTML = insert;
//}
//
//function cargarPlayList (url){
//    $("#contenido").load(url);
//}
///**
// * Comment
// */
//function eliminarUsuario(usuario) {
//    if (confirm("Estas seguro que deseas eliminar al usuario: "+usuario) == true) {
//        document.getElementById("frame").src = window.location.protocol + "//" +window.location.host + "/Login-MVC-JSP/Modificar?usuario="+usuario+"&tipomodificacion=eliminar";
//    } else {
//        return;
//    }
//}

