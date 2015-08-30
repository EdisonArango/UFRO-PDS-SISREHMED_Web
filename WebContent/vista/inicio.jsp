<%-- 
    Document   : inicio
    Created on : 11-may-2015, 1:44:17
    Author     : edisonarango
--%>

<%@page import="control.util.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Date"%>
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
            <form method="get" action="Busqueda">
            <ul class="nav nav-sidebar">
              <li><h4 style="color: #555">BÚSQUEDA</h4></li>
              <li>
                    <select onchange="cambiarTipoBusqueda()" id="selectTipo" class="input-sidebar form-control" name="tipo" style="width:80%;">
                        <option value="medico">Búsqueda por médico</option>
                        <option value="especialidad">Búsqueda por especialidad</option>
                    </select>
              </li>
              <li>
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
                  <div id="especialidad" style="display: none;">
                    <label for="especialidad">Especialidad</label>
                    <select class="input-sidebar form-control" name="especialidad" style="width:80%;">
                        <%
                        	String especialidadesJSON = (String)request.getAttribute("especialidades");
                        	JSONArray especialidades = Utilidades.obtenerArrayJSON(especialidadesJSON, "especialidades");
                            for (int i=0; i<especialidades.size();i++){
                            	JSONObject actual = (JSONObject)especialidades.get(i);
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
           
          <p id="status"></p>
          
						<%
							String tipo = (String) request.getAttribute("tipoBusqueda");
						if (tipo!=null){ %>
						<h2 class="sub-header" style="padding-top: -13px;margin-top: -13px;">Resultados de la búsqueda</h2>
							
							<div class="row">
								<div class="col-md-3">
									<div class="btn-group" role="group">
									  <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-chevron-left"></span></button>
									  <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-chevron-right"></span></button>
									</div>
								</div>
								<div style="float:right;margin-right:20px;">
									<div class="btn-group" role="group">
									  <button type="button" id="boton-listado" class="btn btn-default"><span class="glyphicon glyphicon-list"></span></button>
									  <button type="button" id="boton-calendar" class="btn btn-dark"><span class="glyphicon glyphicon-th"></span></button>
									</div>
								</div>
							</div>
							
          					<div id="tabla-listado" style="display:none;" class="table-responsive">
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
							<% if (tipo.equals("busquedaPorMedico")) {
								String horasMedicasJSON = (String) request.getAttribute("horasLibres");
								JSONArray horasLibres = Utilidades.obtenerArrayJSON(horasMedicasJSON, "horasEncontradas");
								for (int i = 0; i < horasLibres.size(); i++) {
									JSONObject actual = (JSONObject) horasLibres.get(i);
									String hora = (String)actual.get("hora");
// 									String hora = Utilidades.obtenerHoraDeNumero(numeroHora) + " - " + Utilidades.obtenerHoraDeNumeroFin(numeroHora+1);		
									out.print("<tr>");
									out.print("<td>"+hora+"</td>");
									out.print("<td>"+actual.get("fecha")+"</td>");
									out.print("<td>"+actual.get("box")+"</td>");
									out.print("<td><button class='btn btn-primary' data-toggle='modal' data-target='#modalReserva' data-idhora='"+actual.get("id")+"' data-hora='"+actual.get("hora")+"' data-fecha='"+actual.get("fecha")+"' data-box='"+actual.get("box")+"'>Reservar</button></td>");
									out.print("<tr>");
								}
							}
							else if(tipo.equals("busquedaPorEspecialidad")){
								String horasMedicasJSON = (String) request.getAttribute("horasLibres");
								JSONArray horasLibres = Utilidades.obtenerArrayJSON(horasMedicasJSON, "horasEncontradas");
								ArrayList<Integer> abiertos = new ArrayList<Integer>();
								for (int i = 0; i < horasLibres.size(); i++) {
									if(Utilidades.estaEnArray(abiertos, i)){
										continue;
									}
									JSONObject actual = (JSONObject) horasLibres.get(i);
									int numeroHora = Integer.valueOf((String)actual.get("hora"));
									String hora = Utilidades.obtenerHoraDeNumero(numeroHora) + " - " + Utilidades.obtenerHoraDeNumeroFin(numeroHora+1);		
									out.print("<tr>");
									out.print("<td>"+hora+"</td>");
									out.print("<td>"+actual.get("fecha")+"</td>");
									out.print("<td>"+actual.get("box")+"</td>");
									ArrayList<Integer> indicesIguales = Utilidades.indicesDeHorasIguales(horasLibres, i);
									
									if(indicesIguales.size()==0){
										out.print("<td><button class='btn btn-primary' data-toggle='modal' data-target='#modalReserva' data-idhora='"+actual.get("id")+"' data-hora='"+actual.get("hora")+"' data-fecha='"+actual.get("fecha")+"' data-box='"+actual.get("box")+"'>Reservar con: "+actual.get("medico")+"</button></td>");
// 										out.print("<li><a href='#' data-toggle='modal' data-target='#modalReserva' data-idhora='"+actual.get("id")+"'>"+actual.get("medico")+"</a></li>");
									}
									else{
										%>
										<td>
										<div class="btn-group">
										<button type="button" style="margin-right: 0; margin-left: 0;"
											class="btn btn-default dropdown-toggle" data-toggle="dropdown">
											Reservar con: <span class="caret"></span>
										</button>
										<ul class="dropdown-menu" role="menu">
										<%
										out.print("<li><a href='#' data-toggle='modal' data-target='#modalReserva' data-idhora='"+actual.get("id")+"' data-hora='"+actual.get("hora")+"' data-fecha='"+actual.get("fecha")+"' data-box='"+actual.get("box")+"'>"+actual.get("medico")+"</a></li>");
										for (int j=0; j<indicesIguales.size();j++){
											out.print("<li><a href='#' data-toggle='modal' data-target='#modalReserva' data-idhora='"+actual.get("id")+"' data-hora='"+actual.get("hora")+"' data-fecha='"+actual.get("fecha")+"' data-box='"+actual.get("box")+"'>"+((JSONObject)horasLibres.get(indicesIguales.get(j))).get("medico")+"</a></li>");
										}
										abiertos.addAll(indicesIguales);
										%>
										<li><a href="#"></a></li>
										</ul>
										<td>
										<%
									}
									
									out.print("<tr>");
								}
							} %>				
						</tbody>
					</table>
			</div>
			
			
			<div id="tabla-calendar" class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>#</th>
                  <%
                      	Date fechaActual = Utilidades.stringADate((String)request.getAttribute("fechaInicio"));
                  		Date fechaFinal = Utilidades.stringADate((String)request.getAttribute("fechaFinal"));
                  		fechaFinal.setDate(fechaFinal.getDate()+1);
                      	while(!fechaActual.equals(fechaFinal)){
                          out.print("<th>"+Utilidades.dateAString(fechaActual)+"</th>");
                          fechaActual.setDate(fechaActual.getDate()+1);
                      	}
                  %>
                </tr>
              </thead>
              <tbody>
                  <%
                  	String horasMedicasJSON = (String) request.getAttribute("horasLibres");
					JSONArray horasLibres = Utilidades.obtenerArrayJSON(horasMedicasJSON, "horasEncontradas");
					for (int i = 0; i < horasLibres.size(); i++) {
						JSONObject actual = (JSONObject) horasLibres.get(i);
						out.print("<tr>");
                        out.print("<td>"+actual.get("hora")+"</td>");
						fechaActual = Utilidades.stringADate((String)request.getAttribute("fechaInicio"));
                  		fechaFinal = Utilidades.stringADate((String)request.getAttribute("fechaFinal"));
                  		fechaFinal.setDate(fechaFinal.getDate()+1);
                      	while(!fechaActual.equals(fechaFinal)){
                      		if (tipo.equals("busquedaPorMedico")) {
                                 if (Utilidades.dateAString(fechaActual).equals((String)actual.get("fecha"))) {
                                      out.print("<td><button class='btn'>Reservar</button></td>");   
                                  }
                                 else{
                                     out.print("<td><p style='padding-left:20px;'>----</p></td>");
                                 }     
                             }
//                       		else if(tipo.equals("busquedaPorEspecialidad")){
//                                 ArrayList<HoraMedica> horasEnCalendario = Utilidades.horasEnCalendario(horasLibres, fechasRango, i, j);
//                                 if (!horasEnCalendario.isEmpty()) {
                                    %>
<!--                                         <td> -->
<!--                                             <div class="btn-group"> -->
<!--                                             <button type="button" style="margin-right:0; margin-left: 0;" class="btn btn-default dropdown-toggle" data-toggle="dropdown"> -->
<!--                                               Reservar con: <span class="caret"></span> -->
<!--                                             </button> -->
<!--                                             <ul class="dropdown-menu" role="menu"> -->
                                            <%
//                                                 for (int k=0; k<horasEnCalendario.size();k++){
//                                                     out.print("<li><a href='#'>"+horasEnCalendario.get(k).medico.getNombre()+"</a></li>");
//                                                 }         
                                            %>
<!--                                             </ul> -->
<!--                                             </div> -->
<!--                                         </td>     -->
                                    <%   
//                                 }
//                                 else{
//                                     out.print("<td><p style='padding-left:20px;'>----</p></td>");
//                                 } 
//                             }
                        fechaActual.setDate(fechaActual.getDate()+1);
                      	}
                      	out.print("</tr>");
					}
                                
                   %>
              </tbody>
            </table>
          </div>
			
			
			<%} else {%>
				<p class="text-center lead" style="margin-top:25%;">  -- Sin resultados -- <br> Realice una busqueda en el formulario de la sección izquierda </p>
			<%} %>
        </div>
      </div>
        </div>
        
        <!-- Modal -->
        <div class="modal fade" id="modalReserva" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h3 class="modal-title" id="exampleModalLabel">
		        <% if(session.getAttribute("id")!=null){ 
			        	if (session.getAttribute("rol").equals("paciente")){
			        		out.print("Reservar hora médica APS");
			        	}
			        	else{
			        		out.print("No puede reservar");
			        	}
		        	}
		        	else{
		        		out.print("Inicio de sesión requerido");
		        	}
	        	%>
		        </h3>
		      </div>
		      <div class="modal-body">
		      	<% 	if(session.getAttribute("id")!=null){ 
			        	if (session.getAttribute("rol").equals("paciente")){%>
			        		<div class="row">
							  <div class="col-md-4"><b>Fecha:</b> <p id="id-fecha"></p></div>
							  <div class="col-md-4"><b>Hora:</b> <p id="id-hora"></p></div>
							  <div class="col-md-4"><b>Box:</b> <p id="id-box"></p></div>
<!-- 							  <div class="col-md-3"><b>Médico:</b> <p id="id-medico"></p></div> -->
							</div>
					        <form id="formReserva" action="Reserva" method="get">
					            <input type="hidden" class="form-control" name="paciente" value="<%=session.getAttribute("id")%>">
					            <input type="hidden" class="form-control" name="id" id="id-input">
					            <input type="hidden" class="form-control" name="tipo" value="APS">
					        </form>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
					        <button id="botonReservaModal" type="button" class="btn btn-primary">Reservar</button>
					      </div>
			        	<% }
			        	else{%>
			        		<center> <p class="lead">Solo los pacientes pueden reservar horas médicas</p></center>
			        		<div class="modal-footer">
						        <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
					      	</div>
			        	<%}
		        	}
		        	else{%>
		        		<center> <p class="lead">Inicia sesión para continuar con la reserva</p></center>
		        		<div class="row">
							  <div class="col-md-4"><b>Fecha:</b> <p id="id-fecha"></p></div>
							  <div class="col-md-4"><b>Hora:</b> <p id="id-hora"></p></div>
							  <div class="col-md-4"><b>Box:</b> <p id="id-box"></p></div>
						</div>
		        		<form id="formReserva" method="post" action="Login" accept-charset="UTF-8">
							<input type="hidden" name="tipo" value="login">
							<div class="input-group" style="margin-bottom: 10px;">
								<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								<input type="text" class="form-control" placeholder="Correo o Usuario" id="usuario" name="usuario">
							</div>
										
							<div class="input-group" style="margin-bottom: 15px;">
								<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
								<input  type="password" class="form-control" placeholder="Contraseña" id="pass" name="pass">
							</div>
						</form>
						</div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
					        <button id="botonReservaModal" type="button" class="btn btn-primary">Iniciar sesión</button>
					      </div>
		        	<%}
	        	%>
		    </div>
		  </div>
		</div>
		
		<div id="fb-root"></div>
    </body>
</html>
