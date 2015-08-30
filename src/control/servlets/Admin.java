package control.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import control.util.Utilidades;
import control.webservices.SISREHMED_WS;
import control.webservices.SISREHMED_WSProxy;

/**
 * Servlet implementation class Admin
 */
@WebServlet("/Admin")
public class Admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String tipo = request.getParameter("tipo");
    	if(tipo==null){
    		tipo = "";
    	}
    	HttpSession sesion = request.getSession();
		SISREHMED_WS ws = new SISREHMED_WSProxy();
    	switch (tipo) {
		case "nuevo-cupo":
			String fecha = request.getParameter("fecha");
			String hora = request.getParameter("hora-hora")+":"+request.getParameter("hora-minutos");
			String aps = request.getParameter("aps");
			String idMedico = request.getParameter("medico");
			String idBox = request.getParameter("box");
			
			if(fecha == null || fecha.equals("")||hora == null ||hora.equals("")||aps == null ||aps.equals("")||idMedico == null ||idMedico.equals("")||idBox == null ||idBox.equals("")){
				sesion.setAttribute("mensaje", "warning;Parámetros Incompletos!;Por favor ingrese todos los parámetros");
			}
			else{
				JSONObject respuesta = Utilidades.stringAJSONObject(ws.crearCupo(fecha, hora, aps, idMedico, idBox));
				sesion.setAttribute("mensaje", respuesta.get("mensaje"));
			}
			response.sendRedirect("Admin");
			break;
			
		case "":
			if(request.getParameter("funcion") == null || request.getParameter("funcion").equals("nuevo-cupo")){
				request.setAttribute("medicos", ws.obtenerTodosLosMedicos());
				request.setAttribute("boxes", ws.obtenerBoxes());
			}
			request.getRequestDispatcher("vista/admin.jsp").forward(request, response);
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
		processRequest(request,response);
	}

}
