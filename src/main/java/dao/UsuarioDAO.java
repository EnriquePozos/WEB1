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
}
