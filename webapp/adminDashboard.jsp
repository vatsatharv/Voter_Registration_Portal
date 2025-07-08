<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.voter.portal.User" %>
<%@ page session="true" %>

<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard - Voter Portal</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Google Fonts & Font Awesome -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f6fa;
            font-family: 'Roboto', sans-serif;
        }

        .welcome-banner {
            background: linear-gradient(135deg, #1a237e, #3949ab);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .welcome-banner h3 {
            margin-bottom: 10px;
        }

        .btn-custom {
            background-color: #3949ab;
            color: white;
            border: none;
        }

        .btn-custom:hover {
            background-color: #1a237e;
        }

        .table thead {
            background-color: #1a237e;
            color: white;
        }

        .action-btns .btn {
            margin-right: 6px;
        }

        .toast-message {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            padding: 15px 30px;
            border-radius: 10px;
            font-size: 16px;
            z-index: 1000;
            opacity: 1;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="adminDashboard.jsp"><i class="bi bi-speedometer2"></i> Admin Dashboard</a>
        <div class="d-flex">
            <a href="logout" class="btn btn-outline-light"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </div>
    </div>
</nav>

<!-- Main Container -->
<div class="container mt-4">

    <!-- Welcome Banner -->
    <div class="welcome-banner shadow-sm">
        <h3>Welcome, <%= admin.getName() %> 👋</h3>
        <p>You have full access to manage user registrations and monitor voting activity.</p>
        <a href="VoteResultServlet" class="btn btn-light mt-3 fw-bold">
            <i class="bi bi-bar-chart-line-fill"></i> View Vote Summary
        </a>
    </div>

    <!-- Registered Users Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0"><i class="bi bi-people-fill"></i> Registered Users</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>User Type</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<User> users = (List<User>) request.getAttribute("usersList");
                    if (users != null && !users.isEmpty()) {
                        for (User u : users) {
                %>
                    <tr>
                        <td><%= u.getId() %></td>
                        <td><%= u.getName() %></td>
                        <td><%= u.getEmail() %></td>
                        <td><%= u.getUserType() %></td>
                        <td class="action-btns">
                            <a href="showEditUserForm?id=<%= u.getId() %>" class="btn btn-sm btn-warning">
                                <i class="bi bi-pencil-fill"></i> Edit
                            </a>
                            <form action="deleteUser" method="post" class="d-inline">
                                <input type="hidden" name="id" value="<%= u.getId() %>">
                                <button type="submit" class="btn btn-sm btn-danger"
                                    onclick="return confirm('Are you sure you want to delete this user?');">
                                    <i class="bi bi-trash-fill"></i> Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5" class="text-center text-muted p-4">No users found.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<%-- Toast: Login Success --%>
<%
    Boolean loginSuccess = (Boolean) session.getAttribute("loginSuccess");
    if (loginSuccess != null && loginSuccess) {
%>
    <div class="toast-message bg-success text-white">
        ✅ Login successful! Welcome back.
    </div>
    <script>
        setTimeout(() => document.querySelector(".toast-message").style.opacity = "0", 3000);
        setTimeout(() => document.querySelector(".toast-message").remove(), 4000);
    </script>
<%
        session.removeAttribute("loginSuccess");
    }
%>

<%-- Toast: Edit Success or Failure --%>
<%
    Boolean editSuccess = (Boolean) session.getAttribute("editSuccess");
    if (editSuccess != null) {
%>
    <div class="toast-message <%= editSuccess ? "bg-success" : "bg-danger" %> text-white">
        <%= editSuccess ? "✅ User details updated successfully." : "❌ Failed to update user details." %>
    </div>
    <script>
        setTimeout(() => document.querySelector(".toast-message").style.opacity = "0", 3000);
        setTimeout(() => document.querySelector(".toast-message").remove(), 4000);
    </script>
<%
        session.removeAttribute("editSuccess");
    }
%>

</body>
</html>
