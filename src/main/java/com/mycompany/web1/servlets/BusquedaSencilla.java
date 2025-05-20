/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.web1.servlets;

import com.mycompany.web1.models.Publicacion;
import conexion.conexion;
import dao.PublicacionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Pozos
 */
@WebServlet(name = "BusquedaSencilla", urlPatterns = {"/BusquedaSencilla"})
public class BusquedaSencilla extends HttpServlet {

    private static final int ITEMS_POR_PAGINA = 9;
    
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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BusquedaSencilla</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BusquedaSencilla at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        
        
        String terminoBusqueda = request.getParameter("buscar"); // El término debe venir en la URL para paginación
        String paginaStr = request.getParameter("pagina");
        int paginaActual = 1;

        if (paginaStr != null && !paginaStr.isEmpty()) {
            try {
                paginaActual = Integer.parseInt(paginaStr);
                if (paginaActual < 1) {
                    paginaActual = 1;
                }
            } catch (NumberFormatException e) {
                // paginaActual se mantiene en 1
            }
        }
        procesarBusqueda(terminoBusqueda, paginaActual, request, response);
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
        
        String terminoBusqueda = request.getParameter("buscar");
        procesarBusqueda(terminoBusqueda, 1, request, response);
    
    }
    
    
    private void procesarBusqueda(String terminoBusqueda, int paginaActual, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Publicacion> todasLasPublicacionesEncontradas = null;
        List<Publicacion> publicacionesParaPaginaActual = new ArrayList<>();
        int totalPublicaciones = 0;
        int totalPaginas = 0;

        // Validar que haya un término de búsqueda
        if (terminoBusqueda == null || terminoBusqueda.trim().isEmpty()) {
            request.setAttribute("errorGeneral", "Por favor, ingresa un término para buscar.");
            // Opcionalmente, redirigir al dashboard sin resultados o mostrar un mensaje
            // Si se desea mostrar el dashboard "normal", se podría hacer un forward al DashboardServlet
            // request.getRequestDispatcher("/DashboardServlet").forward(request, response);
            // Por ahora, solo pondremos los atributos para que el JSP muestre "0 resultados"
            request.setAttribute("listaPublicaciones", publicacionesParaPaginaActual);
            request.setAttribute("paginaActual", 1);
            request.setAttribute("totalPaginas", 0);
            request.setAttribute("terminoBusquedaActual", terminoBusqueda); // Para que el input lo recuerde
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
            return;
        }
        
        conexion conManager = null;
        try {
            conManager = new conexion();
            Connection con = conManager.Conectar();
            PublicacionDAO publicacionDAO = new PublicacionDAO(con);

            todasLasPublicacionesEncontradas = publicacionDAO.busquedaDePublicaciones(terminoBusqueda.trim());

            if (todasLasPublicacionesEncontradas != null && !todasLasPublicacionesEncontradas.isEmpty()) {
                totalPublicaciones = todasLasPublicacionesEncontradas.size();
                totalPaginas = (int) Math.ceil((double) totalPublicaciones / ITEMS_POR_PAGINA);

                if (paginaActual > totalPaginas && totalPaginas > 0) {
                    paginaActual = totalPaginas;
                }
                if (paginaActual < 1 && totalPaginas > 0) {
                    paginaActual = 1;
                }
                
                int fromIndex = (paginaActual - 1) * ITEMS_POR_PAGINA;
                int toIndex = Math.min(fromIndex + ITEMS_POR_PAGINA, totalPublicaciones);

                if (fromIndex < totalPublicaciones && fromIndex < toIndex) {
                    publicacionesParaPaginaActual = todasLasPublicacionesEncontradas.subList(fromIndex, toIndex);
                }

            } else {
                totalPublicaciones = 0;
                totalPaginas = 0;
                // Asegurar que la lista no sea null si no se encontraron resultados
                if (todasLasPublicacionesEncontradas == null) {
                    todasLasPublicacionesEncontradas = new ArrayList<>();
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorGeneral", "Error al realizar la búsqueda: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorGeneral", "Ocurrió un error inesperado: " + e.getMessage());
        }
        finally {
            if (conManager != null) {
                try {
                    conManager.Desconectar();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        request.setAttribute("listaPublicaciones", publicacionesParaPaginaActual);
        request.setAttribute("paginaActual", paginaActual);
        request.setAttribute("totalPaginas", totalPaginas);
        request.setAttribute("terminoBusquedaActual", terminoBusqueda); // Importante para la paginación y para mostrar en el input

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
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
