package com.voter.portal;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.Random;

@WebServlet("/sendOTP")
public class SendOTPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Replace with your Gmail credentials
    private static final String SENDER_EMAIL = "atharvvats15@gmail.com";
    private static final String APP_PASSWORD = "ofzi lsjg hymw kkdb";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE email = ? AND password = ? AND user_type = 'user'";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // ✅ Valid user found, generate OTP
                String otp = String.valueOf(100000 + new Random().nextInt(900000));

                // ✅ Store OTP in session
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("otpEmail", email);
                session.setAttribute("otpPassword", password); // store it for later use

                // ✅ Send OTP to email
                sendEmail(email, otp);

                response.getWriter().write("OTP_SENT");

            } else {
                // ❌ Invalid credentials or not a user-type account
                response.getWriter().write("Invalid credentials or error sending OTP");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Server error");
        }
    }


    private void sendEmail(String recipientEmail, String otp) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        System.out.println("Preparing to send OTP to: " + recipientEmail);
        // Authenticate session
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(SENDER_EMAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("Your OTP for Voter Portal Login");
        message.setText("Your OTP is: " + otp + "\n\nValid for 5 minutes only.");

        Transport.send(message);
    }
}
