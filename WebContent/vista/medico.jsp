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
        <div id="header"></div>

        <div class="container-fluid">
        <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <form method="get" action="Medico">
            <ul class="nav nav-sidebar">
              <li><h4 style="color: #555">Rango de horario</h4></li>
              <li>
              <input type="hidden" name="tipoLlamado" value="verHorario">
                  <div id="medico">
                    <label for="medico">Médico</label>
                    <select class="input-sidebar form-control" name="medico" style="width:80%;">
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
              <li>
                  <label for="fechaIn">Desde:</label>
                  <div class="input-group date input-sidebar">
                      <input type="text" name="fechaIn" class="form-control input-medium" placeholder="DD/MM/AAAA" value="${fechaInicio}">
                      <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i>
                      </span>
                  </div>
              </li>
              <li>
                  <label for="fechaFin">Hasta:</label>
                  <div class="input-group date input-sidebar">
                      <input type="text" name="fechaFin" class="form-control input-medium" placeholder="DD/MM/AAAA" value="${fechaFinal}">
                      <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i>
                      </span>
                  </div>
              </li>
              <li><button type="submit" class="btn btn-primary btn-sm btn-block input-sidebar"><b>Buscar</b></button></li>

            </ul>
          </form> 
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <div id="mensaje"></div>
            
            <h2 class="sub-header" style="padding-top: -13px;margin-top: -13px;">Horario</h2>
          <div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Hora</th>
								<th>Fecha</th>
								<th>Box</th>
								<th>Reserva</th>
							</tr>
						</thead>
						<tbody>
						<%
							String horasDeMedico = (String) request.getAttribute("horasDeMedico");
							if (horasDeMedico!=null) {
								JSONArray horas = Utilidades.obtenerArrayJSON(horasDeMedico, "horasEncontradas");
								for (int i = 0; i < horas.size(); i++) {
									JSONObject actual = (JSONObject) horas.get(i);
									int numeroHora = Integer.valueOf((String)actual.get("hora"));
									String hora = Utilidades.obtenerHoraDeNumero(numeroHora) + " - " + Utilidades.obtenerHoraDeNumeroFin(numeroHora+1);		
									if(actual.get("reservado").equals("si")){
										out.print("<tr>");
										out.print("<td>"+hora+"</td>");
										out.print("<td>"+actual.get("fecha")+"</td>");
										out.print("<td>"+actual.get("box")+"</td>");
										out.print("<td>"+actual.get("tipo")+" con: <b>"+actual.get("paciente")+"</b></td>");
									}
									else if(actual.get("tipo").equals("Control")){
										out.print("<tr>");
										out.print("<td>"+hora+"</td>");
										out.print("<td>"+actual.get("fecha")+"</td>");
										out.print("<td>"+actual.get("box")+"</td>");
									out.print("<td><button class='btn btn-primary' data-toggle='modal' data-target='#modalReserva' data-idhora='"+actual.get("id")+"' data-hora='"+actual.get("hora")+"' data-fecha='"+actual.get("fecha")+"' data-box='"+actual.get("box")+"'>Reservar</button></td>");
									}
									out.print("<tr>");
								}
							}
						%>
										
						</tbody>
					</table>
			</div>
        </div>
      </div>
        </div>
        
        <!-- Modal -->
        <div class="modal fade" id="modalReserva" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="exampleModalLabel">Reservar hora médica de Control</h4>
		        <br>
		        <div class="row">
				  <div class="col-md-4"><b>Fecha:</b> <p id="id-fecha"></p></div>
				  <div class="col-md-4"><b>Hora:</b> <p id="id-hora"></p></div>
				  <div class="col-md-4"><b>Box:</b> <p id="id-box"></p></div>
				</div> 
		      </div>
		      <div class="modal-body">
		        <form id="formReserva" action="Reserva" method="get">
		          <div class="form-group">
		            <label for="paciente" class="control-label">Paciente:</label>
<!-- 		            <input type="text" class="form-control" name="paciente" id="paciente"> -->
					<select class="input-sidebar form-control" name="paciente" id="paciente">
                        <%
                            String pacientesJSON = (String)request.getAttribute("pacientes");
                        	JSONArray pacientes = Utilidades.obtenerArrayJSON(pacientesJSON, "pacientes");
                            for (int i=0; i<pacientes.size();i++){
                            	JSONObject actual = (JSONObject)pacientes.get(i);
                                out.print("<option value='"+actual.get("id")+"'>"+actual.get("nombre")+"</option>");
                            }

                         %>
                    </select>
		          </div>
		            <input type="hidden" class="form-control" name="id" id="id-input">
		            <input type="hidden" class="form-control" name="tipo" value="control">
	            <div class="form-group">
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
		        <button id="botonReservaModal" type="button" class="btn btn-primary">Reservar</button>
		      </div>
		    </div>
		  </div>
		</div>
    </body>
</html>
