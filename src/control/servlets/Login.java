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
		if(tipo==null){
			tipo = "login";
		}
		switch (tipo){
			case "login":
				String datosUsuario = request.getParameter("datos");
				SISREHMED_WS ws = new SISREHMED_WSProxy();
				String respuestaJSON = ws.loginPacienteFacebook(datosUsuario);
				Object obj=JSONValue.parse(respuestaJSON);
				JSONObject respuesta = (JSONObject)obj;
				if (respuesta.get("mensaje").toString().startsWith("success")){
					sesion.setAttribute("id",respuesta.get("id").toString());
					sesion.setAttribute("id_facebook",respuesta.get("id_facebook").toString());
					sesion.setAttribute("nombre",respuesta.get("nombre").toString());
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
