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
    
    $('#modalReserva').on('show.bs.modal', function (event) {
    	  var button = $(event.relatedTarget); // Button that triggered the modal
    	  var recipient = button.data('idhora'); // Extract info from data-* attributes
    	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    	  var modal = $(this);
    	  modal.find('#id-input').val(recipient);
	});
    
    $("#botonReservaModal").click(function(e){
        $("#formReserva").submit();
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

