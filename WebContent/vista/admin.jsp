
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="control.util.Utilidades"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		<% String funcion = request.getParameter("funcion"); 
			if(funcion == null){
		        	funcion = "nuevo-cupo";
		        }
        %>
        <div class="container-fluid">
	        <div class="row">
		        <div class="col-sm-3 col-md-2 sidebar sidebar-admin">
		        	<ul class="nav nav-admin" style="margin-top:30px;">
		        		<li class="sidebar-titulo">Funciones</h4></li>
		        		<li <%if(funcion.equals("buscar-cupo")){ out.print("class='active'");} %>><a href="?funcion=buscar-cupo">Busqueda de cupos</a></li>
                        <li <%if(funcion.equals("nuevo-cupo")){ out.print("class='active'");} %>><a href="?funcion=nuevo-cupo">Crear Nuevo Cupo</a></li>
                        <li <%if(funcion.equals("modificar-cupo")){ out.print("class='active'");} %>><a href="?funcion=modificar-cupo">Modificar Cupo</a></li>
                        <li <%if(funcion.equals("eliminar-cupo")){ out.print("class='active'");} %>><a href="?funcion=eliminar-cupo">Eliminar Cupo</a></li>
<%--                         <li <%if(funcion.equals("nuevo-paciente")){ out.print("class='active'");} %>><a href="?funcion=nuevo-paciente" >Crear Paciente</a></li> --%>
<%--                         <li <%if(funcion.equals("nuevo-medico")){ out.print("class='active'");} %>><a href="?funcion=nuevo-medico" >Crear Médico</a></li> --%>
                    </ul>
		        </div>
		        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main-admin">
        	<div id="mensaje"></div>  
	        <div style="margin-right: 40px;margin-left: 40px;">
		        <h1>
		        <% 
		        	if(funcion.equals("nuevo-cupo")){
		        		out.print("Nuevo Cupo");
		        	}
			        else if(funcion.equals("nuevo-paciente")){
		        		out.print("Nuevo Paciente");
		        	}
			        else if(funcion.equals("nuevo-medico")){
		        		out.print("Nuevo Médico");
		        	}
			        else{
			        	out.print("Funcionalidad no válida");
			        }
		        %>
		        </h1>
		        <div class="divider"></div>
		        
		        <%if(funcion.equals("nuevo-cupo")){%>
		        <form action="Admin" method="get">
		        <input type="hidden" name="tipo" value="nuevo-cupo">
		        <input type="hidden" name="fecha" id="fecha" value="">
		        <div style="background: #F5F5F5;border: 1px solid #dcdcdc;border-radius: 2px;">
		        	<div class="row" style="padding:10px 20px 10px 20px;">
	        			<div class="col-md-4" style="border-right: 1px solid #dcdcdc;padding:13px;">
	        				<label style="margin-left: 40px;" class="txt-mediano">Fecha:</label>
	        				<div class="divider" style="margin-top:11px;"></div>
	        				<div id="dia-hora-medica">
	        				
	        				</div>
	        			</div>
	        			<div class="col-md-8">
	        				<div class="row" style="padding:10px;">
	        					<div class="col-md-6 form-inline" style="border-right: 1px solid #dcdcdc;">
	        						<label class="txt-mediano" style="margin-right:30px;">Hora: </label>
	        						<div class="form-group">
	        						<input class="form-control" name="hora-hora" type="number" placeholder="HH" style="width: 75px;">
	        						<label class="txt-mediano">:</label>
	        						<input class="form-control" name="hora-minutos" type="number" placeholder="MM" style="width: 75px;">
	        						</div>
	        					</div>
	        					<div class="col-md-6 form-inline" style="margin-top:7px;">
	        						<label class="radio-inline txt-mediano">
									  <input type="radio" name="aps" id="aps" value="1"> APS
									</label>
									<label class="radio-inline txt-mediano">
									  <input type="radio" name="aps" id="aps" value="0" checked> No APS
									</label>
	        					</div>
	        				</div>
	        				<div class="divider"></div>
	        				<div class="row" style="padding:0 10px 0 10px;">
								<div class="col-md-6" style="border-right: 1px solid #dcdcdc;">
									<label class="txt-mediano">Médico:</label>
									<div class="form-inline form-group">
											<div class="input-group">
												<div class="input-group-addon"><span class="glyphicon glyphicon-search"></span></div>
												<input class="form-control" id="buscarMedico" type="text" placeholder="Buscar Médico ..." style="width: 223px;">
											</div>
									</div>
									<div class="form-group">
										<select multiple id="medico" name="medico" class="form-control" style="height:165px;">
											<%
				                            String medicosJSON = (String)request.getAttribute("medicos");
				                        	JSONArray medicos = Utilidades.obtenerArrayJSON(medicosJSON, "medicos");
				                            for (int i=0; i<medicos.size();i++){
				                            	JSONObject actual = (JSONObject)medicos.get(i);
				                                out.print("<option value='"+actual.get("id")+"'>"+actual.get("id")+": "+actual.get("nombre")+"</option>");
				                            }
				
				                         	%>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<label class="txt-mediano">Box:</label>
									<div class="form-inline form-group">
										<div class="input-group">
											<div class="input-group-addon"><span class="glyphicon glyphicon-search"></span></div>
											<input class="form-control" id="buscarBox" type="text" placeholder="Buscar Box ..." style="width: 223px;">
										</div>
									</div>
									<div class="form-group">
										<select multiple id="box" name="box" class="form-control" style="height:165px;">
										  <%
				                            String boxesJSON = (String)request.getAttribute("boxes");
				                        	JSONArray boxes = Utilidades.obtenerArrayJSON(boxesJSON, "boxes");
				                            for (int i=0; i<boxes.size();i++){
				                            	JSONObject actual = (JSONObject)boxes.get(i);
				                                out.print("<option value='"+actual.get("id")+"'>"+actual.get("id")+": "+actual.get("nombre")+"</option>");
				                            }
				
			                         		%>
										</select>
									</div>
								</div>
							</div>
	        			</div>
        			</div>
        					
        			<div class="divider" style="margin:0 20px 0 20px;"></div>
        			<div class="row" style="padding:10px 20px 10px 20px;">
				        <div style="float:right;padding:10px;">
				        	<a href="Admin?funcion=nuevo-cupo" class="btn btn-danger">Limpiar</a>
				        	<input class="btn btn-primary" type="submit" value="Crear Cupo">
				        </div>
			        </div>
		        </div>
	        	</form>
	        	<%} %>
	        </div>
        </div>
       
       </div>
      
      </div>

</body>
</html>