
package gymmax_db.sql;

public class bd {
    
    /*
 
    
-- =======================================================
-- SCRIPT DE CREACIÓN DE LA BASE DE DATOS GYM_MAX 
-- =======================================================

-- 1. Preparar la Base de Datos
DROP DATABASE IF EXISTS gymmax_db;
CREATE DATABASE gymmax_db;
USE gymmax_db;

-- 2. Crear tabla USUARIO
CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    correo VARCHAR(80) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nombres VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    rol ENUM('SOCIO', 'ADMIN') NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Crear tabla SEDE 
CREATE TABLE SEDE (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    distrito VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    hora_apertura TIME,
    hora_cierre TIME,
    capacidad INT,
    imagen_url VARCHAR(255),
    descripcion TEXT,
    beneficios VARCHAR(255) 
);

-- 4. Crear tabla SOCIO
CREATE TABLE SOCIO (
    id_socio INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    dni CHAR(8) UNIQUE NOT NULL,
    celular VARCHAR(15),
    fecha_nac DATE,
    genero CHAR(1),
    direccion VARCHAR(150),
    id_sede_principal INT, 
    fecha_reg DATE,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_sede_principal) REFERENCES SEDE(id_sede)
);

-- 5. Crear tabla PLAN
CREATE TABLE PLAN (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    tipo ENUM('BASIC', 'PREM', 'ANUAL') NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    duracion_dias INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- 6. Crear tabla MEMBRESIA
CREATE TABLE MEMBRESIA (
    id_membresia INT AUTO_INCREMENT PRIMARY KEY,
    id_socio INT NOT NULL,
    id_plan INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado ENUM('ACT', 'VEN', 'SUS') NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    renovacion_auto BOOL DEFAULT FALSE,
    FOREIGN KEY (id_socio) REFERENCES SOCIO(id_socio),
    FOREIGN KEY (id_plan) REFERENCES PLAN(id_plan)
);

-- 7. Crear tabla PAGO 
CREATE TABLE PAGO (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_membresia INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    metodo ENUM('YAPE', 'PLIN', 'TARJ', 'WEB') NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nro_operacion VARCHAR(50),
    estado VARCHAR(20) NOT NULL, -- Modificado de ENUM a VARCHAR(20)
    comprobante_url VARCHAR(200),
    FOREIGN KEY (id_membresia) REFERENCES MEMBRESIA(id_membresia)
);

-- 8. Crear tabla CLASE
CREATE TABLE CLASE (
    id_clase INT AUTO_INCREMENT PRIMARY KEY,
    id_sede INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    instructor VARCHAR(80),
    dia_semana TINYINT,
    hora_inicio TIME,
    cupo_maximo INT,
    FOREIGN KEY (id_sede) REFERENCES SEDE(id_sede)
);

-- 9. Crear tabla RESERVA
CREATE TABLE RESERVA (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_socio INT NOT NULL,
    id_clase INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado ENUM('CONF', 'CAN', 'LE') NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cancelado_en TIMESTAMP NULL,
    FOREIGN KEY (id_socio) REFERENCES SOCIO(id_socio),
    FOREIGN KEY (id_clase) REFERENCES CLASE(id_clase)
);

-- 10. Crear tabla ASISTENCIA
CREATE TABLE ASISTENCIA (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_socio INT NOT NULL,
    id_sede INT NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo ENUM('ING', 'SAL') NOT NULL,
    registrado_por INT,
    FOREIGN KEY (id_socio) REFERENCES SOCIO(id_socio),
    FOREIGN KEY (id_sede) REFERENCES SEDE(id_sede)
);

-- 11. Crear tabla HORARIO_CLASE
CREATE TABLE HORARIO_CLASE (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    id_clase INT NOT NULL,
    fecha_especifica DATE NOT NULL,
    cupo_actual INT DEFAULT 0,
    cupo_disponible INT NOT NULL,
    estado ENUM('DISP', 'LLENO') NOT NULL,
    FOREIGN KEY (id_clase) REFERENCES CLASE(id_clase)
);

-- =======================================================
-- INSERCIÓN DE DATOS DE PRUEBA
-- =======================================================

-- 1. PLANES
INSERT INTO PLAN (nombre, tipo, precio, duracion_dias, activo) VALUES 
('Plan Basic', 'BASIC', 89.90, 30, 1),
('Plan Premium', 'PREM', 149.90, 30, 1),
('Plan Anual VIP', 'ANUAL', 899.90, 365, 1);

-- 2. SEDES (Datos reales proporcionados, adaptados para la DB)
INSERT INTO SEDE (nombre, direccion, distrito, telefono, hora_apertura, hora_cierre, capacidad, imagen_url, descripcion, beneficios) VALUES 
('Smart Fit', 'Av. Principal 123', 'Lima', '01-445566', '06:00:00', '23:00:00', 150, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600', 'Tu vida más saludable comienza aquí. Disfruta de equipos de última generación, aire acondicionado y la mejor comunidad fitness.', 'Peso Libre,Cardio,Duchas,Wifi Gratis'),
('Activa Club', 'Av. Industrial 3660', 'Lima Norte', '01-521489', '06:00:00', '22:00:00', 120, 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?q=80&w=600', 'Somos el club deportivo más completo de Lima Norte. Disfruta de nuestras piscinas temperadas, canchas deportivas y una amplia zona de gimnasio.', 'Piscina,Canchas,Zona Kids,Sauna'),
('Bodytech', 'Av. Pardo 555', 'Miraflores', '01-344211', '05:00:00', '23:00:00', 140, 'https://plus.unsplash.com/premium_photo-1661301057249-bd008eebd06a?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'En Bodytech encontrarás la mejor tecnología en medicina deportiva, zonas húmedas y entrenadores de alto nivel para lograr tus objetivos.', 'Piscina,Sauna,Nutrición,Parking'),
('Gimnasio Zeuz', 'Av. Antúnez de Mayolo 1234', 'Lima Norte', '01-998877', '05:00:00', '23:00:00', 110, 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=600', 'Si buscas resultados reales sin rodeos, Zeuz es para ti. Contamos con la zona de peso libre más completa de Lima Norte y mancuernas de hasta 60kg.', 'Peso Libre Extremo,Suplementos,Asesoría de Piso,Ambiente Motivado'),
('Matrix Fitness', 'Av. Guardia Civil 900', 'Chorrillos', '01-654321', '06:00:00', '23:00:00', 135, 'https://images.unsplash.com/photo-1728486145245-d4cb0c9c3470?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Entrena con vista panorámica y equipos biomecánicos de alta gama. Matrix Fitness es ideal para quienes buscan confort y eficiencia en cada repetición.', 'Máquinas Matrix,Wifi Fibra,Parking Gratis,Duchas Calientes'),
('Energym', 'Av. Aviación 5000', 'Surco', '01-789456', '06:00:00', '22:00:00', 125, 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?q=80&w=600', 'Somos más que máquinas, somos ritmo y movimiento. Energym es famoso por sus clases grupales de baile, step y funcional que te harán sudar sonriendo.', 'Baile Fitness,Full Body,Sala de Pesas,Spinning'),
('X Sport Gym', 'Av. San Juan 1050', 'SJM', '01-112233', '06:00:00', '23:00:00', 150, 'https://images.unsplash.com/photo-1599058917212-d750089bc07e?q=80&w=600', 'El gimnasio más grande de la zona sur. Contamos con 3 pisos dedicados al entrenamiento de fuerza, cardio y boxeo. Aquí se viene a entrenar en serio.', '3 Pisos de Máquinas,Ring de Box,Cafetería Fit,Cardio'),
('Aventura Gym', 'Av. Defensores del Morro', 'Chorrillos', '01-223344', '06:30:00', '22:00:00', 105, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600', 'Un gimnasio con tradición y ambiente familiar en el corazón de Chorrillos. Contamos con instructores dedicados que te guiarán paso a paso.', 'Aeróbicos,Zona de Pesas,Clases Grupales,Vestidores'),
('B2 (Body Balance)', 'Real Plaza Puruchuco', 'Ate', '01-334455', '06:00:00', '22:00:00', 145, 'https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=600', 'En B2 nos enfocamos en el bienestar integral. Combina entrenamiento funcional de alta intensidad con clases de recuperación, Yoga y Pilates para lograr tu mejor versión.', 'Yoga & Pilates,Funcional,Cardio Box,Vestidores'),
('Sportlife Lux', 'Av. Javier Prado 444', 'San Isidro', '01-445566', '06:00:00', '22:30:00', 115, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600', 'Sportlife te ofrece un concepto de entrenamiento exclusivo. Disfruta de máquinas de gama alta, entrenamientos funcionales y un ambiente diseñado para tu máximo confort.', 'Spinning,Cross Training,Tienda Fit,Coworking'),
('MegaForce', 'Av. Próceres 1800', 'SJL', '01-556677', '05:30:00', '23:00:00', 150, 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?q=80&w=600', 'Somos la cadena líder en la zona. Instalaciones amplias, maquinaria Hammer Strength y zonas de cardio cine. En MegaForce entrenas con los mejores equipos al mejor precio.', 'Máquinas Hammer,Sala Cardio Cine,Sauna Seco/Vapor,Baile y Aeróbicos');

-- 3. USUARIOS (1 Admin + 10 Socios)
INSERT INTO USUARIO (correo, password, nombres, apellidos, rol) VALUES 
('admin@gymmax.com', '123456', 'Oliver', 'Torre', 'ADMIN'),
('juan.lopez@email.com', '123456', 'Juan', 'Lopez', 'SOCIO'),
('maria.santos@email.com', '123456', 'Maria', 'Santos', 'SOCIO'),
('pedro.correa@email.com', '123456', 'Pedro', 'Correa', 'SOCIO'),
('ana.silva@email.com', '123456', 'Ana', 'Silva', 'SOCIO'),
('luis.perez@email.com', '123456', 'Luis', 'Perez', 'SOCIO'),
('sofia.mendez@email.com', '123456', 'Sofia', 'Mendez', 'SOCIO'),
('carlos.ruiz@email.com', '123456', 'Carlos', 'Ruiz', 'SOCIO'),
('elena.castro@email.com', '123456', 'Elena', 'Castro', 'SOCIO'),
('diego.vargas@email.com', '123456', 'Diego', 'Vargas', 'SOCIO'),
('lucia.ramirez@email.com', '123456', 'Lucia', 'Ramirez', 'SOCIO');

-- 4. SOCIOS 
INSERT INTO SOCIO (id_usuario, dni, celular, fecha_nac, genero, id_sede_principal, fecha_reg) VALUES
(2, '76543210', '987654321', '1995-08-15', 'M', 1, CURRENT_DATE),
(3, '12345678', '912345678', '1998-03-22', 'F', 2, CURRENT_DATE),
(4, '87654321', '988776655', '1990-11-10', 'M', 3, CURRENT_DATE),
(5, '23456789', '999888777', '2001-05-05', 'F', 4, CURRENT_DATE),
(6, '34567890', '911222333', '1985-12-30', 'M', 5, CURRENT_DATE),
(7, '45678901', '922333444', '1993-07-20', 'F', 6, CURRENT_DATE),
(8, '56789012', '933444555', '1988-02-14', 'M', 7, CURRENT_DATE),
(9, '67890123', '944555666', '1997-09-09', 'F', 8, CURRENT_DATE),
(10, '78901234', '955666777', '1992-04-18', 'M', 9, CURRENT_DATE),
(11, '89012345', '966777888', '2000-01-25', 'F', 10, CURRENT_DATE);

-- 5. MEMBRESÍAS 
INSERT INTO MEMBRESIA (id_socio, id_plan, fecha_inicio, fecha_fin, estado, monto) VALUES
(1, 1, DATE_SUB(CURDATE(), INTERVAL 15 DAY), DATE_ADD(CURDATE(), INTERVAL 15 DAY), 'ACT', 89.90), -- A mitad de mes
(2, 2, DATE_SUB(CURDATE(), INTERVAL 29 DAY), DATE_ADD(CURDATE(), INTERVAL 1 DAY), 'ACT', 149.90), -- Vence MAÑANA (Aparecerá en alertas)
(3, 3, DATE_SUB(CURDATE(), INTERVAL 100 DAY), DATE_ADD(CURDATE(), INTERVAL 265 DAY), 'ACT', 899.90), -- Anual
(4, 1, DATE_SUB(CURDATE(), INTERVAL 27 DAY), DATE_ADD(CURDATE(), INTERVAL 3 DAY), 'ACT', 89.90), -- Vence en 3 DÍAS
(5, 2, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY), 'ACT', 149.90), -- Recién comprada hoy
(6, 1, DATE_SUB(CURDATE(), INTERVAL 40 DAY), DATE_SUB(CURDATE(), INTERVAL 10 DAY), 'VEN', 89.90), -- Vencida hace 10 días
(7, 2, DATE_SUB(CURDATE(), INTERVAL 5 DAY), DATE_ADD(CURDATE(), INTERVAL 25 DAY), 'ACT', 149.90),
(8, 3, DATE_SUB(CURDATE(), INTERVAL 10 DAY), DATE_ADD(CURDATE(), INTERVAL 355 DAY), 'ACT', 899.90),
(9, 1, DATE_SUB(CURDATE(), INTERVAL 30 DAY), CURDATE(), 'ACT', 89.90), -- Vence HOY (Aparecerá en alertas)
(10, 2, DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_ADD(CURDATE(), INTERVAL 10 DAY), 'ACT', 149.90);

-- 6. PAGOS HISTÓRICOS (Para poblar el gráfico de barras del admin)
INSERT INTO PAGO (id_membresia, monto, metodo, fecha_pago, nro_operacion, estado) VALUES
(1, 89.90, 'YAPE', DATE_SUB(CURDATE(), INTERVAL 15 DAY), 'YP-1001', 'OK'), -- Este mes
(2, 149.90, 'TARJ', DATE_SUB(CURDATE(), INTERVAL 29 DAY), 'TJ-2002', 'OK'), -- Este mes
(3, 899.90, 'WEB', DATE_SUB(CURDATE(), INTERVAL 100 DAY), 'WB-3003', 'OK'), -- Hace 3 meses (pico)
(4, 89.90, 'PLIN', DATE_SUB(CURDATE(), INTERVAL 27 DAY), 'PL-4004', 'OK'), -- Este mes
(5, 149.90, 'TARJ', CURDATE(), 'TJ-5005', 'OK'), -- Hoy (Impacta Ingresos del Mes)
(6, 89.90, 'YAPE', DATE_SUB(CURDATE(), INTERVAL 40 DAY), 'YP-6006', 'OK'), -- Mes pasado
(7, 149.90, 'TARJ', DATE_SUB(CURDATE(), INTERVAL 5 DAY), 'TJ-7007', 'OK'), -- Este mes
(8, 899.90, 'YAPE', DATE_SUB(CURDATE(), INTERVAL 10 DAY), 'YP-8008', 'OK'), -- Este mes (gran ingreso)
(9, 89.90, 'PLIN', DATE_SUB(CURDATE(), INTERVAL 30 DAY), 'PL-9009', 'OK'), -- Este mes
(10, 149.90, 'TARJ', DATE_SUB(CURDATE(), INTERVAL 20 DAY), 'TJ-1010', 'OK'), -- Este mes
-- Pagos extra ficticios para dar volumen a meses anteriores
(1, 89.90, 'TARJ', DATE_SUB(CURDATE(), INTERVAL 45 DAY), 'TJ-01', 'OK'),
(2, 149.90, 'YAPE', DATE_SUB(CURDATE(), INTERVAL 59 DAY), 'YP-02', 'OK'),
(4, 89.90, 'PLIN', DATE_SUB(CURDATE(), INTERVAL 57 DAY), 'PL-03', 'OK'),
(5, 149.90, 'WEB', DATE_SUB(CURDATE(), INTERVAL 80 DAY), 'WB-04', 'OK'),
(7, 149.90, 'TARJ', DATE_SUB(CURDATE(), INTERVAL 35 DAY), 'TJ-05', 'OK'),
(9, 89.90, 'YAPE', DATE_SUB(CURDATE(), INTERVAL 60 DAY), 'YP-06', 'OK'),
(10, 149.90, 'PLIN', DATE_SUB(CURDATE(), INTERVAL 50 DAY), 'PL-07', 'OK'),
(1, 89.90, 'TARJ', DATE_SUB(CURDATE(), INTERVAL 75 DAY), 'TJ-08', 'OK'),
(2, 149.90, 'YAPE', DATE_SUB(CURDATE(), INTERVAL 89 DAY), 'YP-09', 'OK'),
(7, 149.90, 'WEB', DATE_SUB(CURDATE(), INTERVAL 65 DAY), 'WB-10', 'OK');

-- 7. CLASES
INSERT INTO CLASE (id_sede, nombre, tipo, instructor, dia_semana, hora_inicio, cupo_maximo) VALUES 
(1, 'CrossFit Intensivo', 'CROSS', 'Carlos M.', 1, '18:00:00', 15),
(2, 'Spinning', 'SPINNING', 'Luis P.', 1, '20:00:00', 15),
(1, 'Yoga Relax', 'YOGA', 'Ana S.', 2, '08:00:00', 20),
(3, 'Zumba Fitness', 'ZUMBA', 'Maria F.', 3, '19:00:00', 25),
(4, 'Levantamiento de Pesas', 'FUERZA', 'Jorge H.', 4, '17:00:00', 12),
(5, 'Funcional Matrix', 'FUNCIONAL', 'Elena V.', 5, '19:30:00', 20);

-- 8. RESERVAS 
INSERT INTO RESERVA (id_socio, id_clase, fecha, hora, estado) VALUES 
(1, 1, CURDATE(), '18:00:00', 'CONF'),
(2, 2, CURDATE(), '20:00:00', 'CONF'),
(3, 4, CURDATE(), '19:00:00', 'CONF'),
(4, 5, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '17:00:00', 'CONF'),
(5, 6, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '19:30:00', 'CONF');
    
    
    
 */
}
