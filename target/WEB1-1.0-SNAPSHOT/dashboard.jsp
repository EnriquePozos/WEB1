<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.mycompany.web1.models.Publicacion"%>
<%@page import="com.mycompany.web1.models.Categoria"%> <%-- Opcional, para el nombre de categoría --%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
    List<Publicacion> listaPublicaciones = (List<Publicacion>) request.getAttribute("listaPublicaciones");
    // Opcional: Si pasas un mapa de categorías desde el servlet para mostrar nombres en lugar de IDs
    // Map<Integer, String> mapaCategorias = (Map<Integer, String>) request.getAttribute("mapaCategorias");

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="author" content="Cynthia Sustaita">
        <meta name="description" content="Blog de cocina: El sazón de Toto">
        <meta name="keywords" content="recetas, cocina, comida, blog de cocina">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Recetas - El sazón de Toto</title>
        <link rel="icon" type="image/x-icon" href="imagenes/cookieicon.svg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link href="style.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="preload" href="imagenes/banner.png" as="image">
    </head>

    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-light sticky-top">
                <div class="container">
                    <a class="navbar-brand" href="index.jsp">
                        <img src="imagenes/Logo.png" width="40" alt="Logo El sazón de Toto">
                        <span>El sazón de Toto</span>
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-toggler" 
                            aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbar-toggler">
                        <div class="search-container d-none d-lg-block">
                        <form class="d-flex" method = "post" action = "BusquedaSencilla">
                            <input id="buscar" name = "buscar" class="form-control me-2" type="search" placeholder="Buscar recetas..." aria-label="Search">
                            <button class="btn btn-outline-success" type="submit">
                                <i class="bi bi-search"></i>
                            </button>
                        </form>
                        </div>

                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link" href="index.jsp">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" href="VerRecetas">Recetas</a> <%-- Enlace al servlet que carga esta página --%>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ObtenerRecetasDeUnUsuario">Mi perfil</a>
                            </li>
                            <li class="nav-item">
                                <%-- Lógica para mostrar "Cerrar Sesión" si hay sesión, o "Iniciar Sesión" si no --%>
                                <% Object usuarioSesion = session.getAttribute("SesionActual"); %>
                                <% if (usuarioSesion != null) { %>
                                <a class="nav-link" href="CerrarSesionServlet">Cerrar Sesión</a>
                                <% } else { %>
                                <a class="nav-link" href="login.jsp">Iniciar sesión</a>
                                <% }%>
                            </li>
                        </ul>

                        <div class="mt-3 d-lg-none">
                            <form class="d-flex" action="BuscarRecetasServlet" method="GET"> <%-- Acción del formulario de búsqueda --%>
                                <input class="form-control me-2" type="search" name="terminoBusqueda" placeholder="Buscar recetas..." aria-label="Search">
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
            <section class="titulo-dashboard text-center mb-5">
                <h1 class="display-4 fw-bold text-primary">Nuestro recetario</h1>
                <p class="lead">Explora todas las deliciosas recetas compartidas por nuestra comunidad.</p>
            </section>

            <section class="filtros bg-light p-4 rounded mb-5">
                <form action="DashboardServlet" method="GET"> <%-- Asumiendo que el mismo servlet maneja los filtros --%>
                    <h2 class="fs-4 mb-3">Filtrar recetas</h2>
                    <div class="row g-3">
                        <div class="col-md-8">
                            <div class="row g-2">
                                <div class="col-md-6">
                                    <div class="input-group mb-2">
                                        <span class="input-group-text"><i class="bi bi-calendar3"></i></span>
                                        <input type="date" class="form-control" id="fecha-inicial" name="fecha-inicial" placeholder="Desde" value="<%= request.getParameter("fecha-inicial") != null ? request.getParameter("fecha-inicial") : ""%>">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group mb-2">
                                        <span class="input-group-text"><i class="bi bi-calendar3"></i></span>
                                        <input type="date" class="form-control" id="fecha-final" name="fecha-final" placeholder="Hasta" value="<%= request.getParameter("fecha-final") != null ? request.getParameter("fecha-final") : ""%>">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <%-- Para cargar categorías dinámicamente, necesitarías pasar una lista de categorías desde el servlet --%>
                            <select class="form-select mb-2" id="categoria" name="categoriaId">
                                <option value="">Categoría</option>
                                <%-- Ejemplo de cómo cargarías categorías dinámicamente si tuvieras una lista de objetos Categoria --%>
                                <%-- List<Categoria> categorias = (List<Categoria>) request.getAttribute("listaDeCategorias"); --%>
                                <%-- if (categorias != null) { for (Categoria cat : categorias) { --%>
                                <%-- String selected = (request.getParameter("categoriaId") != null && request.getParameter("categoriaId").equals(String.valueOf(cat.getId_Categoria()))) ? "selected" : ""; --%>
                                <%-- <option value="<%= cat.getId_Categoria() %>" <%= selected %>><%= cat.getNombre() %></option> --%>
                                <%-- }} else { --%>
                                <option value="1">Desayunos</option> <%-- Placeholder --%>
                                <option value="2">Postres</option>   <%-- Placeholder --%>
                                <%-- } --%>
                                <%-- Lista de categorías hardcodeada actual, idealmente vendría del backend --%>
                                <option value="3">Bebidas</option>
                                <option value="4">Vegano</option>
                                <option value="5">Platos fuertes</option>
                                <option value="6">Snacks y aperitivos</option>
                                <option value="7">Rápido y fácil</option>
                                <option value="8">Sopas y cremas</option>
                                <option value="9">Ocasiones especiales</option>
                            </select>
                        </div>
                        <div class="col-12 text-end">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-funnel me-1"></i> Aplicar filtros
                            </button>
                            <a href="DashboardServlet" class="btn btn-outline-secondary ms-2"> <%-- Enlace para limpiar filtros --%>
                                <i class="bi bi-x-circle me-1"></i> Limpiar
                            </a>
                        </div>
                    </div>
                </form>
            </section>

            <section class="recetas-grid">
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                    <% if (listaPublicaciones != null && !listaPublicaciones.isEmpty()) { %>
                    <% for (Publicacion pub : listaPublicaciones) { %>
                    <div class="col">
                        <div class="card receta h-100">
                            <% String urlImagen = "imagenes/placeholder_receta.png"; // Imagen por defecto
                                if (pub.getFoto_Receta() != null && !pub.getFoto_Receta().isEmpty()) {
                                    urlImagen = pub.getFoto_Receta(); // Asume que las imágenes están en la carpeta "imagenes"
                                }
                            %>
                            <img src="<%= urlImagen%>" class="card-img-top" alt="<%= pub.getTitulo()%>">
                            <div class="card-body d-flex flex-column">
                                <h3 class="card-title"><%= pub.getTitulo()%></h3>

                                <%-- Para mostrar el nombre de la categoría:
                                     Opción 1: Si el servlet pasa un Map<Integer, String> mapaCategorias
                                     String nombreCategoria = "Desconocida";
                                     if (mapaCategorias != null && mapaCategorias.containsKey(pub.getId_Categoria())) {
                                         nombreCategoria = mapaCategorias.get(pub.getId_Categoria());
                                     }
                                     Opción 2: Si el objeto Publicacion tuviera un getNombreCategoria()
                                     String nombreCategoria = pub.getNombreCategoria();
                                     Por ahora, se muestra el ID o un placeholder si se usa el mapa.
                                --%>
                                <p class="card-text text-muted">Categoría: <%= pub.getNombreCategoria()%></p>

                                <%-- Truncar descripción si es muy larga --%>
                                <%
                                    String descripcionCorta = pub.getDescripcion();
                                    if (descripcionCorta != null && descripcionCorta.length() > 100) {
                                        descripcionCorta = descripcionCorta.substring(0, 97) + "...";
                                    } else if (descripcionCorta == null) {
                                        descripcionCorta = "No hay descripción disponible.";
                                    }
                                %>
                                <p class="card-text"><%= descripcionCorta%></p>
                                <div class="d-flex justify-content-between align-items-center mt-auto">
                                    <small class="text-muted">
                                        Publicado el <%= pub.getFecha_Creacion() != null ? sdf.format(pub.getFecha_Creacion()) : "Fecha no disp."%>
                                    </small>
                                    <a href="VerPublicacion?id=<%= pub.getId_Publicacion()%>" class="btn btn-primary btn-sm">Ver receta</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                    <% } else { %>
                    <div class="col-12">
                        <p class="text-center lead">No hay recetas disponibles en este momento. ¡Intenta con otros filtros o vuelve más tarde!</p>
                    </div>
                    <% } %>
                </div>
            </section>

            <%
                Integer paginaActual = (Integer) request.getAttribute("paginaActual");
                Integer totalPaginas = (Integer) request.getAttribute("totalPaginas");
                String queryString = request.getQueryString();
                String baseUrl = "VerRecetas"; // O el servlet que maneja esta vista

                // Remover parámetros de página existentes para construir nuevos enlaces
                if (queryString != null) {
                    queryString = queryString.replaceAll("&?pagina=\\d+", "");
                    if (!queryString.isEmpty() && !queryString.startsWith("?")) {
                        baseUrl += "?" + queryString;
                    } else if (!queryString.isEmpty()) {
                        baseUrl += queryString;
                    }
                }
                String conector = baseUrl.contains("?") ? "&" : "?";
            %>

            <% if (totalPaginas != null && totalPaginas > 1 && paginaActual != null) {%>
            <nav aria-label="Navegación de páginas" class="my-5">
                <ul class="pagination justify-content-center">
                    <li class="page-item <%= paginaActual == 1 ? "disabled" : ""%>">
                        <a class="page-link" href="<%= paginaActual > 1 ? baseUrl + conector + "pagina=" + (paginaActual - 1) : "#"%>">Anterior</a>
                    </li>

                    <%-- Lógica de números de página más avanzada podría ir aquí (ej. mostrar solo algunas páginas) --%>
                    <% for (int i = 1; i <= totalPaginas; i++) {%>
                    <li class="page-item <%= i == paginaActual ? "active" : ""%>">
                        <a class="page-link" href="<%= baseUrl + conector + "pagina=" + i%>"><%= i%></a>
                    </li>
                    <% }%>

                    <li class="page-item <%= paginaActual.equals(totalPaginas) ? "disabled" : ""%>">
                        <a class="page-link" href="<%= paginaActual < totalPaginas ? baseUrl + conector + "pagina=" + (paginaActual + 1) : "#"%>">Siguiente</a>
                    </li>
                </ul>
            </nav>
            <% }%>
        </main>

        <footer>
            <div class="container">
                <div class="footer-content">
                    <h5>El sazón de Toto</h5>
                    <p>Tu blog de cocina favorito</p>
                </div>
                <div class="copyright">
                    &copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date())%> - El sazón de Toto - Todos los derechos reservados
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
</html>