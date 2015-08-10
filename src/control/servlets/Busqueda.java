/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;

import control.util.Utilidades;
import control.webservices.SISREHMED_WS;
import control.webservices.SISREHMED_WSProxy;

/**
 *
 * @author edisonarango
 */
@WebServlet(name = "Busqueda", urlPatterns = {"/Busqueda"})
public class Busqueda extends HttpServlet {
    
	SISREHMED_WS ws = new SISREHMED_WSProxy();

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
        HttpSession sesion = request.getSession();
        request.setAttribute("medicos", ws.obtenerTodosLosMedicos());
        request.setAttribute("especialidades", ws.obtenerEspecialidades());
        String fechaIn="",fechaFin="";
        
        if (tipo!=null) {
//        	System.out.println(tipo);
        	if(!tipo.equals("APS")){
        		fechaIn = request.getParameter("fechaIn");
        		fechaFin = request.getParameter("fechaFin");
        		if (fechaIn.equals("")||fechaFin.equals("")) {
        			java.util.Date fecha=new java.util.Date();
        			fechaIn=String.format("%02d",fecha.getDate())+"/"+String.format("%02d",fecha.getMonth()+1)+"/"+(fecha.getYear()+1900);
        			fechaFin=fechaIn;
        		}
        		request.setAttribute("fechaInicio", fechaIn);
            	request.setAttribute("fechaFinal", fechaFin);
        	}
        }
        else{
            tipo="";
        }
        
        switch (tipo) {
            case "medico":
                int idMedico=0;
                if (request.getParameter("medico")!=null&&Utilidades.isNumeric(request.getParameter("medico"))) {
                    idMedico = Integer.valueOf(request.getParameter("medico"));
                }
                else{
                    sesion.setAttribute("mensaje", "warning;Error!;No es válido el médico indicado");
                    request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
                    return;
                }
                String horasEncontradas = ws.buscarHoraAPSPorMedico(idMedico, fechaIn, fechaFin);
//                System.out.println(horasEncontradas);
                JSONArray arrayHoras = Utilidades.obtenerArrayJSON(horasEncontradas, "horasEncontradas");
                if (arrayHoras.isEmpty()) {
                    sesion.setAttribute("mensaje", "warning;Lo sentimos!;No hay horas disponibles para la busqueda indicada");
                    request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
                    return;
                }
                request.setAttribute("tipoBusqueda", "busquedaPorMedico");
                request.setAttribute("horasLibres",horasEncontradas);
                request.setAttribute("fechasRango", Utilidades.diasDeRango(fechaIn, fechaFin));
                request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
                break;
            case "especialidad":
                int idEspecialidad = Integer.valueOf(request.getParameter("especialidad"));
                String horasEncontradas2 = ws.buscarHoraAPSPorEspecialidad(idEspecialidad, fechaIn, fechaFin);
                JSONArray arrayHoras2 = Utilidades.obtenerArrayJSON(horasEncontradas2, "horasEncontradas");
                if (arrayHoras2.isEmpty()) {
                    sesion.setAttribute("mensaje", "warning;Lo sentimos!;No hay horas disponibles para la busqueda indicada");
                    request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
                    return;
                }
                request.setAttribute("tipoBusqueda", "busquedaPorEspecialidad");
                request.setAttribute("horasLibres",horasEncontradas2);
                request.setAttribute("fechasRango", Utilidades.diasDeRango(fechaIn, fechaFin));
                request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
                break;
            case "APS":
//            	request.setAttribute("mensaje", request.getParameter("mensaje"));
//                request.setAttribute("tipoMensaje", request.getParameter("tipoMensaje")); //success,warning
                request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
            	break;
            default:
            	request.setAttribute("fechaInicio", "28/05/2015");
            	request.setAttribute("fechaFinal", "06/06/2015");
                request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
