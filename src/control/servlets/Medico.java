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
 * Servlet implementation class Medico
 */
@WebServlet("/Medico")
public class Medico extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	SISREHMED_WS ws = new SISREHMED_WSProxy();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Medico() {
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
    	String tipo=request.getParameter("tipoLlamado");
    	String fechaIn,fechaFin;
    	int idMedico;
    	if (tipo!=null){
    		fechaIn = request.getParameter("fechaIn");
    		fechaFin = request.getParameter("fechaFin");
    		idMedico = Integer.valueOf(request.getParameter("medico"));
    		if (fechaIn.equals("")||fechaFin.equals("")) {
    			java.util.Date fecha=new java.util.Date();
    			fechaIn=String.format("%02d",fecha.getDate())+"/"+String.format("%02d",fecha.getMonth()+1)+"/"+(fecha.getYear()+1900);
    			fechaFin=fechaIn;
    		}
    		System.out.println(ws.buscarSusHorasMedicas(idMedico, fechaIn, fechaFin));
    		request.setAttribute("horasDeMedico", ws.buscarSusHorasMedicas(idMedico, fechaIn, fechaFin));
    		request.setAttribute("fechaInicio", fechaIn);
        	request.setAttribute("fechaFinal", fechaFin);
    	}
    	else{
    		request.setAttribute("fechaInicio", "28/05/2015");
        	request.setAttribute("fechaFinal", "06/06/2015");
    	}
    	
    	request.getRequestDispatcher("vista/medico.jsp").forward(request, response);
    	
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
