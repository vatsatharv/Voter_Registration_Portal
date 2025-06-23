package com.voter.portal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/verifyOTP")
public class VerifyOTPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String otpInput = request.getParameter("otp");

        HttpSession session = request.getSession();
        String sessionOtp = (String) session.getAttribute("otp");
        String sessionEmail = (String) session.getAttribute("otpEmail");
        String sessionPassword = (String) session.getAttribute("otpPassword");

        if (otpInput == null || sessionOtp == null || !otpInput.equals(sessionOtp) || !email.equals(sessionEmail)) {
            response.getWriter().write("INVALID_OTP");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE email=? AND password=? AND user_type='user'";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, sessionEmail);
            stmt.setString(2, sessionPassword);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setUserType(rs.getString("user_type"));
                user.setGender(rs.getString("gender"));
                user.setAge(rs.getInt("age"));
                user.setAddress(rs.getString("address"));
                user.setPhotoPath(rs.getString("photo_path"));
                user.setIdProofPath(rs.getString("id_proof_path"));
                user.setApproved(rs.getBoolean("isApproved"));
                user.setHasVoted(rs.getBoolean("hasVoted"));

                session.setAttribute("user", user);
                session.setAttribute("userType", "user");
                session.setAttribute("role", "user");
                session.setAttribute("loginTime", new java.util.Date().toString());
                session.setAttribute("loginSuccess", true);

                // OTP used, remove it from session
                session.removeAttribute("otp");
                session.removeAttribute("otpEmail");
                session.removeAttribute("otpPassword");

                response.getWriter().write("OTP_VERIFIED");
            } else {
                response.getWriter().write("INVALID_OTP");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("DATABASE_ERROR");
        }
    }
}
