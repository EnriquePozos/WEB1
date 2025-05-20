/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import com.mycompany.web1.models.Categoria;

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
public class CategoriaDAO {

    Connection conn;

    //Por medio del constructor puede acceder a la conexion establecida en la clase Conexion.
    public CategoriaDAO(Connection conn) {
        this.conn = conn;
    }
    //Obtener id categoria por Nombre

    public Categoria getIdCategoria(String nombreCategoria) {
        PreparedStatement ps = null;
        Categoria categoria = null;
        try {
            ps = conn.prepareStatement("Select id_Categoria From Categoria where Nombre=?");
            ps.setString(1, nombreCategoria);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                categoria = new Categoria();

                categoria.setId_Categoria(rs.getInt("id_Categoria"));
            }
        } catch (SQLException ex) {

        }
        return categoria;
    }

    //Obtener nombre categoria por id
    public Categoria getNombreCategoria(int idCategoria) {
        PreparedStatement ps = null;
        Categoria categoria = null;
        try {
            ps = conn.prepareStatement("Select Nombre From Categoria where id_Categoria=?");
            ps.setInt(1, idCategoria);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                categoria = new Categoria();

                categoria.setNombre(rs.getString("Nombre"));
            }
        } catch (SQLException ex) {

        }
        return categoria;
    }

}
