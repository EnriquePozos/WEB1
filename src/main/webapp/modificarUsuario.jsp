<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.web1.models.Usuario"%>

<!--
<%
    // Obtener el objeto Usuario del request (establecido por ModificarUsuarioServlet en doGet)
    Usuario usuarioAModificar = (Usuario) request.getAttribute("usuarioAModificar");
    String contextPath = request.getContextPath(); // Necesario para las rutas de imágenes y enlaces

    // Valores por defecto o del usuario para pre-llenar el formulario
    String nombre = "";
    String apellidoP = "";
    String apellidoM = "";
    String nombreUsuario = ""; // Este es el 'username' o 'nombre de usuario'
    String correo = "";
    String fechaNacimiento = "";
    String fotoPerfil = contextPath + "/imagenes/default_avatar.png"; // Imagen por defecto

    if (usuarioAModificar != null) {
        nombre = usuarioAModificar.getNombre() != null ? usuarioAModificar.getNombre() : "";
        apellidoP = usuarioAModificar.getApellido_P() != null ? usuarioAModificar.getApellido_P() : "";
        apellidoM = usuarioAModificar.getApellido_M() != null ? usuarioAModificar.getApellido_M() : "";
        nombreUsuario = usuarioAModificar.getUsuario() != null ? usuarioAModificar.getUsuario() : "";
        correo = usuarioAModificar.getCorreo() != null ? usuarioAModificar.getCorreo() : "";
        if (usuarioAModificar.getFecha_Nacimiento() != null) {
            fechaNacimiento = usuarioAModificar.getFecha_Nacimiento().toString();
        }
        if (usuarioAModificar.getFoto_Perfil() != null && !usuarioAModificar.getFoto_Perfil().isEmpty()) {
            // Asumimos que foto_perfil ya tiene contextPath si es necesario, o es una ruta relativa desde la raíz de la app web
            // Si la foto_perfil se guarda como 'imagenes/perfiles/foto.jpg', entonces contextPath es necesario.
            // Si se guarda como '/imagenes/perfiles/foto.jpg', entonces no (pero es menos portable).
            // Por consistencia, si la guardas como "imagenes/perfiles/foto.jpg" en la BD:
            fotoPerfil = contextPath + "/" + usuarioAModificar.getFoto_Perfil(); 
        }
    }

    // Recuperar mensajes de error/éxito del request
    String errorGeneral = (String) request.getAttribute("errorGeneral");
    String exitoActualizacion = (String) request.getAttribute("exitoActualizacion");
    String errorImagen = (String) request.getAttribute("errorImagen");
    String errorFecha = (String) request.getAttribute("errorFecha");

    // Para los enlaces del header dinámico (simulando sesión)
    Usuario usuarioEnSesion = (Usuario) session.getAttribute("SesionActual"); // Asumimos que 'SesionActual' es el nombre del atributo de sesión
                                                                               // y que es el mismo que 'usuarioAModificar' en este contexto.
    if (usuarioEnSesion == null && usuarioAModificar != null) { // Si estamos modificando, asumimos que hay sesión
        usuarioEnSesion = usuarioAModificar;
    }

%>

-->
<!DOCTYPE html>
<html lang="es"> <%-- Buena práctica añadir el idioma --%>
<head>
    <meta charset="utf-8">
    <meta name="author" content="Cynthia Sustaita"> <%-- De tu código --%>
    <meta name="description" content="Blog de cocina: El sazón de Toto - Modificar Perfil"> <%-- Adaptado --%>
    <meta name="keywords" content="recetas, cocina, comida, blog de cocina, modificar perfil"> <%-- Adaptado --%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Modificar Perfil - El sazón de Toto</title> <%-- Adaptado --%>
    <link rel="icon" type="image/x-icon" href="<%= contextPath %>/imagenes/cookieicon.svg">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="<%= contextPath %>/style.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet">
    <%-- <link rel="preload" href="<%= contextPath %>/imagenes/banner.png" as="image"> --%>
    
    <%-- Estilos adicionales de tu style.css que son relevantes --%>
    <style>
        /* body { margin-top: 80px; /* Ajuste para navbar fijo si tu navbar es 'fixed-top' o 'sticky-top' */ } */
        /* La clase .avatar-preview y .profile-card de tu style.css se aplicarán directamente */
    </style>
</head>
<body>

    <header>
        <nav class="navbar navbar-expand-lg navbar-light sticky-top">
          <div class="container navbar-container">
            <div class="navbar-left">
              <a class="navbar-brand" href="/index.jsp"> <%-- Enlace a tu index --%>
                <img src="/imagenes/Logo.png" width="50" alt="Logo El sazón de Toto">
                <span>El sazón de Toto</span>
              </a>
            </div>
            
            <div class="navbar-center d-none d-lg-flex">
              <form class="d-flex" action="" method="GET"> <%-- Asumiendo un servlet para búsqueda --%>
                <input class="form-control me-2" type="search" name="query" placeholder="Buscar recetas..." aria-label="Search">
                <button class="btn btn-outline-success" type="submit">
                  <i class="bi bi-search"></i>
                </button>
              </form>
            </div>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-toggler"
                    aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse navbar-right" id="navbar-toggler">
              <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                  <a class="nav-link" href="/index.jsp">Inicio</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/dashboard.jsp">Recetas</a> <%-- O tu página principal de recetas --%>
                </li>
                <% if (usuarioEnSesion != null) { %>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/perfil.jsp">Mi perfil</a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="/LogoutServlet">Cerrar Sesión</a> <%-- Asumiendo un LogoutServlet --%>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="/login.jsp">Iniciar sesión</a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="/registro.jsp">Registrarse</a>
                    </li>
                <% } %>
              </ul>
              
              <div class="mt-3 d-lg-none w-100">
                <form class="d-flex" action="" method="GET"> <%-- Asumiendo un servlet para búsqueda --%>
                  <input class="form-control me-2" type="search" name="query" placeholder="Buscar recetas..." aria-label="Search">
                  <button class="btn btn-outline-success" type="submit">
                    <i class="bi bi-search"></i>
                  </button>
                </form>
              </div>
            </div>
          </div>
        </nav>
    </header>
    <main class="container mt-4 mb-5"> <%-- Añadí un margen superior (mt-4) para el sticky-top navbar --%>
        <div class="row justify-content-center">
            <div class="col-md-9 col-lg-8">
                <div class="card profile-card">
                    <div class="card-header text-center">
                        <h3>Modificar Mi Perfil</h3>
                    </div>
                    <div class="card-body">
                        <%-- Mostrar mensajes de alerta --%>
                        <% if (exitoActualizacion != null) { %>
                            <div class="alert alert-success" role="alert">
                                <%= exitoActualizacion %>
                            </div>
                        <% } %>
                        <% if (errorGeneral != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= errorGeneral %>
                            </div>
                        <% } %>
                        <% if (errorImagen != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= errorImagen %>
                            </div>
                        <% } %>
                        <% if (errorFecha != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= errorFecha %>
                            </div>
                        <% } %>

                        <form action="ModificarUsuario" method="POST" enctype="multipart/form-data" id="formModificarUsuario">
                            
                            <div class="text-center mb-4">
                                <img id="avatarPreview" src="" alt="Foto de Perfil" class="avatar-preview">
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="nombre" class="form-label">Nombre(s):<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" value="<%= usuarioEnSesion.getNombre()%>" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="nombre_usuario_form" class="form-label">Nombre de Usuario:<span class="text-danger">*</span></label>
                                    <%-- Renombrado 'name' para evitar colisión con variable 'nombreUsuario' en scriptlets --%>
                                    <input type="text" class="form-control" id="nombre_usuario" name="nombre_usuario" value="<%= usuarioEnSesion.getUsuario() %>" required minlength="3">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="apellido_paterno" class="form-label">Apellido Paterno:<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="apellido_paterno" name="apellido_paterno" value="<%= usuarioEnSesion.getApellido_P() %>" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="apellido_materno" class="form-label">Apellido Materno:</label>
                                    <input type="text" class="form-control" id="apellido_materno" name="apellido_materno" value="<%= usuarioEnSesion.getApellido_M() %>">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">Contraseña<span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="contraseña" name="contraseña" value="<%= usuarioEnSesion.getContrasenia()%>" required>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="${pageContext.request.contextPath}/perfil.jsp" class="btn btn-secondary me-md-2">Cancelar</a>
                                <button type="submit" class="btn profile-button">Guardar Cambios</button>
                            </div>
                                
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <div class="footer-content">
              <h5>El sazón de Toto</h5>
              <p>Tu blog de cocina favorito</p>
            </div>
            <div class="copyright">
                <%-- Modificado para usar el año actual dinámicamente y tu texto --%>
              &copy; <%= java.time.Year.now().getValue() %> - El sazón de Toto - Todos los derechos reservados
            </div>
          </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    
    <script>
        // Función para previsualizar la imagen seleccionada
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function(){
                const output = document.getElementById('avatarPreview');
                output.src = reader.result;
            };
            if (event.target.files[0]) {
                reader.readAsDataURL(event.target.files[0]);
            } else {
                output.src = "<%= fotoPerfil %>"; 
            }
        }
    </script>
</body>
</html>