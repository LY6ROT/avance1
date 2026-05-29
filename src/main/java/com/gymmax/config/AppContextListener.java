package com.gymmax.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.util.Enumeration;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Se ejecuta al iniciar la aplicación (no necesitamos hacer nada aquí)
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Se ejecuta exactamente cuando apagas o redespliegas en Tomcat
        
        // 1. Desregistrar los drivers de la base de datos
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
            } catch (Exception e) {
                System.out.println("Error al desregistrar driver: " + e.getMessage());
            }
        }
        
        // 2. Apagar el hilo rebelde de MySQL
        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
        } catch (Exception e) {
            System.out.println("Error al apagar el hilo de MySQL: " + e.getMessage());
        }
    }
}