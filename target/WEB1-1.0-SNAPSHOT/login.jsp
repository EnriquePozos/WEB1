<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
  <head>
    <!-- Metadatos -->
    <meta charset="utf-8">
    <meta name="author" content="Cynthia Sustaita">
    <meta name="description" content="Blog de cocina: El sazón de Toto - Iniciar sesión o registrarse">
    <meta name="keywords" content="recetas, cocina, comida, blog de cocina, login, registro">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Titulo -->
    <title>Iniciar sesión - El sazón de Toto</title>
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="imagenes/cookieicon.svg">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Iconos de Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <!-- CSS -->
    <link href="style.css" rel="stylesheet">
    <link href="validaciones.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet">
  </head>

<body>
  <header>
    <!-- Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
      <div class="container">
        <!-- Logo a la izquierda -->
        <a class="navbar-brand" href="index.jsp">
          <img src="imagenes/Logo.png" width="40" alt="Logo El sazón de Toto">
          <span>El sazón de Toto</span>
        </a>
        
        <!-- Botón de hamburguesa para móviles -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-toggler" 
            aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbar-toggler">
          <!-- Barra de búsqueda en el centro (visible en desktop) -->
          <div class="search-container d-none d-lg-block">
            <form class="d-flex">
              <input class="form-control me-2" type="search" placeholder="Buscar recetas..." aria-label="Search">
              <button class="btn btn-outline-success" type="submit">
                <i class="bi bi-search"></i>
              </button>
            </form>
          </div>
          
          <!-- Opciones de navegación a la derecha -->
          <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link" href="index.jsp">Inicio</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="dashboard.jsp">Recetas</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="perfil.jsp">Mi perfil</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="login.jsp">Iniciar sesión</a>
            </li>
          </ul>
          
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
        <!-- Tarjeta de acceso con pestañas -->
        <div class="card acceso-card">
          <div class="card-body">
            <!-- Tabs para alternar entre inicio de sesión y registro -->
            <ul class="nav nav-tabs mb-4" id="authTabs" role="tablist">
              <li class="nav-item" role="presentation">
                <button class="nav-link active" id="login-tab" data-bs-toggle="tab" data-bs-target="#login-panel" type="button" role="tab" aria-controls="login-panel" aria-selected="true">
                  <i class="bi bi-box-arrow-in-right me-2"></i>Iniciar sesión
                </button>
              </li>
              <li class="nav-item" role="presentation">
                <button class="nav-link" id="register-tab" data-bs-toggle="tab" data-bs-target="#register-panel" type="button" role="tab" aria-controls="register-panel" aria-selected="false">
                  <i class="bi bi-person-plus me-2"></i>Registrarse
                </button>
              </li>
            </ul>
            
            <div class="tab-content" id="authTabsContent">
              <!-- Panel de inicio de sesión -->
              <div class="tab-pane fade show active" id="login-panel" role="tabpanel" aria-labelledby="login-tab">
                <div class="text-center mb-4">
                  <img src="imagenes/Logo.png" width="80" alt="Logo" class="mb-3">
                  <h2 class="fw-bold texto-azul-oscuro">¡Bienvenido de nuevo!</h2>
                  <p class="text-muted">Ingresa tus credenciales para acceder</p>
                </div>
                
                <form class="login-form" action = "Login" method ="post">
                  <div class="mb-3">
                    <label for="usuario" class="form-label">Nombre de usuario o correo electrónico</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="bi bi-person"></i></span>
                      <input type="text" class="form-control" id="usuario" name="usuario" required>
                    </div>
                  </div>
                  
                  <div class="mb-3">
                    <label for="password" class="form-label">Contraseña</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="bi bi-lock"></i></span>
                      <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                  </div>
                  
                  <div class="d-grid gap-2 mb-4">
                    <button type="submit" class="btn btn-primary login-btn">
                      <i class="bi bi-box-arrow-in-right me-2"></i>Iniciar sesión
                    </button>
                  </div>
                  
                  <div class="text-center">
                    <p class="mb-0">¿No tienes una cuenta?</p>
                    <button type="button" class="btn btn-link" data-bs-toggle="tab" data-bs-target="#register-panel">Regístrate aquí</button>
                  </div>
                </form>
              </div>
              
              <!-- Panel de registro -->
              <div class="tab-pane fade" id="register-panel" role="tabpanel" aria-labelledby="register-tab">
                <div class="text-center mb-4">
                  <h2 class="fw-bold texto-azul-oscuro">Crear una cuenta</h2>
                  <p class="text-muted">Únete a nuestra comunidad de amantes de la cocina</p>
                </div>
                
                <form class="register-form" action = "Registro" method ="post">
                  <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre(s)</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" required>
                  </div>
                  
                  <div class="row mb-3">
                    <div class="col-md-6 mb-3 mb-md-0">
                      <label for="apellido_paterno" class="form-label">Apellido Paterno</label>
                      <input type="text" class="form-control" id="apellido_paterno" name="apellido_paterno" required>
                    </div>
                    <div class="col-md-6">
                      <label for="apellido_materno" class="form-label">Apellido Materno</label>
                      <input type="text" class="form-control" id="apellido_materno" name="apellido_materno" required>
                    </div>
                  </div>
                  
                  <div class="mb-3">
                    <label for="fecha_nacimiento" class="form-label">Fecha de nacimiento</label>
                    <input type="date" class="form-control" id="fecha_nacimiento" name="fecha_nacimiento" required>
                  </div>
                  
                  <div class="mb-3">
                    <label for="email" class="form-label">Correo electrónico</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                      <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                  </div>
                  
                  <div class="mb-3">
                    <label for="usuario_reg" class="form-label">Nombre de usuario</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="bi bi-person"></i></span>
                      <input type="text" class="form-control" id="usuario_reg" name="usuario_reg" required>
                    </div>
                    <div class="form-text">El nombre de usuario debe tener al menos 5 caracteres.</div>
                  </div>
                  
                  <div class="mb-3">
                    <label for="password_reg" class="form-label">Contraseña</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="bi bi-lock"></i></span>
                      <input type="password" class="form-control" id="password_reg" name="password_reg" required>
                    </div>
                    <div class="form-text">La contraseña debe tener al menos 8 caracteres, incluyendo una letra mayúscula y un número.</div>
                  </div>
                  
                  <div class="mb-3">
                    <label for="confirmar_password" class="form-label">Confirmar contraseña</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                      <input type="password" class="form-control" id="confirmar_password" name="confirmar_password" required>
                    </div>
                  </div>
                  
                  <div class="mb-4">
                    <label for="imagen" class="form-label">Foto de perfil (opcional)</label>
                    <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*">
                  </div>
                  
                  <div class="d-grid gap-2 mb-4">
                    <button type="submit" class="btn btn-primary register-btn">
                      <i class="bi bi-person-plus me-2"></i>Crear cuenta
                    </button>
                  </div>
                  
                  <div class="text-center">
                    <p class="mb-0">¿Ya tienes una cuenta?</p>
                    <button type="button" class="btn btn-link" data-bs-toggle="tab" data-bs-target="#login-panel">Inicia sesión aquí</button>
                  </div>
                </form>
              </div>
            </div>
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
  
  <!-- JavaScript para validaciones -->
  <script src="validaciones.js"></script>
  <<script>
      const params = new URLSearchParams(window.location.search);
      if(params.has("error")){
       alert("Error verifique su sesión");
      }
  </script>
</body>
</html>