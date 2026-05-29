package com.gymmax.utils;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailService {
    
    // IMPORTANTE: Pon un correo de Gmail real y genera una "Contraseña de Aplicación" de 16 letras
    // No uses tu contraseña normal de Gmail. (Busca en Google: "Generar contraseña de aplicación Gmail")
    private static final String CORREO_ORIGEN = "tu_correo@gmail.com"; 
    private static final String CONTRASENA_APP = "tu_password_de_aplicacion";

    public static boolean enviarCorreo(String destinatario, String asunto, String mensajeCuerpo) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(CORREO_ORIGEN, CONTRASENA_APP);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(CORREO_ORIGEN, "GymMax Admin"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            message.setSubject(asunto);
            message.setContent(mensajeCuerpo, "text/html; charset=utf-8");

            Transport.send(message);
            return true;
        } catch (Exception e) {
            System.out.println("Error enviando correo: " + e.getMessage());
            return false;
        }
    }
}