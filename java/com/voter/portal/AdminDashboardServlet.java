package com.voter.portal;
import com.voter.portal.UserDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userType") == null
                || !session.getAttribute("userType").toString().equalsIgnoreCase("ADMIN")) {
            // Not logged in or not admin
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<User> users = UserDAO.getAllUsers();
            request.setAttribute("usersList", users);
            RequestDispatcher rd = request.getRequestDispatcher("adminDashboard.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to fetch user data.");
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        }
    }
}
