<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.web1.models.Usuario"%>
<%@page import="com.mycompany.web1.models.Publicacion"%>

<!DOCTYPE html>
<html lang="es">
  <head>
    <!-- Metadatos -->
    <meta charset="utf-8">
    <meta name="author" content="Cynthia Sustaita">
    <meta name="description" content="Blog de cocina: El sazón de Toto">
    <meta name="keywords" content="recetas, cocina, comida, blog de cocina, editar receta">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Titulo -->
    <title>Modificar receta - El sazón de Toto</title>
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="imagenes/cookieicon.svg">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Iconos de Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <!-- CSS -->
    <link href="style.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet">
  </head>

<body>
    <%
        Usuario NoIniciado = new Usuario();
        Usuario usuario = (Usuario) request.getSession().getAttribute("SesionActual")==null?NoIniciado:(Usuario)request.getSession().getAttribute("SesionActual");
        
        // Aquí obtendrías la receta a modificar de la base de datos
        Publicacion publicacionAModificar = (Publicacion) request.getAttribute("PublicacionAModificar");
        // Por ahora usaremos valores de ejemplo
    %>
  <header>
    <!-- Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
      <div class="container">
        <!-- Logo a la izquierda -->
        <a class="navbar-brand" href="index.jsp">
          <img src="imagenes/Logo.png" width="40" alt="Logo El sazón de Toto">
          <span>El sazón de Toto</span>
        </a>
        
        <!-- Botón para móviles -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-toggler" 
            aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbar-toggler">
          <!-- Barra de búsqueda en el centro (visible en desktop) -->
          
          
          <!-- Barra de búsqueda para móviles -->
          <div class="mt-3 d-lg-none">
            <form class="d-flex">
              <input class="form-control me-2" type="search" placeholder="Buscar recetas..." aria-label="Search">
              <button class="btn btn-outline-success" type="submit">
                <i class="bi bi-search"></i>
              </button>
            </form>
          </div>
        </div>
      </div>
    </nav>
  </header>
  
  <main class="container py-5">
    <div class="row justify-content-center">
      <div class="col-md-10 col-lg-8">
        <!-- Tarjeta para modificar receta -->
        <div class="card">
          <div class="card-body">
            <div class="d-flex align-items-center mb-4">
              <a href="ObtenerRecetasDeUnUsuario" class="btn btn-outline-secondary btn-sm me-3">
                <i class="bi bi-arrow-left"></i> Volver
              </a>
              <h2 class="card-title fw-bold mb-0 texto-azul-oscuro">Modificar receta</h2>
            </div>
            
            <form class="modificar-receta-form" action="ModificarReceta" method="post">
              <!-- Campo oculto para el ID de la receta -->
              <input type="hidden" name="idPublicacion" value="<%= publicacionAModificar.getId_Publicacion() %>" />
              
              <div class="mb-3">
                <label for="titulo" class="form-label">Título de la receta</label>
                <input type="text" class="form-control" id="titulo" name="titulo" value="<%= publicacionAModificar.getTitulo() %>" required>
              </div>
              
              
              <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required><%= publicacionAModificar.getDescripcion() %></textarea>
              </div>

              
              <div class="d-flex justify-content-end">
                <a href="ObtenerRecetasDeUnUsuario" class="btn btn-outline-secondary me-2">Cancelar</a>
                <button type="submit" class="btn btn-primary publicar-btn">
                  <i class="bi bi-check-circle me-1"></i>Guardar cambios
                </button>
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
        &copy; 2025 - El sazón de Toto - Todos los derechos reservados
      </div>
    </div>
  </footer>
  <!-- JavaScript de Bootstrap -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
  
  <script>
    // Script para mostrar el nombre del archivo seleccionado en el input de tipo file
    document.getElementById('nueva_imagen').addEventListener('change', function() {
      const fileName = this.files[0].name;
      const label = document.querySelector('label[for="nueva_imagen"]');
      label.textContent = 'Cambiar imagen: ' + fileName;
    });
  </script>
</body>
</html>