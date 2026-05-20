package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {
    
// Método para registrar un nuevo socio en BD
    public boolean registrarSocio(Usuario usuario, String dni, String celular) {
        boolean exito = false;
        // Consultas SQL preparadas
        String sqlUsuario = "INSERT INTO USUARIO (correo, password, nombres, apellidos, rol) VALUES (?, ?, ?, ?, 'SOCIO')";
        String sqlSocio = "INSERT INTO SOCIO (id_usuario, dni, celular, fecha_reg) VALUES (?, ?, ?, CURDATE())";
        
        Connection con = null;
        PreparedStatement psUsuario = null;
        PreparedStatement psSocio = null;
        ResultSet rs = null;
        
        try {
            con = ConexionDB.getConexion();
            // Desactivamos el autocommit para manejar la transacción manualmente
            con.setAutoCommit(false); 
            
            // 1. Insertamos primero en la tabla USUARIO
            // Usamos RETURN_GENERATED_KEYS para obtener el ID que MySQL genere automáticamente
            psUsuario = con.prepareStatement(sqlUsuario, PreparedStatement.RETURN_GENERATED_KEYS);
            psUsuario.setString(1, usuario.getCorreo());
            psUsuario.setString(2, usuario.getPassword()); 
            psUsuario.setString(3, usuario.getNombres());
            psUsuario.setString(4, usuario.getApellidos());
            
            int filasAfectadas = psUsuario.executeUpdate();
            
            if (filasAfectadas > 0) {
                // Obtenemos el ID del nuevo usuario
                rs = psUsuario.getGeneratedKeys();
                if (rs.next()) {
                    int idUsuarioGenerado = rs.getInt(1);
                    
                    // 2. Insertamos en la tabla SOCIO usando el ID que acabamos de obtener
                    psSocio = con.prepareStatement(sqlSocio);
                    psSocio.setInt(1, idUsuarioGenerado);
                    psSocio.setString(2, dni);
                    psSocio.setString(3, celular);
                    
                    int filasSocio = psSocio.executeUpdate();
                    
                    if (filasSocio > 0) {
                        con.commit(); // Si todo salió bien, guardamos definitivamente (Commit)
                        exito = true;
                    } else {
                        con.rollback(); // Si falló el socio, deshacemos el usuario creado (Rollback)
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al registrar socio: " + e.getMessage());
            try {
                if (con != null) con.rollback(); // En caso de error general, deshacemos todo
            } catch (SQLException ex) {
                System.out.println("Error en rollback: " + ex.getMessage());
            }
        } finally {
            // Buenas prácticas: cerramos todas las conexiones
            try {
                if (rs != null) rs.close();
                if (psUsuario != null) psUsuario.close();
                if (psSocio != null) psSocio.close();
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (SQLException e) {
                System.out.println("Error cerrando recursos: " + e.getMessage());
            }
        }
        return exito;
    }

   public Usuario validarLogin(String correo, String password) {
        Usuario usuario = null;
        String sql = "SELECT id_usuario, correo, nombres, apellidos, rol FROM USUARIO WHERE correo = ? AND password = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, correo);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    usuario.setCorreo(rs.getString("correo"));
                    usuario.setNombres(rs.getString("nombres"));
                    usuario.setApellidos(rs.getString("apellidos"));
                    usuario.setRol(rs.getString("rol"));
                }
            }
        } catch (Exception e) {
            System.out.println("Error en validarLogin: " + e.getMessage());
        }
        
        return usuario;
    }
}