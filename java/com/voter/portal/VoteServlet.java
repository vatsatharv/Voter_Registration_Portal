package com.voter.portal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/VoteServlet")
public class VoteServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !"user".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String selectedCandidate = request.getParameter("candidate");
        if (selectedCandidate == null || selectedCandidate.trim().isEmpty()) {
            session.setAttribute("voteError", "Please select a candidate.");
            response.sendRedirect("voter_userDashboard.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            // Optional: Insert into votes table (if created)
            // Example table: votes(id, user_id, candidate, timestamp)
            String insertVote = "INSERT INTO votes (user_id, candidate) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(insertVote);
            ps.setInt(1, user.getId());
            ps.setString(2, selectedCandidate);
            ps.executeUpdate();

            // Optional: Mark user as voted
            String updateUser = "UPDATE users SET hasVoted = true WHERE id = ?";
            PreparedStatement updatePS = conn.prepareStatement(updateUser);
            updatePS.setInt(1, user.getId());
            updatePS.executeUpdate();

            // Set session flag
            session.setAttribute("hasVoted", true);
            session.setAttribute("voteSuccess", true);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("voteError", "Something went wrong. Try again later.");
        }

        response.sendRedirect("voter_userDashboard.jsp");
    }
}
