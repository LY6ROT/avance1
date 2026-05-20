package com.gymmax.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {
    
    // Parámetros de configuración para MySQL 8.x en adelante
    private static final String DATABASE = "gymmax_db";
    private static final String URL = "jdbc:mysql://localhost:3306/" + DATABASE + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASS = "Olivertorre1"; // <-- Reemplaza con tu clave de MySQL Workbench

    public static Connection getConexion() {
        Connection con = null;
        try {
            // Fuerza la carga del controlador JDBC de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("CONEXIÓN EXITOSA: Conectado a la base de datos " + DATABASE);
        } catch (ClassNotFoundException e) {
            System.out.println("ERROR: No se encontró el conector de MySQL. Verifica el archivo JAR en Tomcat/lib.");
        } catch (SQLException e) {
            System.out.println("ERROR: Fallo en las credenciales o el servidor MySQL está apagado.");
        }
        return con;
    }
}