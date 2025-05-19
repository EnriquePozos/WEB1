package com.mycompany.web1.servlets;

import com.mycompany.web1.models.Usuario;
import conexion.conexion; // Tu clase de conexión
import dao.UsuarioDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date; // Para java.sql.Date
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;

@WebServlet(name = "ModificarUsuarioServlet", urlPatterns = {"/ModificarUsuario"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
                 maxFileSize = 1024 * 1024 * 5,   // 5 MB
                 maxRequestSize = 1024 * 1024 * 10) // 10 MB
public class ModificarUsuario extends HttpServlet {

    // Define el directorio donde se guardarán las fotos de perfil subidas
    // Ajusta esta ruta según sea necesario. Debe ser relativa al directorio raíz de tu aplicación web.
    private static final String UPLOAD_DIRECTORY = "imagenes" + File.separator + "perfiles";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // No crear nueva sesión si no existe

        if (session == null || session.getAttribute("SesionActual") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=requiereLogin");
            return;
        }

        Usuario usuarioLogueado = (Usuario) session.getAttribute("SesionActual");
        conexion con = null;
        try {
            con = new conexion();
            UsuarioDAO uDAO = new UsuarioDAO(con.Conectar());
            Usuario usuarioParaModificar = uDAO.getUsuarioById(usuarioLogueado.getId_Usuario()); // Cargar datos frescos
            con.Desconectar();

            if (usuarioParaModificar != null) {
                request.setAttribute("usuarioAModificar", usuarioParaModificar);
                request.getRequestDispatcher("/modificarUsuario.jsp").forward(request, response);
            } else {
                // Esto no debería pasar si el usuario está logueado, pero por si acaso
                session.setAttribute("mensajeGlobal", "Error: No se pudieron cargar los datos del perfil.");
                response.sendRedirect(request.getContextPath() + "/perfil.jsp");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            if (con != null) { // Intenta desconectar si la conexión se estableció
                try { con.Desconectar(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            request.setAttribute("errorGeneral", "Error de base de datos al cargar el perfil para modificar.");
            request.getRequestDispatcher("/modificarUsuario.jsp").forward(request, response); // O redirigir a una página de error
        }
    }

    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("SesionActual") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sesionExpirada");
            return;
        }

        Usuario usuarioLogueado = (Usuario) session.getAttribute("SesionActual");
        Usuario datosParaFormulario = new Usuario(); // Para rellenar el form en caso de error

        // Obtener parámetros del formulario
        String nombre = request.getParameter("nombre");
        String nombreUsuarioForm = request.getParameter("nombre_usuario"); 
        String apellidoP = request.getParameter("apellido_paterno");
        String apellidoM = request.getParameter("apellido_materno");
        String contraseña = request.getParameter("contraseña");
        String fechaNacimientoStr = request.getParameter("fecha_nacimiento");

        // Rellenar 'datosParaFormulario' con los valores recibidos para no perderlos si hay error
        datosParaFormulario.setNombre(nombre);
        datosParaFormulario.setUsuario(nombreUsuarioForm);
        datosParaFormulario.setApellido_P(apellidoP);
        datosParaFormulario.setApellido_M(apellidoM);
        datosParaFormulario.setContrasenia(contraseña);
        datosParaFormulario.setFoto_Perfil(usuarioLogueado.getFoto_Perfil()); // Foto actual por defecto
        if (fechaNacimientoStr != null && !fechaNacimientoStr.isEmpty()) {
            try {
                datosParaFormulario.setFecha_Nacimiento(Date.valueOf(fechaNacimientoStr));
            } catch (IllegalArgumentException e) {
                // No hacer nada aquí, el error de fecha se manejará más adelante
            }
        } else {
             datosParaFormulario.setFecha_Nacimiento(usuarioLogueado.getFecha_Nacimiento());
        }
        

        // Crear y poblar el objeto Usuario con los datos actualizados
        Usuario usuarioActualizado = new Usuario();
        usuarioActualizado.setId_Usuario(usuarioLogueado.getId_Usuario());
        usuarioActualizado.setNombre(nombre);
        usuarioActualizado.setUsuario(nombreUsuarioForm); // Nombre de usuario (username)
        usuarioActualizado.setApellido_P(apellidoP);
        usuarioActualizado.setApellido_M(apellidoM);
        usuarioActualizado.setContrasenia(contraseña);
        
        // Mantener datos no modificables desde el usuario logueado
        usuarioActualizado.setContrasenia(usuarioLogueado.getContrasenia()); // No se modifica contraseña aquí
        usuarioActualizado.setActiva(usuarioLogueado.isActiva());
        usuarioActualizado.setFecha_Creacion(usuarioLogueado.getFecha_Creacion());


        // Validar y convertir fecha de nacimiento, y calcular edad
        if (fechaNacimientoStr != null && !fechaNacimientoStr.isEmpty()) {
            try {
                LocalDate fechaNac = LocalDate.parse(fechaNacimientoStr);
                usuarioActualizado.setFecha_Nacimiento(Date.valueOf(fechaNac)); // Convertir LocalDate a java.sql.Date
                usuarioActualizado.setEdad(Period.between(fechaNac, LocalDate.now()).getYears());
            } catch (DateTimeParseException e) {
                e.printStackTrace();
                request.setAttribute("errorFecha", "Formato de fecha de nacimiento inválido. Use YYYY-MM-DD.");
                request.setAttribute("usuarioAModificar", datosParaFormulario); // Devolver datos ingresados
                request.getRequestDispatcher("/modificarUsuario.jsp").forward(request, response);
                return;
            }
        } else { // Si la fecha está vacía, podría ser opcional o mantener la anterior
            usuarioActualizado.setFecha_Nacimiento(usuarioLogueado.getFecha_Nacimiento());
            usuarioActualizado.setEdad(usuarioLogueado.getEdad()); // Mantener edad si no se cambia fecha
        }

        // Conexión y actualización en la BD
        conexion con = null;
        try {
            con = new conexion();
            UsuarioDAO uDAO = new UsuarioDAO(con.Conectar());

            
            if (uDAO.updateUsuario(usuarioActualizado)) {
                // Actualizar el objeto Usuario en la sesión para reflejar los cambios inmediatamente
                Usuario usuarioRefrescado = uDAO.getUsuarioById(usuarioLogueado.getId_Usuario());
                con.Desconectar(); // Desconectar después de usar uDAO
                if (usuarioRefrescado != null) {
                    session.setAttribute("SesionActual", usuarioRefrescado);
                }
                session.setAttribute("exitoActualizacion", "¡Perfil actualizado con éxito!"); // Para mostrar en perfil.jsp
                response.sendRedirect("ObtenerRecetasDeUnUsuario");
            } else {
                con.Desconectar();
                request.setAttribute("errorGeneral", "No se pudo actualizar el perfil en la base de datos. Inténtalo de nuevo.");
                request.setAttribute("usuarioAModificar", datosParaFormulario); // Devolver datos ingresados
                request.getRequestDispatcher("/modificarUsuario.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            if (con != null) {
                try { con.Desconectar(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            request.setAttribute("errorGeneral", "Error crítico al actualizar el perfil: " + e.getMessage());
            request.setAttribute("usuarioAModificar", datosParaFormulario); // Devolver datos ingresados
            request.getRequestDispatcher("/modificarUsuario.jsp").forward(request, response);
        }
    }
}
