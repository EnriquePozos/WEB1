/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.web1.servlets;

import com.mycompany.web1.models.Usuario;
import conexion.conexion;
import dao.PublicacionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

/**
 *
 * @author Pozos
 */
@WebServlet(name = "EliminarPublicacion", urlPatterns = {"/EliminarPublicacion"})
public class EliminarPublicacion extends HttpServlet {

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
            out.println("<title>Servlet EliminarPublicacion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EliminarPublicacion at " + request.getContextPath() + "</h1>");
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
        
        HttpSession session = request.getSession(false);
        
        //Verificar Sesión
        if (session == null || session.getAttribute("SesionActual") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=requiereLoginBorrarReceta");
            return;
        }
        Usuario usuarioLogueado = (Usuario) session.getAttribute("SesionActual");
        if (usuarioLogueado == null || usuarioLogueado.getId_Usuario() == 0) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sesionInvalidaBorrarReceta");
            return;
        }
        int idUsuarioActual = usuarioLogueado.getId_Usuario();

        //Obtener idPublicacion del Formulario
        String idPublicacionStr = request.getParameter("idPublicacion"); // De un campo hidden

        if (idPublicacionStr == null || idPublicacionStr.trim().isEmpty()) {
            session.setAttribute("mensajeGlobalError", "No se especificó el ID de la receta a borrar.");
            response.sendRedirect(request.getContextPath() + "/ObtenerRecetasDeUnUsuario"); // Redirigir a perfil
            return;
        }

        int idPublicacion;
        try {
            idPublicacion = Integer.parseInt(idPublicacionStr);
        } catch (NumberFormatException e) {
            session.setAttribute("mensajeGlobalError", "ID de receta inválido para borrar.");
            response.sendRedirect(request.getContextPath() + "/ObtenerRecetasDeUnUsuario"); // Redirigir a perfil
            return;
        }

        //Eliminar Publicación
        conexion con = null;
        boolean exito = false;

        try {
            con = new conexion();
            PublicacionDAO publicacionDAO = new PublicacionDAO(con.Conectar());
            
            exito = publicacionDAO.deletePublicacion(idPublicacion);
            
            if (con.Conectar() != null && !con.Conectar().isClosed()) { // Asumiendo que getConn() existe
                con.Desconectar();
            }

            if (exito) {
                session.setAttribute("mensajeGlobalExito", "¡Receta eliminada con éxito!");
            } else {
                session.setAttribute("mensajeGlobalError", "No se pudo eliminar la receta. Puede que ya no exista o no tengas permiso.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("mensajeGlobalError", "Error de base de datos al intentar eliminar la receta: " + e.getMessage());
        }
            response.sendRedirect(request.getContextPath() + "/ObtenerRecetasDeUnUsuario"); // Redirigir a la vista de perfil/mis recetas
            
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
