<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="stylesheet" href="vista/lib/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="vista/lib/bootstrap-datepicker/css/bootstrap-datepicker3.min.css"/>
        <link rel="stylesheet" href="vista/css/estilos.css"/>
        <!--<link rel="stylesheet" href="lib/bootstrap/css/bootstrap-theme.min.css"/>-->
        
        <script src="vista/lib/jquery1.11.2.js"></script>
        <script src="vista/lib/bootstrap/js/bootstrap.min.js"></script>
        <script src="vista/lib/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script> 
        <script src="vista/lib/bootstrap-datepicker/locales/bootstrap-datepicker.es.min.js"></script> 
        <script type="text/javascript" src="vista/js/funciones.js"></script>
        
        <title>SISREHMED - Administración</title>
    </head>
    <body>
    	<div id="header"></div>

        <div class="container-fluid">
	        <div class="row">
		        <div class="col-sm-3 col-md-2 sidebar sidebar-admin">
		        	<ul class="nav nav-admin">
		        		<li style="border-bottom: 3px solid #ccc;"><h4 style="padding-left:5px;">Funciones</h4></li>
                        <li><a href="?funcion=nueva-hora">Crear Nueva Hora Médica</a></li>
                        <li><a href="?funcion=nuevo-paciente" >Crear Paciente</a></li>
                        <li><a href="?funcion=nuevo-medico" >Crear Médico</a></li>
                    </ul>
		        </div>
		        
		        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main-admin">
		        <h1>
		        <% if(request.getAttribute("funcion")=="nueva-hora"){
		        		out.print("Nueva Hora Médica");
		        	}
			        else if(request.getAttribute("funcion")=="nuevo-paciente"){
		        		out.print("Nueva Paciente");
		        	}
			        else if(request.getAttribute("funcion")=="nuevo-medico"){
		        		out.print("Nuevo Médico");
		        	}
			        else{
			        	out.print("Funcionalidad no válida");
			        }
		        %>
		        </h1>
		        <div class="divider"></div>
		        </div>
	        </div>
        </div>

</body>
</html>