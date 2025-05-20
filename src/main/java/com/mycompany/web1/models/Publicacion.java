/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.web1.models;
import java.sql.Timestamp;
/**
 *
 * @author Pozos
 */
public class Publicacion {
 int id_Publicacion;
 String Titulo;
 String Descripcion; 
 Timestamp Fecha_Creacion;
 boolean Activa;
 int id_Categoria; 
 int id_Autor;
 String Foto_Perfil;
 String Foto_Receta;
 String nombreCategoria;

 
 
    public String getNombreCategoria() {
        return nombreCategoria;
    }

    public void setNombreCategoria(String nombreCategoria) {
        this.nombreCategoria = nombreCategoria;
    }
    
 
    public Publicacion(){
         
    }

    public int getId_Publicacion() {
        return id_Publicacion;
    }

    public void setId_Publicacion(int id_Publicacion) {
        this.id_Publicacion = id_Publicacion;
    }

    public String getTitulo() {
        return Titulo;
    }

    public void setTitulo(String Titulo) {
        this.Titulo = Titulo;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public Timestamp getFecha_Creacion() {
        return Fecha_Creacion;
    }

    public void setFecha_Creacion(Timestamp Fecha_Creacion) {
        this.Fecha_Creacion = Fecha_Creacion;
    }

    public boolean isActiva() {
        return Activa;
    }

    public void setActiva(boolean Activa) {
        this.Activa = Activa;
    }

    public int getId_Categoria() {
        return id_Categoria;
    }

    public void setId_Categoria(int id_Categoria) {
        this.id_Categoria = id_Categoria;
    }

    public int getId_Autor() {
        return id_Autor;
    }

    public void setId_Autor(int id_Autor) {
        this.id_Autor = id_Autor;
    }

    public String getFoto_Perfil() {
        return Foto_Perfil;
    }

    public void setFoto_Perfil(String Foto_Perfil) {
        this.Foto_Perfil = Foto_Perfil;
    }

    public String getFoto_Receta() {
        return Foto_Receta;
    }

    public void setFoto_Receta(String Foto_Receta) {
        this.Foto_Receta = Foto_Receta;
    }
    
    

    
}
