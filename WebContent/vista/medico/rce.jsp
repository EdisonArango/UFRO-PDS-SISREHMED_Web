<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="stylesheet" href="../lib/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="../lib/bootstrap-datepicker/css/bootstrap-datepicker3.min.css"/>
        <link rel="stylesheet" href="../css/estilos.css"/>
        <!--<link rel="stylesheet" href="lib/bootstrap/css/bootstrap-theme.min.css"/>-->
        
        <script src="../lib/jquery1.11.2.js"></script>      
        <script src="../lib/bootstrap/js/bootstrap.min.js"></script>
        <script src="../lib/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script> 
        <script src="../lib/bootstrap-datepicker/locales/bootstrap-datepicker.es.min.js"></script> 
        <script type="text/javascript" src="../js/funciones.js"></script>
        
        <title>Sistema de Reserva de Horas Médicas</title>
    </head>
<body>
<div style="margin-left:10px;margin-right:10px;">
	<form method="post">
		<div class="row borde">
			<div class="col-md-10"><h3>Datos de atención del día 30/05/2014 12:34</h3></div>
			<div class="col-md-2"><a class="btn btn-primary" style="margin-top:13px;" href="#">Ver historial clínico</a></div>
		</div>
		<div class="row borde">
			<div class="col-md-3">Paciente: <b>Edison Arango</b></div>
			<div class="col-md-3">Motivo consulta: <b>Problemas pulmonares</b></div>
		</div>
		<h4>Registro clínico</h4><div class="row borde margenAbajo"></div>
		<div class="row">
			<div class="col-md-6"><textarea name="anamnesis" placeholder="ANAMNESIS" class="form-control" rows="3"></textarea></div>
			<div class="col-md-6"><textarea name="alergias" placeholder="ALERGIAS" class="form-control" rows="3"></textarea></div>
		</div>
		<div class="row">
			<div class="col-md-6"><textarea name="examenfisico" placeholder="EXAMEN FÍSICO" class="form-control" rows="3"></textarea></div>
			<div class="col-md-6"><textarea name="indicacionmedica" placeholder="INDICACIÓN MÉDICA" class="form-control" rows="3"></textarea></div>
		</div>
		<div class="row margenesLaterales">
			<div><textarea name="indicacioncierre" placeholder="INDICACIÓN CIERRE CASO CLÍNICO" class="form-control" rows="3"></textarea></div>
		</div>
		<div class="row margenesLaterales">
			<textarea name="hipotesisdiagnostica" placeholder="HIPÓTESIS DIAGNOSTICA" class="form-control" rows="1"></textarea>
		</div>
		<div class="row borde">
			<div class="col-md-6" style="margin-bottom:2px;"><textarea name="diagnostico" placeholder="DIAGNÓSTICO" class="form-control" rows="3"></textarea></div>
		</div>
		
		
		<div class="row borde">
			<div class="col-md-6 bordeDerecho margenAbajo">
				<h4 class="borde">Receta:</h4>
				<h5 class="borde">Tipo de paciente y tipo de medicamento:</h5>
				<div class="row margenesLaterales borde">
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-6">Paciente GES:&nbsp;
							</div>
							  <div class="col-md-6">
							  <label class="radio-inline">
							    <input type="radio" name="pacienteges" value="si">
							    Sí
							  </label>
							  <label class="radio-inline">
							    <input type="radio" name="pacienteges" value="no" checked>
							    No
							  </label>
							 </div>
						 </div>
					</div>
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-6">Patología GES:&nbsp;
							</div>
							  <div class="col-md-6">
							  <label class="radio-inline">
							    <input type="radio" name="patologiages" value="si">
							    Sí
							  </label>
							  <label class="radio-inline">
							    <input type="radio" name="patologiages" value="no" checked>
							    No
							  </label>
							 </div>
						 </div>
					</div>
				</div>
				<div class="row margenesLaterales borde">
					<div class="col-md-6 margenArriba">
						<div class="row">
							<div class="col-md-6">Paciente Crónico:&nbsp;
							</div>
							  <div class="col-md-6">
							  <label class="radio-inline">
							    <input type="radio" name="pacientecronico" value="si">
							    Sí
							  </label>
							  <label class="radio-inline">
							    <input type="radio" name="pacientecronico" value="no" checked>
							    No
							  </label>
							 </div>
						 </div>
					</div>
					<div class="col-md-6">
							<div class="row">
							<div style="margin-top:7px;" class="col-md-4 margenesLaterales">Validez:&nbsp;</div>
							<div style="width:200px;" class="col-md-8 input-group date input-sidebar">
									<input type="text" name="fechaIn"
										class="form-control input-medium" placeholder="DD/MM/AAAA" value="">
									<span class="input-group-addon"><i
										class="glyphicon glyphicon-calendar"></i> </span>
							</div>
						</div>
					</div>
				</div>
				<div class="row margenesLaterales">
					<div class="col-md-10"><textarea name="receta" placeholder="RECETA EN MODO TEXTO" class="form-control" rows="5"></textarea></div>				
				</div>
			</div>
			<div class="col-md-6">
				<h4 class="borde">Certificados:</h4>
				<div class="row margenesLaterales">
				<% 
				String[][] datosCheckbox = 
				{{"Alcoholemia","alcoholemia"},
				 {"V. Intrafamilar","vintrafamiliar"},
				 {"Drogas","drogas"},
				 {"Lesiones","lesiones"},
				 {"Suicidio","suicidio"},
				 {"Animal","animal"},
				 {"Otros ML","otrosml"},
				 {"V. Género","vgenero"},
				 {"Salud Compatible","saludcompatible"},
				 {"Atención Diagnóstica","atenciondiagnostica"},
				 {"Atención Profesional","atencionprofesional"},
				 {"Derivación Interna","derivacioninterna"},
				 {"Citación a KNT","citacionknt"},
				 {"Orden Curación","ordencuracion"},
				 {"Orden Citación","ordencitacion"},
				};
				for (int i=0;i<datosCheckbox.length;i++){
					%>
						<div class="col-md-6">
						<div class="row">
							  <div class="col-md-5">
								  <label class="radio-inline">
								    <input type="radio" name="<%=datosCheckbox[i][1] %>" value="si">
								    Sí
								  </label>
								  <label class="radio-inline">
								    <input type="radio" name="<%=datosCheckbox[i][1] %>" value="no" checked>
								    No
								  </label>
							 </div>
							 <div class="col-md-7"><b><%=datosCheckbox[i][0] %></b></div>
						 </div>
					</div>
					
				<%}%>
				</div>	
			</div>
		</div>
		
		<div class="row borde">
			<div class="col-md-6 bordeDerecho margenAbajo">
				<h4 class="borde">Actividades:</h4>
				<div class="margenAbajo">Buscar Actividades: <input id="buscarActividades" type="text"></div>
				<select multiple id="actividad" name="actividad" class="form-control">
				  <option value="">Edison Arango</option>
				  <option value="">Brayan Arango</option>
				  <option value="">Juan Lopez</option>
				  <option value="">Carlos Perez</option>
				</select>
			</div>
			<div class="col-md-6">
				<h4 class="borde">Procedimientos:</h4>
				<div class="margenAbajo">Buscar Procedimiento: <input id="buscarProcedimiento" type="text"></div>
				<select multiple id="procedimiento" name="procedimiento" class="form-control">
				  <option value="">ASDASFDFWEF SDFDSAFDS</option>
				  <option value="">ASDASFDFWEF SDFDSAFDS</option>
				  <option value="">ASDASFDFWEF SDFDSAFDS</option>
				  <option value="">ASDASFDFWEF SDFDSAFDS</option>
				</select>
			</div>
		</div>
		
		<div class="row borde margenesLaterales">
			<h4 style="margin-bottom:0px;" class="borde">Cierre Caso:</h4>
			<div class="row borde">
				<div class="col-md-4">
				 Tipo Cierre Clínico: 
				</div>
				<div class="col-md-8"> 
					<select style="width:500px;" name="tipocierre" class="form-control">
					  <option value="conatencion">Con atención</option>
					</select>
				</div>
			</div>
			<div class="row borde">
				<div class="col-md-4">
				 Destino: 
				</div>
				<div class="col-md-8"> 
					<select style="width:500px;" name="tipocierre" class="form-control">
					  <option value="domicilio">Domicilio</option>
					</select>
				</div>
			</div>
			<div class="row borde">
				<div class="col-md-4">
				 Fecha Atención: 
				</div>
				<div class="col-md-8"> 
					<input style="width:500px;" class="form-control" name="fechaatencion" type="text" value="34/67/5666" disabled>
				</div>
			</div>
			<div class="row borde">
				<div class="col-md-4">
				 Hora Inicio Atención: 
				</div>
				<div class="col-md-8"> 
					<input style="width:500px;" class="form-control" name="horainicioatencion" type="text" value="03:45" disabled>
				</div>
			</div>
			<div class="row borde">
				<div class="col-md-4">
				 Fecha Cierre Clínico: 
				</div>
				<div class="col-md-8"> 
					<input style="width:500px;" class="form-control" name="fechacierreclinico" type="text" value="23/67/1234" disabled>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
				 Hora Cierre Clínico: 
				</div>
				<div class="col-md-8"> 
					<input style="width:500px;" class="form-control" name="horacierreclinico" type="text" value="04:00" disabled>
				</div>
			</div>
		</div>
		<br>
		<center>
		<a class="btn btn-primary" href="#">Guardar<br>No cierra caso<br>No imprime</a>
		<a class="btn btn-primary" href="#">Guardar<br>Cerrar caso<br>E imprimir PDF</a>
		<a class="btn btn-primary" href="#">Guardar<br>y ver HCE<br>&nbsp;</b></a>
		<a class="btn btn-warning" href="#">Limpiar<br>&nbsp;<br>&nbsp;</a>
		<a class="btn btn-danger" href="#">Cancelar<br>&nbsp;<br>&nbsp;</a>
		</center>
		<br>
		<br>
		<br>
	</form>
</div>
</body>
</html>