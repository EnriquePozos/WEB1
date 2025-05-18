<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.web1.models.Usuario"%>

<!DOCTYPE html>
<html lang="es">
  <head>
    <!-- Metadatos -->
    <meta charset="utf-8">
    <meta name="author" content="Cynthia Sustaita">
    <meta name="description" content="Blog de cocina: El sazÃ³n de Toto">
    <meta name="keywords" content="recetas, cocina, comida, blog de cocina, perfil">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Titulo -->
    <title>Mi perfil - El sazón de Toto</title>
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
        String Fecha = usuario.getFecha_Creacion()==null?"":usuario.getFecha_Creacion().toString();
        //Usuario usuario =(Usuario) request.getSession().getAttribute("SesionActual"); 
    
    %>
  <header>
    <!-- Barra de navegaciÃ³n -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
      <div class="container">
        <!-- Logo a la izquierda -->
        <a class="navbar-brand" href="index.jsp">
          <img src="imagenes/Logo.png" width="40" alt="Logo El sazÃ³n de Toto">
          <span>El sazón de Toto</span>
        </a>
        
        <!-- BotÃ³n para mÃ³viles -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-toggler" 
            aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbar-toggler">
          <!-- Barra de bÃºsqueda en el centro (visible en pc) -->
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
              <a class="nav-link" href="dashboard.jsp">Recetas</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="perfil.jsp">Mi perfil</a>
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
    <!-- SecciÃ³n de informaciÃ³n del perfil -->
    <section class="perfil mb-5">
      <div class="row">
        <div class="col-lg-4 mb-4 mb-lg-0">
          <div class="card perfil-card">
            <div class="card-body text-center">
              <div class="avatar-container mb-4">
                <img src="imagenes/fotodeperfil.jpg" class="avatar-img rounded-circle img-thumbnail" alt="Foto de perfil">
              </div>
                <h2 class="card-title fw-bold texto-azul-oscuro"><%=usuario.getNombre()%></h2>
              <p class="text-muted mb-1"><i class="bi bi-envelope me-2"></i><%=usuario.getCorreo()%></p>
              <p class="text-muted mb-3"><i class="bi bi-calendar3 me-2"></i>Se unió: <%=Fecha%></p>
              <button class="btn btn-primary profile-button">
                <i class="bi bi-pencil-square me-2"></i>Editar perfil
              </button>
            </div>
          </div>
        </div>
        
        <!-- Tabs para las diferentes secciones -->
        <div class="col-lg-8">
          <ul class="nav nav-tabs mb-4" id="profileTabs" role="tablist">
            <li class="nav-item" role="presentation">
              <button class="nav-link active" id="mis-recetas-tab" data-bs-toggle="tab" data-bs-target="#mis-recetas" type="button" role="tab" aria-controls="mis-recetas" aria-selected="true">
                <i class="bi bi-journals me-1"></i>Mis recetas
              </button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="nueva-receta-tab" data-bs-toggle="tab" data-bs-target="#nueva-receta" type="button" role="tab" aria-controls="nueva-receta" aria-selected="false">
                <i class="bi bi-plus-circle me-1 "></i>Nueva receta
              </button>
            </li>
          </ul>
          
          <div class="tab-content" id="profileTabsContent">
            <!-- Tab: Mis recetas -->
            <div class="tab-pane fade show active" id="mis-recetas" role="tabpanel" aria-labelledby="mis-recetas-tab">
              <!-- Lista de recetas del usuario -->
              <div class="row">
                <!-- Receta 1 -->
                <div class="col-md-6 mb-4">
                  <div class="card receta h-100">
                    <img src="imagenes/tacospastor.jpg" class="card-img-top" alt="Tacos al pastor">
                    <div class="card-body">
                      <h3 class="card-title">Tacos al pastor</h3>
                      <p class="card-text text-muted">Categorí­a: Platos fuertes</p>
                      <div class="d-flex align-items-center mt-3">
                        <small class="text-muted me-auto">Publicado el 15/01/2025</small>
                        <div class="btn-group">
                          <a href="#" class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-pencil icons-edittrash"></i>
                          </a>
                          <a href="#" class="btn btn-sm btn-outline-danger">
                            <i class="bi bi-trash icons-edittrash"></i>
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                
                <!-- Receta 2 -->
                <div class="col-md-6 mb-4">
                  <div class="card receta h-100">
                    <img src="imagenes/ensalada.jpeg" class="card-img-top" alt="Ensalada mediterrÃ¡nea">
                    <div class="card-body">
                      <h3 class="card-title">Ensalada del bosque</h3>
                      <p class="card-text text-muted">Categorí­a: Vegano</p>
                      <div class="d-flex align-items-center mt-3">
                        <small class="text-muted me-auto">Publicado el 10/02/2025</small>
                        <div class="btn-group">
                          <a href="#" class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-pencil icons-edittrash"></i>
                          </a>
                          <a href="#" class="btn btn-sm btn-outline-danger">
                            <i class="bi bi-trash icons-edittrash"></i>
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                
                <!-- Mensaje para agregar mÃ¡s recetas -->
                <!-- MAYBE SE QUITA PQ NO JALA EL BOOTSTRAP XD
                <div class="col-12 text-center mt-3">
                  <button class="btn btn-outline-primary" data-bs-toggle="tab" data-bs-target="#nueva-receta">
                    <i class="bi bi-plus-circle me-2"></i>Crear nueva receta
                  </button>
                </div>
                 -->
              </div>
            </div>
            
            <!-- Tab: Nueva receta -->
            <div class="tab-pane fade" id="nueva-receta" role="tabpanel" aria-labelledby="nueva-receta-tab">
              <div class="card">
                <div class="card-body">
                  <h2 class="card-title fw-bold mb-4 texto-azul-oscuro">Publicar nueva receta</h2>
                  <form class="nueva-receta-form">
                    <div class="mb-3">
                      <label for="titulo" class="form-label">Tí­tulo de la receta</label>
                      <input type="text" class="form-control" id="titulo" name="titulo" required>
                    </div>
                    
                    <div class="row mb-3">
                      <div class="col-md-6">
                          
                          <!------------------------------VERIFICAR EN LA BD Y TRAERLOS O SETTEARLOS DESDE AQUÍ ----------------------------------->
                        <label for="categoria" class="form-label">Categorí­a</label>
                        <select class="form-select" id="categoria" name="categoria" required>
                          <option value="" selected disabled>Selecciona una categorí­a</option>
                          <option value="desayuno">Desayunos</option>
                          <option value="platos-fuertes">Platos fuertes</option>
                          <option value="guarniciones">Guarniciones</option>
                          <option value="postres">Postres</option>
                          <option value="bebidas">Bebidas</option>
                          <option value="vegano">Vegano</option>
                          <option value="snacks">Snacks y aperitivos</option>
                          <option value="rapido-facil">Rápido y fácil</option>
                          <option value="sopas-cremas">Sopas y cremas</option>
                          <option value="especiales">Ocasiones especiales</option>
                        </select>
                      </div>
                      
                      <div class="col-md-6">
                        <label for="tiempo" class="form-label">Tiempo de preparación</label>
                        <div class="input-group">
                          <input type="number" class="form-control" id="tiempo" name="tiempo" min="1" required>
                          <span class="input-group-text">minutos</span>
                        </div>
                      </div>
                    </div>
                    
                    <div class="mb-3">
                      <label for="descripcion" class="form-label">Descripción</label>
                      <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required></textarea>
                    </div>
                    
                    
                    <div class="mb-4">
                      <label for="imagen" class="form-label">Imagen de la receta</label>
                      <input class="form-control" type="file" id="imagen" name="imagen" accept="image/*">
                      <div class="form-text">Recomendado: imagen cuadrada de al menos 500x500 pí­xeles.</div>
                    </div>
                    
                    <div class="d-flex justify-content-end">
                      <button type="button" class="btn btn-outline-secondary me-2" data-bs-toggle="tab" data-bs-target="#mis-recetas">Cancelar</button>
                      <button type="submit" class="btn btn-primary publicar-btn">
                        <i class="bi bi-upload me-1"></i>Publicar receta
                      </button>
                    </div>
                  </form>
                </div>
              </div>
            </div>

              </div>
            </div>
          </div>
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