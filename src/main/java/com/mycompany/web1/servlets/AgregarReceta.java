package com.mycompany.web1.servlets;

import com.mycompany.web1.models.Categoria;
import com.mycompany.web1.models.Publicacion;
import com.mycompany.web1.models.Usuario;
import conexion.conexion;
import dao.CategoriaDAO;
import dao.PublicacionDAO;
import dao.UsuarioDAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 *
 * @author Pozos
 */
@WebServlet(name = "AgregarReceta", urlPatterns = {"/AgregarReceta"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
                 maxFileSize = 1024 * 1024 * 5,   // 5MB
                 maxRequestSize = 1024 * 1024 * 10) // 10MB
public class AgregarReceta extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "imagenes/recetas"; // Ruta relativa a tu aplicación web

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
            out.println("<title>Servlet AgregarReceta</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AgregarReceta at " + request.getContextPath() + "</h1>");
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

        //Obtener la sesión
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("SesionActual");

        //Verificar hay sesion activa
        if (usuario == null) {
            response.sendRedirect("login.jsp"); // Redirigir a la página de login si no hay sesión
            return;
        }

        //ID del usuario de la sesion
        int idUsuario = usuario.getId_Usuario(); // Asumiendo que tu clase Usuario tiene un método getId()

        //Obtener los datos del formulario
        String titulo = request.getParameter("titulo"); // Corregir el nombre del parámetro
        String categoriaForm = request.getParameter("categoria");
        String descripcion = request.getParameter("descripcion");

        //Subida de imagen
        Part filePart = request.getPart("imagen"); // El nombre del input file en tu HTML
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        String filePath = uploadPath + File.separator + fileName;
        String rutaRelativaImagen = UPLOAD_DIRECTORY + "/" + fileName;

        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
            // Manejar el error al guardar la imagen
            response.sendRedirect("perfil.jsp?errorImagen=1"); // Redirigir con un mensaje de error
            return;
        }

        try{
            conexion conn = new conexion();
            PublicacionDAO pDAO = new PublicacionDAO(conn.Conectar());
            CategoriaDAO cDAO = new CategoriaDAO(conn.Conectar());
            
            Categoria categoria = new Categoria();
            categoria = cDAO.getIdCategoria(categoriaForm);
            
            Publicacion publicacion = new Publicacion();

            
            publicacion.setTitulo(titulo);
            publicacion.setDescripcion(descripcion);
            publicacion.setFoto_Receta(rutaRelativaImagen); // Guardar la ruta relativa
            publicacion.setId_Categoria(categoria.getId_Categoria());
            publicacion.setId_Autor(idUsuario);
            
            if(pDAO.insertReceta(publicacion)){
                // Se insertó en la bd
                response.sendRedirect("perfil.jsp?recetaGuardada=1"); // Redirigir con un mensaje de éxito
            } else {
                // No se insertó
                response.sendRedirect("login.jsp?errorReceta=1"); // Redirigir con un mensaje de error
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?errorGeneral=" + e.getMessage());
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
