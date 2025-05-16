/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

 // Esperar a que el documento esté completamente cargado
document.addEventListener('DOMContentLoaded', function() {
  // Obtener referencia al formulario de registro
  const registerForm = document.querySelector('.register-form');
  
  // Añadir evento de envío al formulario
  if (registerForm) {
    registerForm.addEventListener('submit', function(event) {
      // Prevenir el envío del formulario por defecto
      event.preventDefault();
      
      // Realizar todas las validaciones
      let isValid = true;
      
      // Limpiar mensajes de error previos
      clearErrorMessages();
      
      // Validar campos requeridos
      const requiredFields = {
        'nombre': 'Nombre(s)',
        'apellido_paterno': 'Apellido Paterno',
        'apellido_materno': 'Apellido Materno',
        'fecha_nacimiento': 'Fecha de nacimiento',
        'email': 'Correo electrónico',
        'usuario_reg': 'Nombre de usuario',
        'password_reg': 'Contraseña',
        'confirmar_password': 'Confirmar contraseña'
      };
      
      // Validar campos requeridos
      for (const fieldId in requiredFields) {
        const field = document.getElementById(fieldId);
        if (!field.value.trim()) {
          showError(field, `El campo ${requiredFields[fieldId]} es obligatorio.`);
          isValid = false;
        }
      }
      
      // Validar fecha de nacimiento
      const fechaNacimiento = document.getElementById('fecha_nacimiento');
      if (fechaNacimiento.value) {
        const fechaNac = new Date(fechaNacimiento.value);
        const hoy = new Date();
        
        // Verificar que la fecha sea válida (no NaN)
        if (isNaN(fechaNac.getTime())) {
          showError(fechaNacimiento, 'La fecha de nacimiento no es válida.');
          isValid = false;
        } 
        // Verificar que la fecha no sea en el futuro
        else if (fechaNac > hoy) {
          showError(fechaNacimiento, 'La fecha de nacimiento no puede ser posterior al día actual.');
          isValid = false;
        }
      }
      
      // Validar formato de correo electrónico
      const email = document.getElementById('email');
      if (email.value && !validateEmail(email.value)) {
        showError(email, 'Por favor, introduce un correo electrónico válido.');
        isValid = false;
      }
      
      // Validar nombre de usuario (mínimo 5 caracteres)
      const usuario = document.getElementById('usuario_reg');
      if (usuario.value && usuario.value.length < 5) {
        showError(usuario, 'El nombre de usuario debe tener al menos 5 caracteres.');
        isValid = false;
      }
      
      // Validar contraseña
      const password = document.getElementById('password_reg');
      if (password.value) {
        if (!validatePassword(password.value)) {
          showError(password, 'La contraseña debe tener al menos 8 caracteres, una letra mayúscula, una minúscula, un número y un caracter especial.');
          isValid = false;
        }
      }
      
      // Validar confirmación de contraseña
      const confirmarPassword = document.getElementById('confirmar_password');
      if (confirmarPassword.value && password.value !== confirmarPassword.value) {
        showError(confirmarPassword, 'Las contraseñas no coinciden.');
        isValid = false;
      }
      
      // Si todo es válido, enviar el formulario
      if (isValid) {
        registerForm.submit();
      }
    });
  }
  
  // Función para validar email
  function validateEmail(email) {
    const re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    return re.test(email);
  }
  
  // Función para validar contraseña
  function validatePassword(password) {
    // Al menos 8 caracteres, 1 mayúscula, 1 minúscula, 1 número y 1 caracter especial
    const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$/;
    return re.test(password);
  }
  
  // Función para mostrar mensajes de error
  function showError(field, message) {
    // Crear elemento para el mensaje de error
    const errorDiv = document.createElement('div');
    errorDiv.className = 'invalid-feedback';
    errorDiv.textContent = message;
    
    // Marcar el campo como inválido
    field.classList.add('is-invalid');
    
    // Si el campo está dentro de un input-group, colocar el mensaje después del input-group
    const inputGroup = field.closest('.input-group');
    if (inputGroup) {
      inputGroup.parentNode.appendChild(errorDiv);
    } else {
      field.parentNode.appendChild(errorDiv);
    }
  }
  
  // Función para limpiar mensajes de error
  function clearErrorMessages() {
    // Eliminar todos los mensajes de error
    const errorMessages = document.querySelectorAll('.invalid-feedback');
    errorMessages.forEach(function(message) {
      message.remove();
    });
    
    // Eliminar las clases de validación de todos los campos
    const invalidFields = document.querySelectorAll('.is-invalid');
    invalidFields.forEach(function(field) {
      field.classList.remove('is-invalid');
    });
  }
});


