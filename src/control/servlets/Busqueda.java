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
        
        request.setAttribute("medicos", ws.obtenerTodosLosMedicos());
        request.setAttribute("especialidades", ws.obtenerEspecialidades());
        
        String fechaIn="",fechaFin="";
        
        if (tipo!=null) {
            fechaIn = request.getParameter("fechaIn");
            fechaFin = request.getParameter("fechaFin");
            if (fechaIn.equals("")||fechaFin.equals("")) {
                java.util.Date fecha=new java.util.Date();
                fechaIn=String.format("%02d",fecha.getDate())+"/"+String.format("%02d",fecha.getMonth()+1)+"/"+(fecha.getYear()+1900);
                fechaFin=fechaIn;
            }
        }
        else{
            tipo="";
        }    
        switch (tipo) {
            case "medico":
                int idMedico=0;
                if (Utilidades.isNumeric(request.getParameter("medico"))) {
                    idMedico = Integer.valueOf(request.getParameter("medico"));
                }
                else{
                    request.setAttribute("mensaje", "No es válido el médico indicado");
                    request.setAttribute("tipoMensaje", "warning"); //success,warning
                    request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
                }
                request.setAttribute("tipoBusqueda", "busquedaPorMedico");
                String horasEncontradas = ws.buscarHoraAPSPorMedico(idMedico, fechaIn, fechaFin);
                if (horasEncontradas.isEmpty()) {
                    request.setAttribute("mensaje", "No hay horas disponibles para la busqueda indicada");
                    request.setAttribute("tipoMensaje", "warning"); //success,warning
                    request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
                }
                request.setAttribute("horasLibres",horasEncontradas);
                request.setAttribute("fechasRango", Utilidades.diasDeRango(fechaIn, fechaFin));
                request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
                break;
            case "especialidad":
                int idEspecialidad = Integer.valueOf(request.getParameter("especialidad"));
                request.setAttribute("tipoBusqueda", "busquedaPorEspecialidad");
                request.setAttribute("horasLibres",ws.buscarHoraAPSPorEspecialidad(idEspecialidad, fechaIn, fechaFin));
                request.setAttribute("fechasRango", Utilidades.diasDeRango(fechaIn, fechaFin));
                request.getRequestDispatcher("vista/inicio.jsp").forward(request, response);
                break;
            default:
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