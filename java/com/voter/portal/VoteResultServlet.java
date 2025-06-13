package com.voter.portal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/VoteResultServlet")
public class VoteResultServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        Map<String, Integer> voteMap = new LinkedHashMap<>();

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT candidate, COUNT(*) as vote_count FROM votes GROUP BY candidate";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                voteMap.put(rs.getString("candidate"), rs.getInt("vote_count"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("voteMap", voteMap);
        session.setAttribute("voteSummarySuccess", true); 
        request.getRequestDispatcher("vote_summary.jsp").forward(request, response);

    }
}
