<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.web1.models.Usuario"%>
<%@page import="com.mycompany.web1.models.Publicacion"%>
<%@page import="com.mycompany.web1.models.Categoria"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="author" content="Cynthia Sustaita">
    <meta name="description" content="Blog de cocina: El sazón de Toto - Ver Receta">
    <meta name="keywords" content="recetas, cocina, comida, blog de cocina, ver receta">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ver Receta - El sazón de Toto</title>
    <link rel="icon" type="image/x-icon" href="imagenes/cookieicon.svg">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="style.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .recipe-image {
            max-width: 100%;
            height: auto;
            border-radius: 0.25rem;
            margin-bottom: 1rem;
        }
        .info-label {
            font-weight: bold;
        }
    </style>
</head>

<body>
    <%
        
        // Obtener datos de la sesión
        Publicacion publicacionAMostrar = (Publicacion) request.getSession().getAttribute("PublicacionAMostrar");
        Usuario autorDePublicacion = (Usuario) request.getSession().getAttribute("AutorPublicacion");
        Categoria categoriaDePublicacion = (Categoria) request.getSession().getAttribute("CategoriaPublicacion");

        // Valores por defecto en caso de que los atributos de sesión sean nulos
        String titulo = "Título no disponible";
        String descripcion = "Descripción no disponible.";
        String nombreAutor = "Autor no disponible";
        String nombreCategoria = "Categoría no disponible";
        String urlImagen = "imagenes/placeholder.png"; // Una imagen placeholder por defecto

        if (publicacionAMostrar != null) {
            titulo = publicacionAMostrar.getTitulo() != null ? publicacionAMostrar.getTitulo() : titulo;
            descripcion = publicacionAMostrar.getDescripcion() != null ? publicacionAMostrar.getDescripcion() : descripcion;
            if (publicacionAMostrar.getFoto_Receta() != null && !publicacionAMostrar.getFoto_Receta().isEmpty()) {
                // Asumiendo que getImagen() devuelve una ruta relativa a la carpeta de imágenes
                // o una URL completa. Si es solo el nombre del archivo y está en una carpeta específica:
                urlImagen = publicacionAMostrar.getFoto_Receta(); 
                // Si ya es una URL completa o una ruta que funciona, puedes usar:
                // urlImagen = publicacionAMostrar.getImagen();
            }
        }
        if (autorDePublicacion != null && autorDePublicacion.getNombre() != null) {
            nombreAutor = autorDePublicacion.getNombre();
        }
        if (categoriaDePublicacion != null && categoriaDePublicacion.getNombre() != null) {
            nombreCategoria = categoriaDePublicacion.getNombre();
        }
    %>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light sticky-top">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <img src="imagenes/Logo.png" width="40" alt="Logo El sazón de Toto">
                    <span>El sazón de Toto</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-toggler-view"
                        aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbar-toggler-view">
                    </div>
            </div>
        </nav>
    </header>

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-4">
                            <a href="ObtenerRecetasDeUnUsuario" class="btn btn-outline-secondary btn-sm me-3">
                                <i class="bi bi-arrow-left"></i> Volver
                            </a>
                            <h2 class="card-title fw-bold mb-0 texto-azul-oscuro">Detalles de la Receta</h2>
                        </div>

                        <% if (publicacionAMostrar != null) { %>
                            <h3 class="mb-3"><%= titulo %></h3>

                            <div class="mb-3 text-center">
                                <img src="<%= urlImagen %>" alt="Imagen de la receta: <%= titulo %>" class="recipe-image img-fluid">
                            </div>

                            <div class="mb-3">
                                <p class="info-label">Descripción:</p>
                                <p><%= descripcion %></p>
                            </div>

                            <div class="mb-3">
                                <p><span class="info-label">Autor:</span> <%= nombreAutor %></p>
                            </div>

                            <div class="mb-3">
                                <p><span class="info-label">Categoría:</span> <%= nombreCategoria %></p>
                            </div>

                        <% } else { %>
                            <div class="alert alert-warning" role="alert">
                                No se pudo cargar la información de la receta. Por favor, intente de nuevo.
                            </div>
                        <% } %>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    
    </body>
</html>