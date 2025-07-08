package com.voter.portal;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String userType = rs.getString("user_type");


                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setUserType(userType);
                user.setGender(rs.getString("gender"));
                user.setAge(rs.getInt("age"));
                user.setAddress(rs.getString("address"));
                user.setPhotoPath(rs.getString("photo_path"));
                user.setIdProofPath(rs.getString("id_proof_path"));
                user.setApproved(rs.getBoolean("isApproved"));
                user.setHasVoted(rs.getBoolean("hasVoted")); 

                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userType", userType);
                session.setAttribute("role", userType.equalsIgnoreCase("ADMIN") ? "admin" : "user");
                session.setAttribute("loginTime", new java.util.Date().toString());
                session.setAttribute("loginSuccess", true);

                System.out.println("Login Success: Redirecting to " + (userType.equalsIgnoreCase("ADMIN") ? "adminDashboard" : "voter_userDashboard.jsp"));

                response.setContentType("text/plain");
                if (userType.equalsIgnoreCase("ADMIN")) {
                    response.getWriter().print("LOGIN_SUCCESS_ADMIN");
                } else {
                    response.getWriter().print("LOGIN_SUCCESS_USER");
                }

            }
            	else {
                // ❗ Handle invalid credentials
                request.setAttribute("error", "Invalid email or password.");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
