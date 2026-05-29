package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.PagoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PagoDAO {

    // =========================================================
    // LISTAR TODOS LOS PAGOS
    // =========================================================
    public List<PagoDTO> listarPagos() {
        List<PagoDTO> lista = new ArrayList<>();
        String sql = "SELECT p.id_pago, CONCAT(u.nombres, ' ', u.apellidos) AS socio, pl.nombre AS plan, " +
                     "p.monto, p.metodo, p.nro_operacion, DATE_FORMAT(p.fecha_pago, '%d/%m/%Y %H:%i') AS fecha, p.estado " +
                     "FROM PAGO p " +
                     "INNER JOIN MEMBRESIA m ON p.id_membresia = m.id_membresia " +
                     "INNER JOIN SOCIO s ON m.id_socio = s.id_socio " +
                     "INNER JOIN USUARIO u ON s.id_usuario = u.id_usuario " +
                     "INNER JOIN PLAN pl ON m.id_plan = pl.id_plan " +
                     "ORDER BY p.fecha_pago DESC";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearPago(rs));
            }
        } catch (Exception e) {
            System.out.println("Error al listar pagos: " + e.getMessage());
        }
        return lista;
    }

    // =========================================================
    // BUSCAR PAGOS (Por nombre de socio o número de operación)
    // =========================================================
    public List<PagoDTO> buscarPagos(String texto) {
        List<PagoDTO> lista = new ArrayList<>();
        String sql = "SELECT p.id_pago, CONCAT(u.nombres, ' ', u.apellidos) AS socio, pl.nombre AS plan, " +
                     "p.monto, p.metodo, p.nro_operacion, DATE_FORMAT(p.fecha_pago, '%d/%m/%Y %H:%i') AS fecha, p.estado " +
                     "FROM PAGO p " +
                     "INNER JOIN MEMBRESIA m ON p.id_membresia = m.id_membresia " +
                     "INNER JOIN SOCIO s ON m.id_socio = s.id_socio " +
                     "INNER JOIN USUARIO u ON s.id_usuario = u.id_usuario " +
                     "INNER JOIN PLAN pl ON m.id_plan = pl.id_plan " +
                     "WHERE CONCAT(u.nombres, ' ', u.apellidos) LIKE ? OR p.nro_operacion LIKE ? " +
                     "ORDER BY p.fecha_pago DESC";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            String parametro = "%" + texto + "%";
            ps.setString(1, parametro);
            ps.setString(2, parametro);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearPago(rs));
                }
            }
        } catch (Exception e) {
            System.out.println("Error al buscar pagos: " + e.getMessage());
        }
        return lista;
    }

    // =========================================================
    // ANULAR PAGO
    // =========================================================
    public boolean anularPago(int idPago) {
        boolean exito = false;
        String sql = "UPDATE PAGO SET estado = 'ANUL' WHERE id_pago = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idPago);
            if (ps.executeUpdate() > 0) {
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("Error al anular pago: " + e.getMessage());
        }
        return exito;
    }

    // Helper interno
    private PagoDTO mapearPago(ResultSet rs) throws Exception {
        PagoDTO p = new PagoDTO();
        p.setIdPago(rs.getInt("id_pago"));
        p.setNombreSocio(rs.getString("socio"));
        p.setNombrePlan(rs.getString("plan"));
        p.setMonto(rs.getDouble("monto"));
        p.setMetodo(rs.getString("metodo"));
        p.setNroOperacion(rs.getString("nro_operacion") != null ? rs.getString("nro_operacion") : "N/A");
        p.setFechaPago(rs.getString("fecha"));
        p.setEstado(rs.getString("estado"));
        return p;
    }
   // =========================================================
    // PROCESAR COMPRA (CORREGIDO: BUSCA EL ID_SOCIO REAL)
    // =========================================================
    public boolean procesarCompra(int idUsuario, int idPlan, double monto, int duracionDias, String metodoPago) {
        boolean exito = false;
        
        // 1. Consulta para encontrar el id_socio basado en el usuario logueado
        String sqlBuscarSocio = "SELECT id_socio FROM SOCIO WHERE id_usuario = ?";
        
        String sqlMembresia = "INSERT INTO MEMBRESIA (id_socio, id_plan, fecha_inicio, fecha_fin, estado, monto) " +
                              "VALUES (?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL ? DAY), 'ACT', ?)";
        
        String sqlPago = "INSERT INTO PAGO (id_membresia, monto, metodo, nro_operacion, estado) " +
                         "VALUES (?, ?, ?, 'ONLINE', 'OK')";

        try (Connection con = ConexionDB.getConexion()) {
            con.setAutoCommit(false);
            
            int idSocio = 0;
            
            // Paso A: Obtener el ID de Socio real
            try (PreparedStatement psBuscar = con.prepareStatement(sqlBuscarSocio)) {
                psBuscar.setInt(1, idUsuario);
                try (ResultSet rsSocio = psBuscar.executeQuery()) {
                    if (rsSocio.next()) {
                        idSocio = rsSocio.getInt("id_socio");
                    }
                }
            }

            // Paso B: Si existe el socio, procedemos con la compra
            if (idSocio > 0) {
                try (PreparedStatement psMem = con.prepareStatement(sqlMembresia, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    psMem.setInt(1, idSocio); // Pasamos el id_socio correcto
                    psMem.setInt(2, idPlan);
                    psMem.setInt(3, duracionDias);
                    psMem.setDouble(4, monto);
                    
                    if (psMem.executeUpdate() > 0) {
                        try (ResultSet rs = psMem.getGeneratedKeys()) {
                            if (rs.next()) {
                                int idMembresia = rs.getInt(1);
                                
                                try (PreparedStatement psPago = con.prepareStatement(sqlPago)) {
                                    psPago.setInt(1, idMembresia);
                                    psPago.setDouble(2, monto);
                                    psPago.setString(3, metodoPago); // YAPE, PLIN o TARJETA
                                    psPago.executeUpdate();
                                }
                            }
                        }
                    }
                    con.commit(); // Todo salió bien, guardamos
                    exito = true;
                    
                } catch (Exception e) {
                    con.rollback(); // Falló algo, revertimos todo
                    System.err.println("Error en transacción SQL: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                System.err.println("ERROR: No se encontró un id_socio para el id_usuario: " + idUsuario);
            }
            
        } catch (Exception e) {
            System.err.println("Error de conexión al procesar compra: " + e.getMessage());
            e.printStackTrace();
        }
        
        return exito;
    }
    // =========================================================
    // HISTORIAL DE PAGOS DE UN SOCIO ESPECÍFICO (CLIENTE)
    // =========================================================
    public List<PagoDTO> listarPagosPorUsuario(int idUsuario) {
        List<PagoDTO> lista = new ArrayList<>();
        String sql = "SELECT p.id_pago, CONCAT(u.nombres, ' ', u.apellidos) AS socio, pl.nombre AS plan, " +
                     "p.monto, p.metodo, p.nro_operacion, DATE_FORMAT(p.fecha_pago, '%d/%m/%Y %H:%i') AS fecha, p.estado " +
                     "FROM PAGO p " +
                     "INNER JOIN MEMBRESIA m ON p.id_membresia = m.id_membresia " +
                     "INNER JOIN SOCIO s ON m.id_socio = s.id_socio " +
                     "INNER JOIN USUARIO u ON s.id_usuario = u.id_usuario " +
                     "INNER JOIN PLAN pl ON m.id_plan = pl.id_plan " +
                     "WHERE u.id_usuario = ? " +
                     "ORDER BY p.fecha_pago DESC";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearPago(rs)); // Reutilizamos el helper que ya tenías
                }
            }
        } catch (Exception e) {
            System.out.println("Error al listar pagos de usuario: " + e.getMessage());
        }
        return lista;
    }
}