<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <!-- Metadatos -->
        <meta charset="utf-8">
        <meta name="author" content="Cynthia Sustaita">
        <meta name="description" content="Blog de cocina: El sazÃ³n de Toto">
        <meta name="keywords" content="recetas, cocina, comida, blog de cocina">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Titulo -->
        <title>El sazón de Toto</title>
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
        <!-- Pre carga de imagenes -->
        <link rel="preload" href="imagenes/banner.png" as="image">
    </head>

    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-light sticky-top">
                <div class="container navbar-container">
                    <!-- Logo y nombre a la izquierda -->
                    <div class="navbar-left">
                        <a class="navbar-brand" href="#">
                            <img src="imagenes/Logo.png" width="50" alt="Logo El sazón de Toto">
                            <span>El sazón de Toto</span>
                        </a>
                    </div>

                    <!-- Barra de bÃºsqueda centrada (solo desktop) -->
                    <div class="navbar-center d-none d-lg-flex">
                        <form class="d-flex" method = "post" action = "BusquedaSencilla">
                            <input id="buscar" name = "buscar" class="form-control me-2" type="search" placeholder="Buscar recetas..." aria-label="Search">
                            <button class="btn btn-outline-success" type="submit">
                                <i class="bi bi-search"></i>
                            </button>
                        </form>
                    </div>

                    <!-- BotÃ³n de hamburguesa para mÃ³viles -->
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-toggler"
                            aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <!-- NavegaciÃ³n a la derecha -->
                    <div class="collapse navbar-collapse navbar-right" id="navbar-toggler">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link active" href="index.jsp">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="VerRecetas">Recetas</a>
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






                        <!-- Barra de bÃºsqueda para mÃ³viles -->
                        <div class="mt-3 d-lg-none w-100">
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

        <main>
            <!-- Banner principal -->
            <section class="banner">
                <img src="imagenes/banner.png" alt="Imagen de El sazÃ³n de Toto" class="img-fluid">
            </section>

            <!-- SecciÃ³n de categorÃ­as -->
            <section class="category-section container">
                <h2 class="text-center">¿Qué quieres cocinar?</h2>

                <!-- Contenedor con desplazamiento horizontal -->
                <div class="row row-cols-2 row-cols-md-5 g-4">

                    <!-- Desayunos -->
                    <div class="col">
                        <div class="category-item text-center">
                            <img src="imagenes/desayunos.webp" class="rounded-circle img-fluid" width="100" height="100" alt="Desayunos">
                            <p class="mt-2">Desayunos</p>
                        </div>
                    </div>

                    <!-- Guarniciones -->
                    <div class="col">
                        <div class="category-item text-center">
                            <img src="imagenes/guarniciones.webp" class="rounded-circle img-fluid" width="100" height="100" alt="Guarniciones">
                            <p class="mt-2">Guarniciones</p>
                        </div>
                    </div>

                    <!-- Postres -->
                    <div class="col">
                        <div class="category-item text-center">
                            <img src="imagenes/postres.webp" class="rounded-circle img-fluid" width="100" height="100" alt="Postres">
                            <p class="mt-2">Postres</p>
                        </div>
                    </div>

                    <!-- Bebidas -->
                    <div class="col">
                        <div class="category-item text-center">
                            <img src="imagenes/bebidas.webp" class="rounded-circle img-fluid" width="100" height="100" alt="Bebidas">
                            <p class="mt-2">Bebidas</p>
                        </div>
                    </div>

                    <!-- Vegano -->
                    <div class="col">
                        <div class="category-item text-center">
                            <img src="imagenes/vegano.webp" class="rounded-circle img-fluid" width="100" height="100" alt="Vegano">
                            <p class="mt-2">Vegano</p>
                        </div>
                    </div>

                    <!-- Platos fuertes -->
                    <div class="col">
                        <div class="category-item text-center">
                            <img src="imagenes/platofuerte.webp" class="rounded-circle img-fluid" width="100" height="100" alt="Platos fuertes">
                            <p class="mt-2">Platos fuertes</p>
                        </div>
                    </div>

                    <!-- Snacks y aperitivos -->
                    <div class="col">
                        <div class="category-item text-center">
                            <img src="imagenes/snacks.webp" class="rounded-circle img-fluid" width="100" height="100" alt="Snacks y aperitivos">
                            <p class="mt-2">Snacks y aperitivos</p>
                        </div>
                    </div>

                    <!-- RÃ¡pido y fÃ¡cil -->
                    <div class="col">
                        <div class="category-item text-center">
                            <img src="imagenes/rapidoyfacil.webp" class="rounded-circle img-fluid" width="100" height="100" alt="RÃ¡pido y fÃ¡cil">
                            <p class="mt-2">Rápido y fácil</p>
                        </div>
                    </div>

                    <!-- Sopas y cremas -->
                    <div class="col">
                        <div class="category-item text-center">
                            <img src="imagenes/sopas.webp" class="rounded-circle img-fluid" width="100" height="100" alt="Sopas y cremas">
                            <p class="mt-2">Sopas y cremas</p>
                        </div>
                    </div>

                    <!-- Ocasiones especiales -->
                    <div class="col">
                        <div class="category-item text-center">
                            <img src="imagenes/ocasionesespeciales.webp" class="rounded-circle img-fluid" width="100" height="100" alt="Ocasiones especiales">
                            <p class="mt-2">Ocasiones especiales</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Recetas mejor valoradas -->
            <section id="recetas-valoradas" class="recetas-valoradas">
                <div class="container">
                    <h2 class="seccion-titulo">Nuestras recetas mejor valoradas</h2>
                    <h3 class="seccion-descripcion">Nuestra comunidad recomienda estas recetas...</h3>

                    <!-- Galeria de recetas -->
                    <div class="row">
                        <!-- Receta 1 -->
                        <div class="col-12 col-md-6 col-lg-4">
                            <div class="receta">
                                <img src="imagenes/sandwich.jpg" alt="SÃ¡ndwich">
                                <div class="overlay">
                                    <p class="titulo-receta">Sándwich</p>
                                    <p class="categoria">Categoría: Rápido y fácil</p>
                                    <p class="autor">Autor: Cynthia Sustaita</p>
                                    <button class="receta-btn">Ver receta</button>
                                </div>
                            </div>
                        </div>

                        <!-- Receta 2 -->
                        <div class="col-12 col-md-6 col-lg-4">
                            <div class="receta">
                                <img src="imagenes/ensalada.jpeg" alt="Ensalada de Bosque">
                                <div class="overlay">
                                    <p class="titulo-receta">Ensalada del Bosque</p>
                                    <p class="categoria">Categorí­a: Vegano</p>
                                    <p class="autor">Autor: Marí­a Torres</p>
                                    <button class="receta-btn">Ver receta</button>
                                </div>
                            </div>
                        </div>

                        <!-- Receta 3 -->
                        <div class="col-12 col-md-6 col-lg-4">
                            <div class="receta">
                                <img src="imagenes/pastelchocolate.jpg" alt="Pastel de Chocolate">
                                <div class="overlay">
                                    <p class="titulo-receta">Pastel de Chocolate</p>
                                    <p class="categoria">Categorí­a: Postres</p>
                                    <p class="autor">Autor: Juan Martí­nez</p>
                                    <button class="receta-btn">Ver receta</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- BotÃ³n para ver mÃ¡s -->
                    <div class="text-center mt-4">
                        <a href="dashboard.jsp" class="btn btn-lg" style="background-color: var(--color-primary); color: white;">
                            Ver más recetas
                        </a>
                    </div>
                </div>
            </section>
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
    </body>
</html>