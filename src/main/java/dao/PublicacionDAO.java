/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import com.mycompany.web1.models.Publicacion;
import com.mycompany.web1.models.Usuario;
import com.mycompany.web1.models.Categoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import java.sql.Timestamp;

/**
 *
 * @author Pozos
 */
public class PublicacionDAO {

    Connection conn;

    //Por medio del constructor puede acceder a la conexion establecida en la clase Conexion.
    public PublicacionDAO(Connection conn) {
        this.conn = conn;
    }

    //Agregar Receta
    public boolean insertReceta(Publicacion publicacion) {

        PreparedStatement ps = null;

        try {
            //cada "?" es un valor almacenado en el modelo.
            ps = conn.prepareStatement("INSERT INTO Publicacion (Titulo, Descripcion, Foto_Receta, id_Categoria, id_Autor) VALUES (?, ?, ? ,?, ?)");

            //Esos valores se llenan por medio del siguiente metodo y el primer argumento que se pide es la posicion del "?"
            //contando de izquierda a derecha, se tiene que especificar que tipo de dato se va almacenar, ejemplo: setString, int setInt,etc.
            ps.setString(1, publicacion.getTitulo()); //El num en query
            ps.setString(2, publicacion.getDescripcion());
            ps.setString(3, publicacion.getFoto_Receta());
            ps.setInt(4, publicacion.getId_Categoria());
            ps.setInt(5, publicacion.getId_Autor());

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

    public List<Publicacion> getPublicacionesDeUsuario(int idAutor) {
        List<Publicacion> listaPublicaciones = new ArrayList<>();

        PreparedStatement ps = null;

        try {
            ps = conn.prepareStatement("SELECT * FROM PUBLICACION WHERE id_Autor = ? and Activa = TRUE");

            ps.setInt(1, idAutor);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Publicacion publicacion = new Publicacion();

                publicacion.setId_Publicacion(rs.getInt("id_Publicacion"));
                publicacion.setTitulo(rs.getString("Titulo"));
                publicacion.setDescripcion(rs.getString("Descripcion"));
                publicacion.setFecha_Creacion(rs.getTimestamp("Fecha_Creacion"));
                publicacion.setFoto_Receta(rs.getString("Foto_Receta"));

                listaPublicaciones.add(publicacion);
            }
        } catch (SQLException ex) {

        }

        return listaPublicaciones;

    }

    //Solo puede modificar Titulo y Descripcion
    public Publicacion getPublicacionAModificar(int idPublicacion, int idAutor) {
        PreparedStatement ps = null;
        Publicacion publicacion = null;
        try {
            ps = conn.prepareStatement("SELECT * FROM PUBLICACION where id_Publicacion=(?) AND id_Autor= (?)");
            ps.setInt(1, idPublicacion);
            ps.setInt(2, idAutor);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                publicacion = new Publicacion();
                //Crea un obj con la info que me trajo el query
                publicacion.setId_Publicacion(rs.getInt("id_Publicacion"));
                publicacion.setTitulo(rs.getString("Titulo"));
                publicacion.setDescripcion(rs.getString("Descripcion"));
            }
        } catch (SQLException ex) {

        }
        return publicacion;
    }

    public boolean updatePublicacion(Publicacion publicacion) { // Cambiado a boolean
        PreparedStatement ps = null;

        try {
            ps = conn.prepareStatement("UPDATE PUBLICACION SET Titulo = ?, Descripcion = ? WHERE id_Publicacion = ?");

            ps.setString(1, publicacion.getTitulo());
            ps.setString(2, publicacion.getDescripcion());
            ps.setInt(3, publicacion.getId_Publicacion());

            int affectedRows = ps.executeUpdate(); // Cambiado 'update' a 'affectedRows' para claridad

            if (affectedRows > 0) {
                System.out.println("Publicación actualizada exitosamente.");
                return true;
            } else {
                System.out.println("No se actualizó la publicación (ID no encontrado o datos idénticos).");
                return false; // No se actualizó o los datos eran los mismos
            }
        } catch (SQLException ex) {
            System.err.println("Error SQL al actualizar publicación: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar PreparedStatement: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        }
    }

    //Eliminar publicación
    public boolean deletePublicacion(int idPublicacion) { // Cambiado a boolean
        PreparedStatement ps = null;

        try {
            // Tu conexión 'conn' debe estar inicializada y abierta antes de llamar a este método
            ps = conn.prepareStatement("UPDATE PUBLICACION SET Activa = ? WHERE id_Publicacion = ?");
            ps.setBoolean(1, false); // Establece Activa a false
            ps.setInt(2, idPublicacion);

            int affectedRows = ps.executeUpdate(); 

            if (affectedRows > 0) { 
                
                return true; // 
            } else {

                return false;
            }
        } catch (SQLException ex) {
            
            ex.printStackTrace(); // Mínimo para ver el error en consola durante desarrollo
            return false; 
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace(); // Loguear error al cerrar
                }
            }
            
        }
    }
    
    
    
    
    

}
