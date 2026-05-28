package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.SocioDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

// =========================================================
    // LISTAR TODOS LOS SOCIOS PARA LA TABLA DE GESTIÓN (SIN DNI)
    // =========================================================
    public java.util.List<SocioDTO> listarTodosLosSocios() {
        java.util.List<SocioDTO> lista = new java.util.ArrayList<>();
        
        // Agregamos una subconsulta para contar si tiene membresías activas reales
        String sql = "SELECT s.id_socio, u.id_usuario, u.nombres, u.apellidos, u.correo, " +
                     "(SELECT COUNT(*) FROM MEMBRESIA m WHERE m.id_socio = s.id_socio AND m.estado = 'ACT') AS membresias_activas " +
                     "FROM SOCIO s INNER JOIN USUARIO u ON s.id_usuario = u.id_usuario";
                     
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                SocioDTO socio = new SocioDTO();
                socio.setIdSocio(rs.getInt("id_socio"));
                socio.setIdUsuario(rs.getInt("id_usuario"));
                socio.setNombres(rs.getString("nombres"));
                socio.setApellidos(rs.getString("apellidos"));
                
                // Unimos nombre y apellido para la vista
                socio.setNombreCompleto(rs.getString("nombres") + " " + rs.getString("apellidos"));
                socio.setCorreo(rs.getString("correo"));
                socio.setDni("No registrado");
                
                // LÓGICA DE ESTADO (VERDE/ROJO): 
                // Si tiene membresías activas, enviamos texto (Activo). Si es 0, enviamos vacío (Inactivo).
                if (rs.getInt("membresias_activas") > 0) {
                    socio.setFechaRegistro("Activo"); 
                } else {
                    socio.setFechaRegistro(""); 
                }
                
                lista.add(socio);
            }
        } catch (Exception e) {
            System.out.println("Error al listar socios: " + e.getMessage());
        }
        return lista;
    }
    // =========================================================
    // MÉTODO PARA LLENAR LAS 4 TARJETAS DEL DASHBOARD DEL ADMIN
    // =========================================================

    public java.util.Map<String, String> obtenerEstadisticasDashboard() {
        java.util.Map<String, String> stats = new java.util.HashMap<>();
        stats.put("sociosActivos", "0");
        stats.put("ingresosMes", "0.00");
        stats.put("membresiasVencer", "0");
        stats.put("reservasHoy", "0");

        // 1. Socios totales
        String sqlSocios = "SELECT COUNT(*) AS total FROM SOCIO";

        // 2. Ingresos del mes (Ahora busca el estado oficial 'OK')
        String sqlIngresos = "SELECT COALESCE(SUM(monto), 0) AS total FROM PAGO WHERE MONTH(fecha_pago) = MONTH(CURDATE()) AND YEAR(fecha_pago) = YEAR(CURDATE()) AND estado = 'OK'";

        // 3. Membresías por vencer (en los próximos 7 días)
        String sqlVencer = "SELECT COUNT(*) AS total FROM MEMBRESIA WHERE estado = 'ACT' AND fecha_fin BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)";

        // 4. Reservas de hoy
        String sqlReservas = "SELECT COUNT(*) AS total FROM RESERVA WHERE fecha = CURDATE() AND estado = 'CONF'";

        try (Connection con = ConexionDB.getConexion()) {
            try (PreparedStatement ps = con.prepareStatement(sqlSocios); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("sociosActivos", String.valueOf(rs.getInt("total")));
                }
            }
            try (PreparedStatement ps = con.prepareStatement(sqlIngresos); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("ingresosMes", String.format("%.2f", rs.getDouble("total")));
                }
            }
            try (PreparedStatement ps = con.prepareStatement(sqlVencer); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("membresiasVencer", String.valueOf(rs.getInt("total")));
                }
            }
            try (PreparedStatement ps = con.prepareStatement(sqlReservas); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("reservasHoy", String.valueOf(rs.getInt("total")));
                }
            }
        } catch (Exception e) {
            System.out.println("Error obteniendo métricas Admin: " + e.getMessage());
        }
        return stats;
    }
    // =========================================================
    // ELIMINAR SOCIO (Con protección de llaves foráneas)
    // =========================================================
    public boolean eliminarSocio(int idSocio) {
        boolean exito = false;
        String sql = "DELETE FROM SOCIO WHERE id_socio = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idSocio);
            if (ps.executeUpdate() > 0) {
                exito = true;
            }
            
        } catch (Exception e) {
            // Si el socio tiene reservas o pagos, MySQL lanzará una excepción y no lo borrará (lo cual es bueno para auditoría)
            System.out.println("Error al eliminar socio (Posible conflicto de llaves): " + e.getMessage());
        }
        return exito;
    }
   // =========================================================
    // ACTUALIZAR DATOS DE SOCIO (SIN DNI)
    // =========================================================
    public boolean actualizarSocio(int idUsuario, String nombres, String apellidos, String dni, String correo) {
        boolean exito = false;
        // Quitamos la actualización del DNI en el SQL
        String sql = "UPDATE USUARIO SET nombres = ?, apellidos = ?, correo = ? WHERE id_usuario = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, nombres);
            ps.setString(2, apellidos);
            ps.setString(3, correo);
            ps.setInt(4, idUsuario); // El ID ahora es el parámetro 4
            
            if (ps.executeUpdate() > 0) {
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("Error al actualizar datos del socio: " + e.getMessage());
        }
        return exito;
    }
    // =========================================================
    // BUSCAR SOCIOS POR NOMBRE, APELLIDO O CORREO
    // =========================================================
    public List<SocioDTO> buscarSocios(String texto) {
        List<SocioDTO> lista = new ArrayList<>();

        // Misma subconsulta para mantener el estado real en la búsqueda
        String sql = "SELECT s.id_socio, u.id_usuario, u.nombres, u.apellidos, u.correo, " +
                     "(SELECT COUNT(*) FROM MEMBRESIA m WHERE m.id_socio = s.id_socio AND m.estado = 'ACT') AS membresias_activas " +
                     "FROM SOCIO s " +
                     "INNER JOIN USUARIO u ON s.id_usuario = u.id_usuario " +
                     "WHERE u.nombres LIKE ? " +
                     "OR u.apellidos LIKE ? " +
                     "OR u.correo LIKE ?";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String filtro = "%" + texto + "%";
            ps.setString(1, filtro);
            ps.setString(2, filtro);
            ps.setString(3, filtro);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SocioDTO socio = new SocioDTO();
                socio.setIdSocio(rs.getInt("id_socio"));
                socio.setIdUsuario(rs.getInt("id_usuario"));
                socio.setNombres(rs.getString("nombres"));
                socio.setApellidos(rs.getString("apellidos"));
                socio.setNombreCompleto(rs.getString("nombres") + " " + rs.getString("apellidos"));
                socio.setCorreo(rs.getString("correo"));
                socio.setDni("No registrado");

                // LÓGICA DE ESTADO
                if (rs.getInt("membresias_activas") > 0) {
                    socio.setFechaRegistro("Activo");
                } else {
                    socio.setFechaRegistro("");
                }

                lista.add(socio);
            }
        } catch (Exception e) {
            System.out.println("Error al buscar socios: " + e.getMessage());
        }
        return lista;
    }

    // =========================================================
    // REGISTRAR NUEVO SOCIO
    // =========================================================
    public boolean registrarSocio(String nombres,
                                  String apellidos,
                                  String correo,
                                  String dni,
                                  String password) {

        boolean exito = false;

        // Se agrega el rol por defecto 'SOCIO'
        String sqlUsuario = "INSERT INTO USUARIO " +
                            "(nombres, apellidos, correo, password, rol) " +
                            "VALUES (?, ?, ?, ?, 'SOCIO')";

        // Se agrega la inserción del DNI para evitar el error de Default Value
        String sqlSocio = "INSERT INTO SOCIO (id_usuario, dni, fecha_reg) VALUES (?, ?, CURDATE())";

        try (Connection con = ConexionDB.getConexion()) {
            con.setAutoCommit(false);

            // 1. Insertar en USUARIO
            try (PreparedStatement psUsuario = con.prepareStatement(sqlUsuario, PreparedStatement.RETURN_GENERATED_KEYS)) {
                psUsuario.setString(1, nombres);
                psUsuario.setString(2, apellidos);
                psUsuario.setString(3, correo);
                psUsuario.setString(4, password);

                if (psUsuario.executeUpdate() > 0) {
                    try (ResultSet rs = psUsuario.getGeneratedKeys()) {
                        if (rs.next()) {
                            int idUsuario = rs.getInt(1);

                            // 2. Insertar en SOCIO con el DNI
                            try (PreparedStatement psSocio = con.prepareStatement(sqlSocio)) {
                                psSocio.setInt(1, idUsuario);
                                psSocio.setString(2, dni);
                                
                                psSocio.executeUpdate();
                                con.commit();
                                exito = true;
                            }
                        }
                    }
                }
            } catch (Exception e) {
                con.rollback(); // Deshacer si falla el Socio
                System.out.println("Error al insertar en cascada: " + e.getMessage());
            }

        } catch (Exception e) {
            System.out.println("Error al registrar socio: " + e.getMessage());
        }

        return exito;
    }
    
}
