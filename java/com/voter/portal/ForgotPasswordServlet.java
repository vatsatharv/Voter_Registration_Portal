package com.voter.portal;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;
import java.util.Random;

@WebServlet("/sendForgotOTP")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String SENDER_EMAIL = "atharvvats15@gmail.com";
    private static final String APP_PASSWORD = "tumifdznvdzvjxbq";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        try (Connection conn = DBConnection.getConnection()) {

            // Check if email exists
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Generate OTP
                String otp = String.valueOf(100000 + new Random().nextInt(900000));

                // Store OTP and email in session
                HttpSession session = request.getSession();
                session.setAttribute("forgotOtp", otp);
                session.setAttribute("forgotEmail", email);

                // Send email
                sendEmail(email, otp);
                response.getWriter().write("OTP_SENT");

            } else {
                response.getWriter().write("EMAIL_NOT_FOUND");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("ERROR");
        }
    }

    private void sendEmail(String recipientEmail, String otp) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD);
            }
        });

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(SENDER_EMAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("Your OTP to reset password (Voter Portal)");
        message.setText("Dear user,\n\nYour OTP for password reset is: " + otp + "\n\nThis is valid for 5 minutes.\n\n- Voter Portal");

        Transport.send(message);
    }
}
