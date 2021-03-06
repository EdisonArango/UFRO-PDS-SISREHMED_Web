package control.servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import control.util.Utilidades;
import control.webservices.SISREHMED_WS;
import control.webservices.SISREHMED_WSProxy;

/**
 * Servlet implementation class Reserva
 */
@WebServlet("/Reserva")
public class Reserva extends HttpServlet {
	private static final long serialVersionUID = 1L;
	SISREHMED_WS ws = new SISREHMED_WSProxy();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Reserva() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
    	String tipo = request.getParameter("tipo");
    	RequestDispatcher rd = request.getRequestDispatcher(Utilidades.referer(request));
    	HttpSession sesion = request.getSession();
    	if(tipo==null){
    		rd.forward(request, response);
    	}
    	
    	switch (tipo) {
		case "APS":
			if(sesion.getAttribute("id")==null){
				sesion.setAttribute("mensaje", "danger;Error!;No esta autorizado para realizar esta acción");
				response.sendRedirect("");
				return;
			}
			else if(!sesion.getAttribute("rol").equals("paciente")){
				sesion.setAttribute("mensaje", "danger;Error!;No esta autorizado para realizar esta acción");
				response.sendRedirect("");
				return;
			}
			int idHoraMedica = Integer.valueOf(request.getParameter("id"));
			String paciente = request.getParameter("paciente");
			int idPaciente;
			if(Utilidades.isNumeric(paciente)){
				idPaciente = Integer.valueOf(paciente);
				String resultadoReserva = ws.reservarHoraAPS(idHoraMedica, idPaciente);
				if(Utilidades.isNumeric(resultadoReserva)){
					sesion.setAttribute("mensaje", "success;Bien!;Se ha reservado la hora médica, número de reserva: "+resultadoReserva);
					rd.forward(request, response);
				}
				else{
					sesion.setAttribute("mensaje", "danger;Error!;"+resultadoReserva);
					rd.forward(request, response);
				}
			}
			else{
				sesion.setAttribute("mensaje", "danger;Error!;Error en los parámetros");
				rd.forward(request, response);
			}
			break;
		case "control"://Solo reserva una hora, se pueden reservar horas consecutivas también
			int[] idHoras = {Integer.valueOf(request.getParameter("id"))};
			String pacient = request.getParameter("paciente");
			int idPacient;
			if(Utilidades.isNumeric(pacient)){
				idPacient = Integer.valueOf(pacient);
				String resultadoReserva = ws.reservarHoraControl(Utilidades.enterosACadena(idHoras), idPacient);
//				System.out.println("Resultado reserva: "+resultadoReserva);
				if(Utilidades.isNumeric(resultadoReserva.substring(0, 1))){
					sesion.setAttribute("mensaje", "success;Bien!;Se han reservado las horas médicas, número de reserva: "+resultadoReserva.substring(0, resultadoReserva.length()));
					rd.forward(request, response);
				}
				else{
					sesion.setAttribute("mensaje", "danger;Error!;"+resultadoReserva);
					rd.forward(request, response);
				}
			}
			else{
				sesion.setAttribute("mensaje", "danger;Error!;Error en los parámetros");
				rd.forward(request, response);
			}
			break;
		default:
			break;
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
