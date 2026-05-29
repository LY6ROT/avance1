package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date; // Necesario para la fecha de nacimiento

public class UsuarioDAO {
    
    // ==========================================
    // VALIDAR LOGIN
    // ==========================================
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

    // ==========================================
    // REGISTRAR SOCIO (En tablas USUARIO y SOCIO)
    // ==========================================
    // Modificamos los parámetros para recibir fechaNac, genero y direccion
    public boolean registrarSocio(Usuario usuario, String dni, String celular, String fechaNac, String genero, String direccion) {
        boolean exito = false;
        String sqlUsuario = "INSERT INTO USUARIO (correo, password, nombres, apellidos, rol) VALUES (?, ?, ?, ?, 'SOCIO')";
        // Actualizamos el SQL para insertar los campos faltantes
        String sqlSocio = "INSERT INTO SOCIO (id_usuario, dni, celular, fecha_nac, genero, direccion, fecha_reg) VALUES (?, ?, ?, ?, ?, ?, CURDATE())";
        
        Connection con = null;
        PreparedStatement psUsuario = null;
        PreparedStatement psSocio = null;
        ResultSet rs = null;
        
        try {
            con = ConexionDB.getConexion();
            con.setAutoCommit(false); 
            
            psUsuario = con.prepareStatement(sqlUsuario, PreparedStatement.RETURN_GENERATED_KEYS);
            psUsuario.setString(1, usuario.getCorreo());
            psUsuario.setString(2, usuario.getPassword()); 
            psUsuario.setString(3, usuario.getNombres());
            psUsuario.setString(4, usuario.getApellidos());
            
            if (psUsuario.executeUpdate() > 0) {
                rs = psUsuario.getGeneratedKeys();
                if (rs.next()) {
                    int idUsuarioGenerado = rs.getInt(1);
                    
                    psSocio = con.prepareStatement(sqlSocio);
                    psSocio.setInt(1, idUsuarioGenerado);
                    psSocio.setString(2, dni);
                    psSocio.setString(3, celular);
                    
                    // Convertimos el String del JSP (YYYY-MM-DD) a un java.sql.Date
                    if (fechaNac != null && !fechaNac.isEmpty()) {
                        psSocio.setDate(4, Date.valueOf(fechaNac));
                    } else {
                        psSocio.setNull(4, java.sql.Types.DATE);
                    }
                    
                    psSocio.setString(5, genero);
                    psSocio.setString(6, direccion);
                    
                    if (psSocio.executeUpdate() > 0) {
                        con.commit(); 
                        exito = true;
                    } else {
                        con.rollback(); 
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al registrar socio: " + e.getMessage());
            try { 
                if (con != null) con.rollback(); 
            } catch (SQLException ex) {
                System.out.println("Error en rollback: " + ex.getMessage());
            }
        } finally {
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
    
    // ==========================================
    // LISTAR SOCIOS PARA EL PANEL ADMINISTRATIVO
    // ==========================================
    public java.util.List<com.gymmax.model.SocioDTO> listarSocios() {
        java.util.List<com.gymmax.model.SocioDTO> lista = new java.util.ArrayList<>();
        String sql = "SELECT s.id_socio, CONCAT(u.nombres, ' ', u.apellidos) AS nombre_completo, s.dni, u.correo, s.fecha_reg " +
                     "FROM SOCIO s " +
                     "INNER JOIN USUARIO u ON s.id_usuario = u.id_usuario WHERE u.rol = 'SOCIO'";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                com.gymmax.model.SocioDTO socio = new com.gymmax.model.SocioDTO();
                socio.setIdSocio(rs.getInt("id_socio"));
                socio.setNombreCompleto(rs.getString("nombre_completo"));
                socio.setDni(rs.getString("dni"));
                socio.setCorreo(rs.getString("correo"));
                socio.setFechaRegistro(rs.getString("fecha_reg"));
                lista.add(socio);
            }
        } catch (SQLException e) {
            System.out.println("Error en listarSocios: " + e.getMessage());
        }
        return lista;
    }
    // ==========================================
    // OBTENER DETALLES DE LA MEMBRESÍA ACTIVA
    // ==========================================
    public java.util.Map<String, String> obtenerMembresiaActiva(int idUsuario) {
        java.util.Map<String, String> datos = null;
        String sql = "SELECT p.nombre AS plan_nombre, m.fecha_inicio, m.fecha_fin, m.estado, se.nombre AS sede_nombre " +
                     "FROM MEMBRESIA m " +
                     "INNER JOIN PLAN p ON m.id_plan = p.id_plan " +
                     "INNER JOIN SOCIO s ON m.id_socio = s.id_socio " +
                     "LEFT JOIN SEDE se ON s.id_sede_principal = se.id_sede " +
                     "WHERE s.id_usuario = ? AND m.estado = 'ACT' " +
                     "ORDER BY m.id_membresia DESC LIMIT 1";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    datos = new java.util.HashMap<>();
                    datos.put("plan", rs.getString("plan_nombre"));
                    datos.put("inicio", rs.getString("fecha_inicio"));
                    datos.put("fin", rs.getString("fecha_fin"));
                    datos.put("estado", rs.getString("estado"));
                    datos.put("sede", rs.getString("sede_nombre") != null ? rs.getString("sede_nombre") : "Ninguna seleccionada");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error en obtenerMembresiaActiva: " + e.getMessage());
        }
        return datos;
    }
    // =========================================================
    // VERIFICAR SI EL CORREO EXISTE
    // =========================================================
    public boolean existeCorreo(String correo) {
        boolean existe = false;
        String sql = "SELECT id_usuario FROM USUARIO WHERE correo = ?";
        try (java.sql.Connection con = com.gymmax.config.ConexionDB.getConexion();
             java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, correo);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    existe = true;
                }
            }
        } catch (Exception e) {
            System.out.println("Error al verificar correo: " + e.getMessage());
        }
        return existe;
    }

    // =========================================================
    // ACTUALIZAR CONTRASEÑA POR CORREO
    // =========================================================
    public boolean actualizarPasswordPorCorreo(String correo, String nuevaPassword) {
        boolean exito = false;
        // Asumiendo que tu columna se llama 'password' o 'clave'. Ajusta si se llama distinto.
        String sql = "UPDATE USUARIO SET password = ? WHERE correo = ?";
        try (java.sql.Connection con = com.gymmax.config.ConexionDB.getConexion();
             java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuevaPassword);
            ps.setString(2, correo);
            if (ps.executeUpdate() > 0) {
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("Error al actualizar contraseña: " + e.getMessage());
        }
        return exito;
    }
}