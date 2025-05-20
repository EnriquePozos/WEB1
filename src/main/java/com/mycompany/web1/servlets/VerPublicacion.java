/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.web1.servlets;

import com.mycompany.web1.models.Categoria;
import com.mycompany.web1.models.Publicacion;
import com.mycompany.web1.models.Usuario;
import conexion.conexion;
import dao.CategoriaDAO;
import dao.PublicacionDAO;
import dao.UsuarioDAO;
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
@WebServlet(name = "VerPublicacion", urlPatterns = {"/VerPublicacion"})
public class VerPublicacion extends HttpServlet {

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
            out.println("<title>Servlet VerPublicacion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerPublicacion at " + request.getContextPath() + "</h1>");
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
        
                String idPublicacionStr = request.getParameter("id"); //ID de la publicación desde la URL

        //Verificando Sesión del Usuario
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("SesionActual") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=requiereLoginParaModificarReceta");
            return;
        }
        Usuario usuarioLogueado = (Usuario) session.getAttribute("SesionActual");
        if (usuarioLogueado == null || usuarioLogueado.getId_Usuario() == 0) { 
             response.sendRedirect(request.getContextPath() + "/login.jsp?error=sesionInvalidaParaModificarReceta");
            return;
        }
        int idUsuarioActual = usuarioLogueado.getId_Usuario(); //ID del usuario en sesión

        //Validar y Convertir el Parámetro idPublicacionStr
        if (idPublicacionStr == null || idPublicacionStr.trim().isEmpty()) {
            request.setAttribute("errorGeneral", "No se especificó el ID de la receta a modificar.");
            request.getRequestDispatcher("/perfil").forward(request, response); // O a una página de error
            return;
        }

        int idPublicacion;
        try {
            idPublicacion = Integer.parseInt(idPublicacionStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorGeneral", "El ID de la receta proporcionado no es válido.");
            request.getRequestDispatcher("/perfil").forward(request, response); // O a una página de error
            return;
        }

        //Obtener la Publicación a modificar
        conexion con = null;
        Publicacion PublicacionAVer = null;
        Categoria nombreCategoria = null;
        Usuario nombreUsuario = null;
        String errorCarga = null;

        try {
            con = new conexion();
            PublicacionDAO publicacionDAO = new PublicacionDAO(con.Conectar());
            CategoriaDAO categoriaDAO = new CategoriaDAO(con.Conectar());
            UsuarioDAO usuarioDAO = new UsuarioDAO(con.Conectar());
            
            
            // Llamada al nuevo método del DAO, pasando ambos IDs
            PublicacionAVer = publicacionDAO.getPublicacionAMostrar(idPublicacion);
            //Obteniendo categoria de la publicacion
            nombreCategoria = categoriaDAO.getNombreCategoria(PublicacionAVer.getId_Categoria());
            //Obteniendo autor de publicacion
            nombreUsuario = usuarioDAO.getUsuarioById(PublicacionAVer.getId_Autor());
            
            if (con.Conectar() != null && !con.Conectar().isClosed()) { // Asumiendo que getConn() existe y funciona
                 con.Desconectar();
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            errorCarga = "Error al conectar con la base de datos para cargar la receta.";
        }

        //Manejar el Resultado y hacer Forward al JSP de Modificación
        if (errorCarga != null) {
            request.setAttribute("errorGeneral", errorCarga);
            // Podrías redirigir al perfil o a una página de error general
            request.getRequestDispatcher("/perfil.jsp").forward(request, response); // O /error.jsp
        } else if (PublicacionAVer != null) {
            // Receta encontrada Y pertenece al usuario logueado
            
            
            session.setAttribute("PublicacionAMostrar", PublicacionAVer); //Para usarlo en formulario en modificarReceta.jsp
            session.setAttribute("CategoriaPublicacion",nombreCategoria);
            session.setAttribute("AutorPublicacion",nombreUsuario); 
            
            
            request.getRequestDispatcher("/VerPublicacion.jsp").forward(request, response);
            
            
        } else {
            // Receta no encontrada con ese ID o no pertenece al usuario actual
            request.setAttribute("errorGeneral", "La receta que intentas ver no existe.");
            // Redirigir de vuelta al perfil del usuario o a una página de "no autorizado"
            request.getRequestDispatcher("/perfil").forward(request, response); // Ajusta la URL de redirección según necesites
        }
        

        
        
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
