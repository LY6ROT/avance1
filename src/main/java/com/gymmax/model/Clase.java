package com.gymmax.model;

import java.sql.Time;

public class Clase {
    private int idClase;
    private int idSede;
    private String nombre;
    private String tipo;
    private String instructor;
    private Time horaInicio;
    private int cupoMaximo;

    public Clase() {}

    // Getters y Setters
    public int getIdClase() { return idClase; }
    public void setIdClase(int idClase) { this.idClase = idClase; }
    public int getIdSede() { return idSede; }
    public void setIdSede(int idSede) { this.idSede = idSede; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public String getInstructor() { return instructor; }
    public void setInstructor(String instructor) { this.instructor = instructor; }
    public Time getHoraInicio() { return horaInicio; }
    public void setHoraInicio(Time horaInicio) { this.horaInicio = horaInicio; }
    public int getCupoMaximo() { return cupoMaximo; }
    public void setCupoMaximo(int cupoMaximo) { this.cupoMaximo = cupoMaximo; }
}