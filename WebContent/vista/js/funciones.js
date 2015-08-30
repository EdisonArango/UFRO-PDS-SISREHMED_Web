/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
	
	//Carga de vistas
	$("#header").load("Vista?tipo=header");
	$("#mensaje").load("Vista?tipo=mensaje");
    
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
    
    $('#dia-hora-medica').datepicker({
    	format: "dd/mm/yyyy",
        language: "es"
    }).on('changeDate', function(e){
    	$("#fecha").val($("#dia-hora-medica").datepicker('getFormattedDate'));
    });
    
    
    $('#modalReserva').on('show.bs.modal', function (event) {
    	  var button = $(event.relatedTarget); // Button that triggered the modal
    	  var recipient = button.data('idhora'); // Extract info from data-* attributes
    	  var medico = button.data('medico');
    	  var hora = button.data('hora');
    	  var fecha = button.data('fecha');
    	  var dia = button.data('dia');
    	  var box = button.data('box');
    	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    	  var modal = $(this);
    	  modal.find('#id-input').val(recipient);
    	  modal.find('#id-medico').text(medico);
    	  modal.find('#id-hora').text(hora);
    	  modal.find('#id-fecha').text(fecha);
    	  modal.find('#id-dia').text(dia);
    	  modal.find('#id-box').text(box);
	});
    
    $("#botonReservaModal").click(function(e){
        $("#formReserva").submit();
    });;
    
    //Método de busqueda
    jQuery.fn.filterByText = function(textbox) {
        return this.each(function() {
            var select = this;
            var options = [];
            $(select).find('option').each(function() {
                options.push({value: $(this).val(), text: $(this).text()});
            });
            $(select).data('options', options);

            $(textbox).bind('change keyup', function() {
                var options = $(select).empty().data('options');
                var search = $.trim($(this).val());
                var regex = new RegExp(search,"gi");

                $.each(options, function(i) {
                    var option = options[i];
                    if(option.text.match(regex) !== null) {
                        $(select).append(
                            $('<option>').text(option.text).val(option.value)
                        );
                    }
                });
            });
        });
    };
    
    
    $('#medico').filterByText($('#buscarMedico'));
    $('#box').filterByText($('#buscarBox'));
    
    //Alternar vistas de horas
    $("#boton-listado").on("click",function(){
    	$("#tabla-listado").show(400);
    	$("#tabla-calendar").hide(300);
    	$("#boton-listado").removeClass("btn-default");
    	$("#boton-listado").addClass("btn-dark");
    	$("#boton-calendar").removeClass("btn-dark");
    	$("#boton-calendar").addClass("btn-default");
    });
    
    $("#boton-calendar").on("click",function(){
    	$("#tabla-calendar").show(400);
    	$("#tabla-listado").hide(300);
    	$("#boton-listado").removeClass("btn-dark");
    	$("#boton-listado").addClass("btn-default");
    	$("#boton-calendar").removeClass("btn-default");
    	$("#boton-calendar").addClass("btn-dark");
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
    
    function cambiarTipoReporte (tipo){
    	$("#inputTipo").val(tipo);
    }

    


