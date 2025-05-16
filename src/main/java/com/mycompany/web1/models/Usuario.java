/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.web1.models; 
import java.sql.Date; 
import java.sql.Timestamp;
/**
 *
 * @author Pozos
 */
public class Usuario {
    int id_Usuario;
    String Usuario;
    String Correo;
    String Contrasenia;
    String Nombre;
    String Apellido_P;
    String Apellido_M;
    Date Fecha_Nacimiento;
    int Edad;
    String Foto_Perfil;
    boolean Activa;
    Timestamp Fecha_Creacion;

    public int getEdad() {
        return Edad;
    }

    public void setEdad(int Edad) {
        this.Edad = Edad;
    }
    
    public Usuario() {
    }

    public int getId_Usuario() {
        return id_Usuario;
    }

    public void setId_Usuario(int id_Usuario) {
        this.id_Usuario = id_Usuario;
    }

    public String getUsuario() {
        return Usuario;
    }

    public void setUsuario(String Usuario) {
        this.Usuario = Usuario;
    }

    public String getCorreo() {
        return Correo;
    }

    public void setCorreo(String Correo) {
        this.Correo = Correo;
    }

    public String getContrasenia() {
        return Contrasenia;
    }

    public void setContrasenia(String Contrasenia) {
        this.Contrasenia = Contrasenia;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getApellido_P() {
        return Apellido_P;
    }

    public void setApellido_P(String Apellido_P) {
        this.Apellido_P = Apellido_P;
    }

    public String getApellido_M() {
        return Apellido_M;
    }

    public void setApellido_M(String Apellido_M) {
        this.Apellido_M = Apellido_M;
    }

    public Date getFecha_Nacimiento() {
        return Fecha_Nacimiento;
    }

    public void setFecha_Nacimiento(Date Fecha_Nacimiento) {
        this.Fecha_Nacimiento = Fecha_Nacimiento;
    }

    public String getFoto_Perfil() {
        return Foto_Perfil;
    }

    public void setFoto_Perfil(String Foto_Perfil) {
        this.Foto_Perfil = Foto_Perfil;
    }

    public boolean isActiva() {
        return Activa;
    }

    public void setActiva(boolean Activa) {
        this.Activa = Activa;
    }

    public Timestamp getFecha_Creacion() {
        return Fecha_Creacion;
    }

    public void setFecha_Creacion(Timestamp Fecha_Creacion) {
        this.Fecha_Creacion = Fecha_Creacion;
    }
    
}


