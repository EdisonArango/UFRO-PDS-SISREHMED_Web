<%-- 
    Document   : inicio
    Created on : 11-may-2015, 1:44:17
    Author     : edisonarango
--%>

<%@page import="control.util.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        
        <title>Sistema de Reserva de Horas Médicas</title>
    </head>
    <body>
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container-fluid">
              <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="Busqueda">SISREHMED</a>
              </div>
              <div class="navbar-collapse collapse">
              </div>
            </div>
        </div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<form method="get" action="Director">
					<input id="inputTipo" type="hidden" name="tipoReporte">
					<ul class="nav nav-sidebar">
						<li><h4 style="color: #555">REPORTES</h4></li>
						<li><label for="fechaIn">Desde:</label>
							<div class="input-group date input-sidebar">
								<input type="text" name="fechaIn"
									class="form-control input-medium" placeholder="DD/MM/AAAA" value="${fechaInicio}">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-calendar"></i> </span>
							</div></li>
						<li><label for="fechaFin">Hasta:</label>
							<div class="input-group date input-sidebar">
								<input type="text" name="fechaFin"
									class="form-control input-medium" placeholder="DD/MM/AAAA" value="${fechaFinal}">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-calendar"></i> </span>
							</div></li>
							<li class="divider"></li>
						<li>
							<div id="medico">
								<label for="medico">Porcentaje de ocupación de médico</label> <select
									class="input-sidebar form-control" name="medico"
									style="width: 80%;">
									<%
                            String medicosJSON = (String)request.getAttribute("medicos");
                        	JSONArray medicos = Utilidades.obtenerArrayJSON(medicosJSON, "medicos");
                            for (int i=0; i<medicos.size();i++){
                            	JSONObject actual = (JSONObject)medicos.get(i);
                                out.print("<option value='"+actual.get("id")+"'>"+actual.get("nombre")+"</option>");
                            }

                         %>
								</select>
							</div>
						</li>
						<li><button onclick="cambiarTipoReporte('indicadoresMedico')"
								class="btn btn-primary btn-sm btn-block input-sidebar">
								<b>Ver porcentaje</b>
							</button></li>
						<li class="divider"></li>
						<li>
							<div id="medico">
								<label for="medico">Porcentaje de ocupación de box</label> <select
									class="input-sidebar form-control" name="box"
									style="width: 80%;">
									<%
                            String boxJSON = (String)request.getAttribute("boxes");
                        	JSONArray boxes = Utilidades.obtenerArrayJSON(boxJSON, "boxes");
                            for (int i=0; i<boxes.size();i++){
                            	JSONObject actual = (JSONObject)boxes.get(i);
                                out.print("<option value='"+actual.get("id")+"'>"+actual.get("nombre")+"</option>");
                            }

                         %>
								</select>
							</div>
						</li>
						<li><button onclick="cambiarTipoReporte('indicadoresBox')"
								class="btn btn-primary btn-sm btn-block input-sidebar">
								<b>Ver porcentaje</b>
							</button></li>
						<li class="divider"></li>
						<li><button
								onclick="cambiarTipoReporte('medicosMasSolicitados')"
								class="btn btn-primary btn-sm btn-block input-sidebar">
								<b>Ver médicos más solicitados</b>
							</button></li>
						<li class="divider"></li>
						<li><button
								onclick="cambiarTipoReporte('pacientesQueMasReservan')"
								class="btn btn-primary btn-sm btn-block input-sidebar">
								<b>Ver pacientes que más reservan</b>
							</button></li>
						<li class="divider"></li>

					</ul>
				</form>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<% 
                String mensaje = (String)request.getAttribute("mensaje");
                if(mensaje!=null&&mensaje!=""){ %>
				<div style="padding-left: 26%;"
					class="alert alert-${tipoMensaje} alert-dismissable mensaje">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<strong>¡${tipoMensaje}!</strong> ${mensaje}
				</div>
				<% } 
            	String tipo = (String)request.getAttribute("tipo");
            	if(tipo!=null){
            %>

				<%
				if(tipo=="indicadoresMedico"){
					%>
					<h2 class="sub-header" style="padding-top: -13px; margin-top: -13px;">Indicadores de ocupación del médico <i><% out.print(request.getAttribute("nombreMedico")); %></i> en el rango <i>${fechaInicio} - ${fechaFinal}</i></h2>
					<blockquote>
				  		<p>Porcentaje de ocupación del médico en el rango dado:   <b style="font-size: 2.5em;padding-top:230px;"><% out.print(request.getAttribute("indicadoresMedico")+"%"); %></b></p>
					</blockquote>
					<%
				}
				else if (tipo == "indicadoresBox"){
					%>
					<h2 class="sub-header" style="padding-top: -13px; margin-top: -13px;">Indicadores de ocupación de box <i><% out.print(request.getAttribute("nombreBox")); %></i> en el rango <i>${fechaInicio} - ${fechaFinal}</i></h2>
					<blockquote>
				  		<p>Porcentaje de ocupación del box en el rango: <b style="font-size: 2.5em;padding-top:5px;"><% out.print(request.getAttribute("indicadoresBox")+"%"); %></b></p>
					</blockquote>
					<%
				}
				else if (tipo=="medicosMasSolicitados"||tipo=="pacientesQueMasReservan"){
					String entidad;
					if(tipo=="medicosMasSolicitados"){
						entidad = "Médico";
						%>
						<h2 class="sub-header" style="padding-top: -13px; margin-top: -13px;">Médicos mas solicitados en el rango <i>${fechaInicio} - ${fechaFinal}</i></h2>
						<%
					}
					else{
						entidad = "Paciente";
						%>
						<h2 class="sub-header" style="padding-top: -13px; margin-top: -13px;">Pacientes que mas reservaron en el rango <i>${fechaInicio} - ${fechaFinal}</i></h2>
						<%
					}
				%>
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>#</th>
								<th><% out.print(entidad); %></th>
								<th>Cantidad de horas reservadas</th>
							</tr>
						</thead>
						<tbody>
							<%
							String entidadesMasJSON;
							JSONArray entidadesMas= new JSONArray();
							if (tipo.equals("medicosMasSolicitados")) {
								entidadesMasJSON = (String) request.getAttribute("medicosMasSolicitados");
								entidadesMas = Utilidades.obtenerArrayJSON(entidadesMasJSON, "medicos");
							}
							else{
								entidadesMasJSON = (String) request.getAttribute("pacientesQueMasReservan");
								entidadesMas = Utilidades.obtenerArrayJSON(entidadesMasJSON, "pacientes");
							}
							
							for (int i = 0; i < entidadesMas.size(); i++) {
								JSONObject actual = (JSONObject) entidadesMas.get(i);	
								out.print("<tr>");
								out.print("<td>"+(i+1)+"</td>");
								out.print("<td>"+actual.get("nombre")+"</td>");
								out.print("<td>"+actual.get("cantidad")+"</td>");
								out.print("<tr>");
							}

						%>

						</tbody>
					</table>
				</div>
				<% }
				} %>
			</div>
		</div>
	</div>

</body>
</html>
