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
import java.util.List;

@WebServlet(name = "ObtenerRecetasDeUnUsuario", urlPatterns = {"/ObtenerRecetasDeUnUsuario"})
public class ObtenerRecetasDeUnUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ObtenerRecetasDeUnUsuario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ObtenerRecetasDeUnUsuario at " + request.getContextPath() + "</h1>");
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
        
        HttpSession session = request.getSession(false);
        
        Usuario UsuarioLogeado = (Usuario) session.getAttribute("SesionActual");
        
        conexion con = null;
        
        try{
            con = new conexion();
            PublicacionDAO pDAO = new PublicacionDAO(con.Conectar());
            
            List<Publicacion> listaPublicacion = pDAO.getPublicacionesDeUsuario(UsuarioLogeado.getId_Usuario());
            
            con.Desconectar();
            
            request.setAttribute("MisPublicaciones", listaPublicacion);
            request.getRequestDispatcher("perfil.jsp").forward(request, response);
        }catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // Manejo básico de errores
            if (con != null) {
                try { con.Desconectar(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            // Podrías redirigir a una página de error o mostrar un mensaje en el JSP
            request.setAttribute("errorCargaPublicaciones", "Hubo un error al cargar tus publicaciones.");
            request.getRequestDispatcher("/perfil.jsp").forward(request, response); // O a donde sea apropiado
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




