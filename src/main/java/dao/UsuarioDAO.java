/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import com.mycompany.web1.models.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Pozos
 */
public class UsuarioDAO {

    Connection conn;

    //Por medio del constructor puede acceder a la conexion establecida en la clase Conexion.
    public UsuarioDAO(Connection conn) {
        this.conn = conn;
    }
    //Registrarse
    public boolean insertUsuario(Usuario usuario) {

        PreparedStatement ps = null;

        try {
            //cada "?" es un valor almacenado en el modelo.
            ps = conn.prepareStatement("INSERT INTO USUARIO (Usuario, Correo, Contrasenia, Nombre, Apellido_P, Apellido_M, Fecha_Nacimiento, Edad, Foto_Perfil, Activa) VALUES (?, ?, ? ,?, ?, ?, ?, ?, ?, TRUE)");

            //Esos valores se llenan por medio del siguiente metodo y el primer argumento que se pide es la posicion del "?"
            //contando de izquierda a derecha, se tiene que especificar que tipo de dato se va almacenar, ejemplo: setString, int setInt,etc.
            ps.setString(1, usuario.getUsuario()); //El num en query
            ps.setString(2, usuario.getCorreo());
            ps.setString(3, usuario.getContrasenia());
            ps.setString(4, usuario.getNombre());
            ps.setString(5, usuario.getApellido_P());
            ps.setString(6, usuario.getApellido_M());
            ps.setDate(7, usuario.getFecha_Nacimiento());
            ps.setInt(8,usuario.getEdad());
            ps.setString(9, usuario.getFoto_Perfil()); 

            int insert = ps.executeUpdate();

            if (insert != 0) {

                return true;

            } else {

                return false;

            }
        } catch (SQLException ex) {
            System.out.println("Error SQL: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }

    }
    
    //Iniciar sesión 
    public Usuario getUsuario(String nombreUsuario,String Contrasenia){
      PreparedStatement ps = null;
        Usuario usuario = null;
        try{
        ps = conn.prepareStatement("SELECT * FROM USUARIO where (Usuario=(?) or Correo =(?)) AND Contrasenia= (?)");
        ps.setString(1, nombreUsuario);
        ps.setString(2, nombreUsuario);
        ps.setString(3, Contrasenia);
        
        ResultSet rs = ps.executeQuery();
        
       while(rs.next()){
       usuario = new Usuario();
       //Crea un obj con la info que me trajo el query
       usuario.setId_Usuario(rs.getInt("id_Usuario"));
       usuario.setNombre(rs.getString("Nombre"));
       usuario.setContrasenia(rs.getString("Contrasenia"));
       usuario.setUsuario(rs.getString("Usuario"));
       usuario.setCorreo(rs.getString("Correo"));
       usuario.setApellido_P(rs.getString("Apellido_P"));
       usuario.setApellido_M(rs.getString("Apellido_M"));
       usuario.setFecha_Nacimiento(rs.getDate("Fecha_Nacimiento"));
       usuario.setFoto_Perfil(rs.getString("Foto_Perfil"));
       usuario.setFecha_Creacion(rs.getTimestamp("Fecha_Creacion"));
 
       }
        }catch(SQLException ex){
        
        }
        return usuario;
    }
    
    //Modificar usuario (foto de perfil, nombre, usuario, apellidos, , fecha nacimiento,)
    public boolean updateUsuario(Usuario usuario) { // Cambiado a boolean
    PreparedStatement ps = null;
    // El nombre de la tabla es 'USUARIO' y la columna ID es 'id_Usuario' según tu modelo Usuario.java
    // La columna para el nombre de usuario es 'Usuario' según tu modelo.
    String sql = "UPDATE USUARIO SET Usuario = ?, Contrasenia = ?, Nombre = ?, Apellido_P = ?, Apellido_M = ? WHERE id_Usuario = ?";

    try {
        // Es una buena práctica verificar la conexión aquí si es una variable de instancia
        if (conn == null || conn.isClosed()) {
            System.err.println("Error: La conexión a la base de datos no está disponible o está cerrada.");
            return false; // No se puede operar sin conexión
        }

        ps = conn.prepareStatement(sql);
        ps.setString(1, usuario.getUsuario());       // Nombre de usuario (username)
        ps.setString(2, usuario.getContrasenia());   // Contraseña (¡Debería estar hasheada!)
        ps.setString(3, usuario.getNombre());        // Nombre real de la persona
        ps.setString(4, usuario.getApellido_P());
        ps.setString(5, usuario.getApellido_M());
        ps.setInt(6, usuario.getId_Usuario());       // ID del usuario a actualizar

        int affectedRows = ps.executeUpdate();

        // executeUpdate() devuelve el número de filas afectadas.
        // Si es mayor que 0, la actualización fue exitosa.
        if (affectedRows > 0) {
            // System.out.println("Usuario actualizado exitosamente. Filas afectadas: " + affectedRows); // Mensaje para depuración
            return true; // Actualización exitosa
        } else {
            // System.out.println("No se actualizó el usuario. Puede que el id_Usuario no exista o los datos eran los mismos."); // Mensaje para depuración
            return false; // No se actualizó ninguna fila (o los datos eran idénticos)
        }
    } catch (SQLException ex) {
        System.err.println("Error de SQL al actualizar usuario: " + ex.getMessage());
        ex.printStackTrace(); // Imprimir el stack trace para obtener más detalles del error
        return false; // Ocurrió un error durante la actualización
    } finally {
        // Siempre cerrar el PreparedStatement en el bloque finally
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar PreparedStatement: " + e.getMessage());
                e.printStackTrace();
            }
        }
        // La conexión (conn) generalmente no se cierra aquí si es manejada externamente (ej. por el servlet o un pool)
    }
}
    
    
    public Usuario getUsuarioById(int idUsuario) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        Usuario usuario = null;
        String sql = "SELECT * FROM USUARIO WHERE id_Usuario = ?";

        try {
            if (this.conn == null || this.conn.isClosed()) {
                System.err.println("DAO Error: La conexión a la BD no está disponible.");
                return null;
            }
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId_Usuario(rs.getInt("id_Usuario"));
                usuario.setUsuario(rs.getString("Usuario"));
                usuario.setCorreo(rs.getString("Correo"));
                usuario.setContrasenia(rs.getString("Contrasenia")); // Importante para mantenerla en sesión
                usuario.setNombre(rs.getString("Nombre"));
                usuario.setApellido_P(rs.getString("Apellido_P"));
                usuario.setApellido_M(rs.getString("Apellido_M"));
                usuario.setFoto_Perfil(rs.getString("Foto_Perfil"));

            }
        } catch (SQLException ex) {
            System.err.println("Error SQL al obtener usuario por ID: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return usuario;
    }
    
}
