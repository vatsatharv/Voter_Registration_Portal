package com.voter.portal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ViewVoteServlet")
public class ViewVoteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !"user".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String votedCandidate = null;

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT candidate FROM votes WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, user.getId());

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                votedCandidate = rs.getString("candidate");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("votedCandidate", votedCandidate);
        request.getRequestDispatcher("view_vote.jsp").forward(request, response);
    }
}
