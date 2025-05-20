/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.web1.servlets;

import com.mycompany.web1.models.Categoria;
import com.mycompany.web1.models.Publicacion;
import conexion.conexion;
import dao.CategoriaDAO;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Pozos
 */
@WebServlet(name = "VerRecetas", urlPatterns = {"/VerRecetas"})
public class VerRecetas extends HttpServlet {
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
            out.println("<title>Servlet VerRecetas</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerRecetas at " + request.getContextPath() + "</h1>");
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
       
 // 1. Manejo de Paginación
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

        // 2. Conexión y DAOs
        conexion conManager = null;
        List<Publicacion> todasLasPublicaciones = null;
        List<Publicacion> publicacionesParaPaginaActual = new ArrayList<>();
        int totalPublicaciones = 0;
        int totalPaginas = 0;

        try {
            conManager = new conexion();
            Connection con = conManager.Conectar();
            PublicacionDAO publicacionDAO = new PublicacionDAO(con);
            CategoriaDAO categoriaDAO = new CategoriaDAO(con); // Necesario para obtener nombres de categoría

            // 3. Obtener TODAS las publicaciones del DAO
            todasLasPublicaciones = publicacionDAO.getPublicaciones();

            if (todasLasPublicaciones != null && !todasLasPublicaciones.isEmpty()) {
                totalPublicaciones = todasLasPublicaciones.size();
                totalPaginas = (int) Math.ceil((double) totalPublicaciones / ITEMS_POR_PAGINA);

                if (paginaActual > totalPaginas && totalPaginas > 0) {
                    paginaActual = totalPaginas;
                }

                int fromIndex = (paginaActual - 1) * ITEMS_POR_PAGINA;
                int toIndex = Math.min(fromIndex + ITEMS_POR_PAGINA, totalPublicaciones);

                if (fromIndex < toIndex && fromIndex < totalPublicaciones) {
                    // Obtener la sublista para la página actual
                    List<Publicacion> subListaPaginada = todasLasPublicaciones.subList(fromIndex, toIndex);
                    
                    // Iterar sobre la sublista paginada para añadir el nombre de la categoría
                    // a cada objeto Publicacion.
                    for (Publicacion pub : subListaPaginada) {
                        Categoria catObj = categoriaDAO.getNombreCategoria(pub.getId_Categoria()); // Tu método actual
                        if (catObj != null && catObj.getNombre() != null) {
                            // ASUNCIÓN: Tu clase Publicacion tiene un método setNombreCategoria(String nombre)
                            // y un campo para almacenar este nombre.
                            pub.setNombreCategoria(catObj.getNombre());
                        } else {
                            pub.setNombreCategoria("Desconocida"); // Valor por defecto si no se encuentra
                        }
                        publicacionesParaPaginaActual.add(pub); // Añadir la publicación (posiblemente modificada)
                    }
                }
            } else {
                totalPublicaciones = 0;
                totalPaginas = 0;
                if (todasLasPublicaciones == null) {
                    todasLasPublicaciones = new ArrayList<>();
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); 
            request.setAttribute("errorGeneral", "Error al cargar las recetas: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorGeneral", "Ocurrió un error inesperado: " + e.getMessage());
        } finally {
            if (conManager != null) {
                try {
                    conManager.Desconectar();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // 4. Establecer atributos para el JSP
        request.setAttribute("listaPublicaciones", publicacionesParaPaginaActual);
        request.setAttribute("paginaActual", paginaActual);
        request.setAttribute("totalPaginas", totalPaginas);
        // Ya no necesitas enviar un mapa de categorías separado
        
        // 5. Forward al JSP
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        

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
