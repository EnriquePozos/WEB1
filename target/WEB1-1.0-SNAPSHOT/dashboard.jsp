<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
  <head>
    <!-- Metadatos -->
    <meta charset="utf-8">
    <meta name="author" content="Cynthia Sustaita">
    <meta name="description" content="Blog de cocina: El sazón de Toto">
    <meta name="keywords" content="recetas, cocina, comida, blog de cocina">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Titulo -->
    <title>Recetas - El sazón de Toto</title>
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
    <!-- Precargar banner -->
    <link rel="preload" href="imagenes/banner.png" as="image">
  </head>

<body>
  <header>
    <!-- Barra de navegaciÃ³n -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
      <div class="container">
        <!-- Logo a la izquierda -->
        <a class="navbar-brand" href="index.jsp">
          <img src="imagenes/Logo.png" width="40" alt="Logo El sazÃ³n de Toto">
          <span>El sazón de Toto</span>
        </a>
        
        <!-- BotÃ³n de hamburguesa para mÃ³viles -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-toggler" 
            aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbar-toggler">
          <!-- Barra de bÃºsqueda en el centro (visible en desktop) -->
          <div class="search-container d-none d-lg-block">
            <form class="d-flex">
              <input class="form-control me-2" type="search" placeholder="Buscar recetas..." aria-label="Search">
              <button class="btn btn-outline-success" type="submit">
                <i class="bi bi-search"></i>
              </button>
            </form>
          </div>
          
          <!-- Opciones de navegaciÃ³n a la derecha -->
          <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link" href="index.jsp">Inicio</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="dashboard.jsp">Recetas</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="perfil.jsp">Mi perfil</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="login.jsp">Iniciar sesión</a>
            </li>
          </ul>
          
          <!-- Barra de bÃºsqueda para mÃ³viles -->
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
    <!-- TÃ­tulo de la pÃ¡gina -->
    <section class="titulo-dashboard text-center mb-5">
      <h1 class="display-4 fw-bold text-primary">Nuestro recetario</h1>
      <p class="lead">Explora todas las deliciosas recetas compartidas por nuestra comunidad...</p>
    </section>

    <!-- Filtros y buscador avanzado -->
    <section class="filtros bg-light p-4 rounded mb-5">
      <h2 class="fs-4 mb-3">Filtrar recetas</h2>
      <div class="row g-3">
        <div class="col-md-8">
          <div class="row g-2">
            <div class="col-md-6">
              <div class="input-group mb-2">
                <span class="input-group-text"><i class="bi bi-calendar3"></i></span>
                <input type="date" class="form-control" id="fecha-inicial" name="fecha-inicial" placeholder="Desde">
              </div>
            </div>
            <div class="col-md-6">
              <div class="input-group mb-2">
                <span class="input-group-text"><i class="bi bi-calendar3"></i></span>
                <input type="date" class="form-control" id="fecha-final" name="fecha-final" placeholder="Hasta">
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <select class="form-select mb-2" id="categoria">
            <option selected>CategorÃ­a</option>
            <option>Desayunos</option>
            <option>Postres</option>
            <option>Bebidas</option>
            <option>Vegano</option>
            <option>Platos fuertes</option>
            <option>Snacks y aperitivos</option>
            <option>RÃ¡pido y fÃ¡cil</option>
            <option>Sopas y cremas</option>
            <option>Ocasiones especiales</option>
          </select>
        </div>
        <div class="col-12 text-end">
          <button type="submit" class="btn btn-primary">
            <i class="bi bi-funnel me-1"></i> Aplicar filtros
          </button>
          <button type="reset" class="btn btn-outline-secondary ms-2">
            <i class="bi bi-x-circle me-1"></i> Limpiar
          </button>
        </div>
      </div>
    </section>

    <!-- Grid de recetas -->
    <section class="recetas-grid">
      <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <!-- Receta 1 -->
        <div class="col">
          <div class="card receta h-100">
            <img src="imagenes/tacospastor.jpg" class="card-img-top" alt="Tacos al pastor">
            <div class="card-body">
              <h3 class="card-title">Tacos al pastor</h3>
              <p class="card-text text-muted">CategorÃ­a: Platos fuertes</p>
              <p class="card-text">Los tacos al pastor son uno de los platillos mÃ¡s populares en MÃ©xico, con su deliciosa carne marinada en achiote y piÃ±a...</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Publicado el 15/01/2025</small>
                <button class="btn btn-primary btn-sm">Ver receta</button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Receta 2 -->
        <div class="col">
          <div class="card receta h-100">
            <img src="imagenes/paymanzana.png" class="card-img-top" alt="Pay de manzana">
            <div class="card-body">
              <h3 class="card-title">Pay de manzana</h3>
              <p class="card-text text-muted">CategorÃ­a: Postres</p>
              <p class="card-text">Postre clÃ¡sico con un toque de vainilla y canela, perfecto para acompaÃ±ar con una taza de cafÃ© o tÃ© caliente...</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Publicado el 28/01/2025</small>
                <button class="btn btn-primary btn-sm">Ver receta</button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Receta 3 -->
        <div class="col">
          <div class="card receta h-100">
            <img src="imagenes/cafe.jpg" class="card-img-top" alt="CafÃ© de especialidad">
            <div class="card-body">
              <h3 class="card-title">CafÃ© de especialidad</h3>
              <p class="card-text text-muted">CategorÃ­a: Bebidas</p>
              <p class="card-text">El cafÃ© es una de las bebidas mÃ¡s consumidas en el mundo. Aprende a preparar un cafÃ© de especialidad en casa...</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Publicado el 05/02/2025</small>
                <button class="btn btn-primary btn-sm">Ver receta</button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Receta 4 -->
        <div class="col">
          <div class="card receta h-100">
            <img src="imagenes/ensalada.jpeg" class="card-img-top" alt="Ensalada mediterrÃ¡nea">
            <div class="card-body">
              <h3 class="card-title">Ensalada del bosque</h3>
              <p class="card-text text-muted">CategorÃ­a: Vegano</p>
              <p class="card-text">Una deliciosa ensalada con ingredientes frescos como lechuga, nueces, blueberrries y un aderezo de limÃ³n con hierbas...</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Publicado el 10/02/2025</small>
                <button class="btn btn-primary btn-sm">Ver receta</button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Receta 5 -->
        <div class="col">
          <div class="card receta h-100">
            <img src="imagenes/sopaverduras.webp" class="card-img-top" alt="Sopa de verduras">
            <div class="card-body">
              <h3 class="card-title">Sopa de verduras</h3>
              <p class="card-text text-muted">CategorÃ­a: Sopas y cremas</p>
              <p class="card-text">Una reconfortante sopa casera llena de vegetales frescos, perfecta para los dÃ­as frÃ­os o cuando necesitas algo ligero...</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Publicado el 15/02/2025</small>
                <button class="btn btn-primary btn-sm">Ver receta</button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Receta 6 -->
        <div class="col">
          <div class="card receta h-100">
            <img src="imagenes/sandwich.jpg" class="card-img-top" alt="SÃ¡ndwich gourmet">
            <div class="card-body">
              <h3 class="card-title">SÃ¡ndwich gourmet</h3>
              <p class="card-text text-muted">CategorÃ­a: RÃ¡pido y fÃ¡cil</p>
              <p class="card-text">Eleva tu sÃ¡ndwich a otro nivel con esta receta que combina ingredientes frescos y una deliciosa salsa casera...</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Publicado el 20/02/2025</small>
                <button class="btn btn-primary btn-sm">Ver receta</button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Receta 7 -->
        <div class="col">
          <div class="card receta h-100">
            <img src="imagenes/lasagna.png" class="card-img-top" alt="LasaÃ±a vegetariana">
            <div class="card-body">
              <h3 class="card-title">LasaÃ±a vegetariana</h3>
              <p class="card-text text-muted">CategorÃ­a: Platos fuertes</p>
              <p class="card-text">Una deliciosa versiÃ³n vegetariana del clÃ¡sico italiano, con capas de berenjena, calabacÃ­n y una rica salsa de tomate...</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Publicado el 25/02/2025</small>
                <button class="btn btn-primary btn-sm">Ver receta</button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Receta 8 -->
        <div class="col">
          <div class="card receta h-100">
            <img src="imagenes/smoothie.webp" class="card-img-top" alt="Smoothie de frutas">
            <div class="card-body">
              <h3 class="card-title">Smoothie de frutas</h3>
              <p class="card-text text-muted">CategorÃ­a: Bebidas</p>
              <p class="card-text">Refrescante y nutritivo smoothie con una combinaciÃ³n de frutas, yogur y un toque de miel para endulzar naturalmente...</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Publicado el 01/03/2025</small>
                <button class="btn btn-primary btn-sm">Ver receta</button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Receta 9 -->
        <div class="col">
          <div class="card receta h-100">
            <img src="imagenes/galletas.jpeg" class="card-img-top" alt="Galletas de avena">
            <div class="card-body">
              <h3 class="card-title">Galletas de avena</h3>
              <p class="card-text text-muted">CategorÃ­a: Snacks y aperitivos</p>
              <p class="card-text">Deliciosas galletas caseras con avena, pasas y un toque de canela. Perfectas para la merienda o el desayuno...</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Publicado el 05/03/2025</small>
                <button class="btn btn-primary btn-sm">Ver receta</button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Receta 10 -->
        <div class="col">
          <div class="card receta h-100">
            <img src="imagenes/pastelchocolate.jpg" class="card-img-top" alt="Pastel de chocolate">
            <div class="card-body">
              <h3 class="card-title">Pastel de chocolate</h3>
              <p class="card-text text-muted">CategorÃ­a: Ocasiones especiales</p>
              <p class="card-text">Un espectacular pastel de chocolate oscuro con un centro hÃºmedo y una cobertura de ganache sedosa...</p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Publicado el 10/03/2025</small>
                <button class="btn btn-primary btn-sm">Ver receta</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <!-- PaginaciÃ³n -->
    <nav aria-label="NavegaciÃ³n de pÃ¡ginas" class="my-5">
      <ul class="pagination justify-content-center">
        <li class="page-item disabled">
          <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Anterior</a>
        </li>
        <li class="page-item active" aria-current="page">
          <a class="page-link" href="#">1</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#">2</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#">3</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#">Siguiente</a>
        </li>
      </ul>
    </nav>
  </main>
  
  <footer>
    <div class="container">
      <div class="footer-content">
        <h5>El sazÃ³n de Toto</h5>
        <p>Tu blog de cocina favorito</p>
      </div>
      <div class="copyright">
        &copy; 2025 - El sazÃ³n de Toto - Todos los derechos reservados
      </div>
    </div>
  </footer>
  
  <!-- JavaScript de Bootstrap -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>