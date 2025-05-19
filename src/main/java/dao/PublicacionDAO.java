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
    
    public List<Publicacion> getPublicacionesDeUsuario(int idAutor){
            List<Publicacion> listaPublicaciones = new ArrayList<>();
    
    PreparedStatement ps=null;
      
        try{
             ps = conn.prepareStatement("SELECT * FROM PUBLICACION WHERE id_Autor = ? and Activa = TRUE");
       
             ps.setInt(1,idAutor);
        
        ResultSet rs = ps.executeQuery();
        
       while(rs.next()){
       Publicacion publicacion = new Publicacion();
       
       publicacion.setTitulo(rs.getString("Titulo"));
       publicacion.setDescripcion(rs.getString("Descripcion"));
       publicacion.setFecha_Creacion(rs.getTimestamp("Fecha_Creacion"));
       publicacion.setFoto_Receta(rs.getString("Foto_Receta"));
       
       
       listaPublicaciones.add(publicacion);
       }
        }catch(SQLException ex){
        
        }
       
    
    return listaPublicaciones;
        
    }
    
    
    
}