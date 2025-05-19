/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.web1.servlets;

import com.mycompany.web1.models.Publicacion;
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

import java.io.IOException;
import java.sql.SQLException;

/**
 *
 * @author Pozos
 */
@WebServlet(name = "ModificarReceta", urlPatterns = {"/ModificarReceta"})
public class ModificarReceta extends HttpServlet {

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
            out.println("<title>Servlet ModificarReceta</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ModificarReceta at " + request.getContextPath() + "</h1>");
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

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("SesionActual") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sesionExpiradaUpdateReceta");
            return;
        }
        Usuario usuarioLogueado = (Usuario) session.getAttribute("SesionActual");
        if (usuarioLogueado == null || usuarioLogueado.getId_Usuario() == 0) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sesionInvalidaUpdateRecetaDoPost");
            return;
        }
        int idUsuarioActual = usuarioLogueado.getId_Usuario();

        String idPublicacionStr = request.getParameter("idPublicacion"); // De un campo hidden
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");

        if (idPublicacionStr == null || titulo == null || titulo.trim().isEmpty() || descripcion == null || descripcion.trim().isEmpty()) {
            session.setAttribute("mensajeGlobalError", "Todos los campos (Título, Descripción) son obligatorios y el ID de la publicación es necesario.");
            // Redirigir de vuelta al formulario de edición con el ID
            String redirectId = (idPublicacionStr != null && !idPublicacionStr.isEmpty()) ? idPublicacionStr : "0";
            response.sendRedirect(request.getContextPath() + "/ModificarReceta?id=" + redirectId + "&error=validacion");
            return;
        }

        int idPublicacion;
        try {
            idPublicacion = Integer.parseInt(idPublicacionStr);
        } catch (NumberFormatException e) {
            session.setAttribute("mensajeGlobalError", "ID de publicación inválido.");
            response.sendRedirect(request.getContextPath() + "/ObtenerRecetasDeUnUsuario");
            return;
        }

        Publicacion publicacionActualizada = new Publicacion();
        publicacionActualizada.setId_Publicacion(idPublicacion);
        publicacionActualizada.setTitulo(titulo);
        publicacionActualizada.setDescripcion(descripcion);

        conexion con = null;
        boolean exito = false;

        try {
            con = new conexion();
            PublicacionDAO publicacionDAO = new PublicacionDAO(con.Conectar());
            // El método updatePublicacion ahora también debe tomar idUsuarioActual para seguridad
            exito = publicacionDAO.updatePublicacion(publicacionActualizada);

            if (con.Conectar() != null && !con.Conectar().isClosed()) { // Asumiendo que getConn() existe
                con.Desconectar();
            }

            if (exito) {
                session.setAttribute("mensajeGlobalExito", "¡Receta actualizada con éxito!");
            } else {
                session.setAttribute("mensajeGlobalError", "No se pudo actualizar la receta. Verifica que seas el autor o inténtalo más tarde.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("mensajeGlobalError", "Error de base de datos al actualizar la receta: " + e.getMessage());
        }

        // Redirigir al servlet que lista las recetas del usuario (Perfil)
        response.sendRedirect(request.getContextPath() + "/ObtenerRecetasDeUnUsuario");
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
