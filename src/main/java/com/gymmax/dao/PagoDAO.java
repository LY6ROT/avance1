package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PagoDAO {
    
    // Método para registrar membresía y pago al mismo tiempo
    public boolean procesarCompra(int idUsuario, int idPlan, double monto, int duracionDias) {
        boolean exito = false;
        Connection con = null;
        PreparedStatement psSocio = null, psMembresia = null, psPago = null;
        ResultSet rsSocio = null, rsMembresia = null;

        try {
            con = ConexionDB.getConexion();
            con.setAutoCommit(false); // Iniciar transacción manual

            // 1. Obtener el id_socio a partir del id_usuario de la sesión
            String sqlSocio = "SELECT id_socio FROM SOCIO WHERE id_usuario = ?";
            psSocio = con.prepareStatement(sqlSocio);
            psSocio.setInt(1, idUsuario);
            rsSocio = psSocio.executeQuery();
            
            int idSocio = 0;
            if (rsSocio.next()) {
                idSocio = rsSocio.getInt("id_socio");
            } else {
                throw new SQLException("El usuario no tiene un perfil de socio.");
            }

            // 2. Insertar en tabla MEMBRESIA (Inicia hoy, termina según los días del plan)
            String sqlMembresia = "INSERT INTO MEMBRESIA (id_socio, id_plan, fecha_inicio, fecha_fin, estado, monto, renovacion_auto) " +
                                  "VALUES (?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL ? DAY), 'ACT', ?, 0)";
            psMembresia = con.prepareStatement(sqlMembresia, PreparedStatement.RETURN_GENERATED_KEYS);
            psMembresia.setInt(1, idSocio);
            psMembresia.setInt(2, idPlan);
            psMembresia.setInt(3, duracionDias);
            psMembresia.setDouble(4, monto);
            
            if (psMembresia.executeUpdate() > 0) {
                rsMembresia = psMembresia.getGeneratedKeys();
                if (rsMembresia.next()) {
                    int idMembresiaGenerado = rsMembresia.getInt(1);

                    // 3. Insertar en tabla PAGO (Registramos el ticket)
                    String sqlPago = "INSERT INTO PAGO (id_membresia, monto, metodo, estado) VALUES (?, ?, 'TARJ', 'OK')";
                    psPago = con.prepareStatement(sqlPago);
                    psPago.setInt(1, idMembresiaGenerado);
                    psPago.setDouble(2, monto);
                    
                    if (psPago.executeUpdate() > 0) {
                        con.commit(); // Éxito total, guardamos en BD
                        exito = true;
                    } else {
                        con.rollback(); // Falló el pago
                    }
                }
            } else {
                con.rollback(); // Falló la membresía
            }

        } catch (SQLException e) {
            System.out.println("Error procesando pago: " + e.getMessage());
            try { if (con != null) con.rollback(); } catch (SQLException ex) {}
        } finally {
            try {
                if (rsSocio != null) rsSocio.close();
                if (rsMembresia != null) rsMembresia.close();
                if (psSocio != null) psSocio.close();
                if (psMembresia != null) psMembresia.close();
                if (psPago != null) psPago.close();
                if (con != null) { con.setAutoCommit(true); con.close(); }
            } catch (SQLException e) {}
        }
        return exito;
    }
}
