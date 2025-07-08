package com.voter.portal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession(false);
        String email = (session != null) ? (String) session.getAttribute("resetEmail") : null;

        if (email == null || newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
            response.sendRedirect("resetPassword.jsp?error=Invalid+input+or+session+expired");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE users SET password = ? WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                // Clear session and redirect to login
                session.removeAttribute("resetEmail");
                response.sendRedirect("login.jsp?reset=success");
            } else {
                response.sendRedirect("resetPassword.jsp?error=Unable+to+update+password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("resetPassword.jsp?error=Server+error");
        }
    }
}
