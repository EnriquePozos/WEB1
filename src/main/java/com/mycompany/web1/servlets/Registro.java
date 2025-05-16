/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.web1.servlets;

import com.mycompany.web1.models.Usuario;
import conexion.conexion;
import dao.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Pozos
 */
@WebServlet(name = "Registro", urlPatterns = {"/Registro"})
public class Registro extends HttpServlet {

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
            out.println("<title>Servlet Registro</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Registro at " + request.getContextPath() + "</h1>");
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
        
        String Nombre = request.getParameter("nombre");
        String Apellido_P = request.getParameter("apellido_paterno");
        String Apellido_M = request.getParameter("apellido_materno");
        
        String FechaNacimientoString = request.getParameter("fecha_nacimiento");
        //Conversion 
        java.sql.Date FechaNacimiento = java.sql.Date.valueOf(FechaNacimientoString);
        String Email = request.getParameter("email");
        String Usuario = request.getParameter("usuario_reg");
        String Password = request.getParameter("password_reg");
        String ConfPassword = request.getParameter ("confirmar_password");
        String Foto = request.getParameter("imagen");
        //Valiar contras (Que lo haga cyn en el front)
        //Calcular ea
        
        try{
            conexion conn = new conexion();
            UsuarioDAO uDAO = new UsuarioDAO(conn.Conectar());
            
            Usuario usuario = new Usuario();
            
            usuario.setNombre(Nombre);
            usuario.setApellido_P(Apellido_P);
            usuario.setApellido_M(Apellido_M);
            usuario.setFecha_Nacimiento(FechaNacimiento);
            usuario.setCorreo(Email);
            usuario.setUsuario(Usuario);
            usuario.setContrasenia(Password);
            usuario.setFoto_Perfil(Foto);
            
            if(uDAO.insertUsuario(usuario)){
                //Se inserto en la bd
                response.sendRedirect("login.jsp");
            }else{
                //No se insertó
                response.sendRedirect("login.jsp?error=1");

            }
            
        }catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            //response.getWriter().write("{"status": "error", "message": "" + e.getMessage() + ""}");
        }
        
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
