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
                <a class="navbar-brand" href="#">SISREHMED</a>
              </div>
              <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right" style="padding-right: 15px">
                        <li><a href="#">Ingresar al sistema</a></li>
                    </ul>
              </div>
            </div>
        </div>

        <div class="container-fluid">
        <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <form method="get" action="Busqueda">
            <ul class="nav nav-sidebar">
              <li><h4 style="color: #555">BUSQUEDA</h4></li>
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
                        	JSONArray especialidades = Utilidades.obtenerArrayJSON(medicosJSON, "especialidades");
                            for (int i=0; i<especialidades.size();i++){
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
                      <input type="text" name="fechaIn" class="form-control input-medium" placeholder="DD/MM/AAAA">
                      <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i>
                      </span>
                  </div>
              </li>
              <li>
                  <label for="fechaFin">Hasta:</label>
                  <div class="input-group date input-sidebar">
                      <input type="text" name="fechaFin" class="form-control input-medium" placeholder="DD/MM/AAAA">
                      <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i>
                      </span>
                  </div>
              </li>
              <li><button type="submit" class="btn btn-inverse btn-sm btn-block input-sidebar"><b>Buscar</b></button></li>

            </ul>
          </form> 
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            
            <% 
                String mensaje = (String)request.getAttribute("mensaje");
                if(mensaje!=null&&mensaje!=""){ %>
                <div style="padding-left: 26%;" class="alert alert-${tipoMensaje} alert-dismissable mensaje">
                      <button type="button" class="close" data-dismiss="alert">&times;</button>
                      <strong>¡Lo sentimos!</strong> ${mensaje}
                </div>
            <% } %>
                 
            <h2 class="sub-header" style="padding-top: -13px;margin-top: -13px;">Resultados de la busqueda</h2>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>#</th>
                  <%
//                       ArrayList<String> fechasRango = (ArrayList<String>)request.getAttribute("fechasRango");
//                       if (fechasRango!=null) {  
//                       for(int i=0; i<fechasRango.size(); i++){
//                           out.print("<th>"+fechasRango.get(i)+"</th>");
//                       }
//                       }
                  %>
                </tr>
              </thead>
              <tbody>
                  <%
//                       ArrayList<HoraMedica> horasLibres = (ArrayList<HoraMedica>)request.getAttribute("horasLibres");
//                       String tipoBusqueda = (String)request.getAttribute("tipoBusqueda");
//                       if (horasLibres!=null) {
                              
//                         for (int i=0;i<24;i++){
//                             out.print("<tr>");
//                             out.print("<td>"+i+":00</td>");
//                             for(int j=0; j<fechasRango.size(); j++){
                                
//                                 if (tipoBusqueda.equals("busquedaPorMedico")) {
//                                    HoraMedica horaEnCalendario = Utilidades.horaEnCalendario(horasLibres, fechasRango, i, j);
//                                     if (horaEnCalendario != null) {
//                                          out.print("<td><button class='btn'>Reservar</button></td>");   
//                                      }
//                                     else{
//                                         out.print("<td><p style='padding-left:20px;'>----</p></td>");
//                                     }     
//                                 }
                                
//                                 else if(tipoBusqueda.equals("busquedaPorEspecialidad")){
//                                     ArrayList<HoraMedica> horasEnCalendario = Utilidades.horasEnCalendario(horasLibres, fechasRango, i, j);
//                                     if (!horasEnCalendario.isEmpty()) {
                                        %>
                                            <td>
                                                <div class="btn-group">
                                                <button type="button" style="margin-right:0; margin-left: 0;" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                                  Reservar con: <span class="caret"></span>
                                                </button>
                                                <ul class="dropdown-menu" role="menu">
                                                <%
//                                                     for (int k=0; k<horasEnCalendario.size();k++){
//                                                         out.print("<li><a href='#'>"+horasEnCalendario.get(k).medico.getNombre()+"</a></li>");
//                                                     }         
                                                %>
                                                </ul>
                                                </div>
                                            </td>    
                                        <%   
//                                     }
//                                     else{
//                                         out.print("<td><p style='padding-left:20px;'>----</p></td>");
//                                     } 
//                                 }

//                             }
//                             out.print("</tr>");
//                         }
//                       }
                   %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
        </div>
    </body>
</html>
