package com.voter.portal;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;

@WebServlet("/showEditUserForm")
public class ShowEditUserFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        try {
            // Get user ID from request
            int userId = Integer.parseInt(request.getParameter("id"));

            // Get user from DB using DAO
            User user = UserDAO.getUserById(userId); // You must have this method in your UserDAO

            if (user != null) {
                // Pass user to JSP
                request.setAttribute("editUser", user);
                RequestDispatcher dispatcher = request.getRequestDispatcher("adminCompleteRegistration.jsp");
                dispatcher.forward(request, response);
            } else {
                // If user not found, redirect with error
                response.sendRedirect("adminDashboard.jsp?error=UserNotFound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=InvalidUser");
        }
    }
}
