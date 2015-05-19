package control.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import control.webservices.SISREHMED_WS;
import control.webservices.SISREHMED_WSProxy;

/**
 * Servlet implementation class Director
 */
@WebServlet("/Director")
public class Director extends HttpServlet {
	private static final long serialVersionUID = 1L;
	SISREHMED_WS ws = new SISREHMED_WSProxy();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Director() {
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
    	request.setAttribute("medicos", ws.obtenerTodosLosMedicos());
    	request.setAttribute("boxes", ws.obtenerBoxes());
    	String tipo = request.getParameter("tipoReporte");
    	String fechaIn,fechaFin;
    	if (tipo!=null) {
    		fechaIn = request.getParameter("fechaIn");
    		fechaFin = request.getParameter("fechaFin");
    		if (fechaIn.equals("")||fechaFin.equals("")) {
    			java.util.Date fecha=new java.util.Date();
    			fechaIn=String.format("%02d",fecha.getDate())+"/"+String.format("%02d",fecha.getMonth()+1)+"/"+(fecha.getYear()+1900);
    			fechaFin=fechaIn;
    		}
    		
			switch (tipo) {
			case "indicadoresMedico":
				String idMedico = request.getParameter("medico");
				request.setAttribute("tipo", "indicadoresMedico");
				request.setAttribute("nombreMedico", ws.obtenerNombreDeMedico(Integer.valueOf(idMedico)));
				request.setAttribute("indicadoresMedico", ws.obtenerPorcentajeOcupacionMedico(Integer.valueOf(idMedico), fechaIn, fechaFin)+"");
				break;
			case "indicadoresBox":
				String idBox = request.getParameter("box");
				request.setAttribute("tipo", "indicadoresBox");
				request.setAttribute("nombreBox", ws.obtenerNombreDeBox(Integer.valueOf(idBox)));
				request.setAttribute("indicadoresBox", ws.obtenerPorcentajeOcupacionBox(Integer.valueOf(idBox), fechaIn, fechaFin)+"");
				break;
			case "medicosMasSolicitados":
				request.setAttribute("tipo", "medicosMasSolicitados");
				request.setAttribute("medicosMasSolicitados", ws.obtenerMedicosMasSolicitados(fechaIn, fechaFin));
				break;
			case "pacientesQueMasReservan":
				request.setAttribute("tipo", "pacientesQueMasReservan");
				request.setAttribute("pacientesQueMasReservan", ws.obtenerPacientesQueMasReservan(fechaIn, fechaFin));
				break;
			default:
				request.getRequestDispatcher("vista/director.jsp").forward(request, response);
				break;
			}
		}
    	
    	request.getRequestDispatcher("vista/director.jsp").forward(request, response);
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
