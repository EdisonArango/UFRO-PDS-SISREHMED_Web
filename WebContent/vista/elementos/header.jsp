<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>

		 // This is called with the results from from FB.getLoginStatus().
	    function statusChangeCallback(response) {
	      console.log('statusChangeCallback');
	      console.log(response);
	      // The response object is returned with a status field that lets the
	      // app know the current login status of the person.
	      // Full docs on the response object can be found in the documentation
	      // for FB.getLoginStatus().
	      if (response.status === 'connected') {
	        // Logged into your app and Facebook.
	        login();
	      } else if (response.status === 'not_authorized') {
	        // The person is logged into Facebook, but not your app.
	        document.getElementById('status').innerHTML = 'Please log ' +
	          'into this app.';
	      } else {
	        // The person is not logged into Facebook, so we're not sure if
	        // they are logged into this app or not.
	        document.getElementById('status').innerHTML = 'Please log ' +
	          'into Facebook.';
	      }
	    }
		 
	 	// This function is called when someone finishes with the Login
	    // Button.  See the onlogin handler attached to it in the sample
	    // code below.
	    function checkLoginState() {
	      FB.getLoginStatus(function(response) {
	        statusChangeCallback(response);
	      });
			
	    }
 
		  window.fbAsyncInit = function() {
		    FB.init({
		      appId      : '891055737607772',
		      xfbml      : true,
		      version    : 'v2.3'
		    });
		    
		 // Now that we've initialized the JavaScript SDK, we call 
		    // FB.getLoginStatus().  This function gets the state of the
		    // person visiting this page and can return one of three states to
		    // the callback you provide.  They can be:
		    //
		    // 1. Logged into your app ('connected')
		    // 2. Logged into Facebook, but not your app ('not_authorized')
		    // 3. Not logged into Facebook and can't tell if they are logged into
		    //    your app or not.
		    //
		    // These three cases are handled in the callback function.

		    FB.getLoginStatus(function(response) {
// 			        estado();
			        /* make the API Graph call */
		       		<% if(session.getAttribute("id_facebook")!=null){ %>
		       			imagenPerfil('<%=session.getAttribute("id_facebook")%>');
		       		<% } %>
		    });
		  };
		
		  (function(d, s, id){
		     var js, fjs = d.getElementsByTagName(s)[0];
		     if (d.getElementById(id)) {return;}
		     js = d.createElement(s); js.id = id;
		     js.src = "//connect.facebook.net/es_LA/sdk.js";
		     fjs.parentNode.insertBefore(js, fjs);
		   }(document, 'script', 'facebook-jssdk'));
		  
		  function login() {
			    console.log('Welcome!  Fetching your information.... ');
			    FB.api('/me', function(response) {
			      console.log('Successful login for: ' + response.name);
// 			      document.getElementById('status').innerHTML =
// 			        'Gracias por loguearse '+response.name+", " + JSON.stringify(response) + '!';
		    	  $("#login-datos").val(JSON.stringify(response));
		    	  $("#form-login").submit();
			    });
		}
		  
		  function estado() {
			    console.log('Welcome!  Fetching your information.... ');
			    FB.api('/me', function(response) {
			      console.log('Successful login for: ' + response.name);
			      document.getElementById('status').innerHTML =
			        'Gracias por loguearse '+response.name+", " + JSON.stringify(response) + '!';
			    });
			}
		  
		  function imagenPerfil(id) {
			  FB.api('/'+id+'/picture?type=square', function(response) {
						$("#imagen-perfil").attr("src",response.data.url);
			    });
		  }
		  
		$(document).ready(function() {
			
			$('#li-menu-login').click(function (e) {
		        e.stopPropagation();
		    });
			
		});
		</script>
		<form id="form-login" method="post" action="Login">
			<input type="hidden" name="tipo" value="login-facebook">
			<input type="hidden" id="login-datos" name="datos" value="">		
		</form>
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
               
              <% if(session.getAttribute("id")!=null){ %>
                 <ul class="nav navbar-nav navbar-right" style="padding-right: 15px;">
                    <li class="dropdown">
                        <a href="#" style="padding:0px;padding-top:10px;" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <span>
                        <% if(session.getAttribute("id_facebook")!=null){ %>
                        	<img id="imagen-perfil" style="width:30px;height:30px;border: 1px solid #FFFFFF;" src="">
                        <%} else{ %>
                        	<img  style="width:30px;height:30px;border: 1px solid #FFFFFF;" src="vista/recursos/profile.png">
                        <% } %>
                        </span>
                        <strong><%=session.getAttribute("nombre")%></strong>
                         <span class="caret"></span></a>
                        <ul class="dropdown-menu" style="margin-top:10px;">
                          <li><a href="Busqueda">Busqueda de cupos</a></li>
                          <% if(session.getAttribute("rol").equals("administrador")) {%>
                          <li><a href="Admin">Administración</a></li>
                          <% } else if(session.getAttribute("rol").equals("medico")) {%>
                          <li><a href="Medico">Médico</a></li>
                          <% } else  if(session.getAttribute("rol").equals("director")) {%>
                          <li><a href="Director">Dirección</a></li>
                          <% } %>
                          <li><a href="Login?tipo=cerrarSesion">Cerrar Sesión</a></li>
                        </ul>
                    </li>
                </ul>
               <% } else {%>
              	<ul class="nav navbar-nav navbar-right" style="padding-right: 15px">
                 	<li>
                 	<!-- Login -->
                 	<a class="dropdown-toggle" href="#" data-toggle="dropdown">Iniciar sesión<strong class="caret"></strong></a>
                 	<ul class="dropdown-menu">
                 		<li style="width:305px;padding:10px;" id="li-menu-login">
                 		<p class="text-center"> 
                 			<fb:login-button scope="public_profile,email" data-size="xlarge" onlogin="checkLoginState();"></fb:login-button> 
               			</p>
						<div class="divider"></div>
						<form method="post" action="Login" accept-charset="UTF-8">
							<input type="hidden" name="tipo" value="login">
							<div class="input-group" style="margin-bottom: 10px;">
								<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								<input type="text" class="form-control" placeholder="Correo o Usuario" id="usuario" name="usuario">
							</div>
										
							<div class="input-group" style="margin-bottom: 15px;">
								<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
								<input  type="password" class="form-control" placeholder="Contraseña" id="pass" name="pass">
							</div>
							<button class="btn btn-primary" style="margin-bottom: 15px;float:right;" type="submit"><b>Iniciar sesión</b></button>
						</form>
						</li>
					</ul>
                 	</li>
                 </ul>
                 
                 <%} %>
<!--                  <ul class="nav navbar-nav navbar-right" style="padding-right: 15px"> -->
<!--                      <li><a href="Medico">Ingreso de médicos</a></li> -->
<!--                  </ul> -->
<!--                  <ul class="nav navbar-nav navbar-right" style="padding-right: 15px"> -->
<!--                      <li><a href="Director">Ingreso de director</a></li> -->
<!--                  </ul> -->
              </div>
            </div>
        </div>