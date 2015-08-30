package control.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import control.util.Utilidades;
import control.webservices.SISREHMED_WS;
import control.webservices.SISREHMED_WSProxy;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String tipo = request.getParameter("tipo");
		HttpSession sesion = request.getSession();
		if(tipo==null||tipo==""){
			sesion.setAttribute("mensaje", "danger;Error!;Parámetros inválidos");
			response.sendRedirect("");
			return;
		}
		SISREHMED_WS ws = new SISREHMED_WSProxy();
		switch (tipo){
			case "login":
				String usuario = request.getParameter("usuario");
				String pass = request.getParameter("pass");
				if (usuario == null || usuario.equals("")){
					sesion.setAttribute("mensaje", "warning;Usuario Faltante!;Ingrese el usuario");
					response.sendRedirect("");
					return;
				}
				else if(pass == null || pass.equals("")){
					sesion.setAttribute("mensaje", "warning;Contraseña faltante!;Ingrese la contraseña");
					response.sendRedirect("");
					return;
				}
				String respuest = ws.login(usuario, pass);
				Object object=JSONValue.parse(respuest);
				JSONObject resp = (JSONObject)object;
				String next = "";
				if (resp.get("mensaje").toString().startsWith("success")){
					sesion.setAttribute("id",resp.get("id").toString());
					sesion.setAttribute("nombre",resp.get("nombre").toString());
					sesion.setAttribute("rol",resp.get("rol").toString());
					if (resp.get("rol").toString().equals("administrador")){
						next = "Admin";
					}
					else if (resp.get("rol").toString().equals("medico")){
						next = "Medico";
					}
					else if (resp.get("rol").toString().equals("director")){
						next = "Director";
					}
				}
				sesion.setAttribute("mensaje", resp.get("mensaje").toString());
				response.sendRedirect(next);
				break;
			case "login-facebook":
				String datosUsuario = request.getParameter("datos");
				String respuestaJSON = ws.loginPacienteFacebook(datosUsuario);
				Object obj=JSONValue.parse(respuestaJSON);
				JSONObject respuesta = (JSONObject)obj;
				if (respuesta.get("mensaje").toString().startsWith("success")){
					sesion.setAttribute("id",respuesta.get("id").toString());
					sesion.setAttribute("id_facebook",respuesta.get("id_facebook").toString());
					sesion.setAttribute("nombre",respuesta.get("nombre").toString());
					sesion.setAttribute("rol","paciente");
				}
				sesion.setAttribute("mensaje", respuesta.get("mensaje").toString());
				response.sendRedirect("");
				break;
			case "cerrarSesion":
				sesion.invalidate();
				response.sendRedirect("");
				break;
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
