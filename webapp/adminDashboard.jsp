<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.voter.portal.User" %>

<%@ page session="true" %>

<%
    User admin = (User) session.getAttribute("user");
    if(admin == null || !"ADMIN".equalsIgnoreCase(admin.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard - Voter Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: #f4f7fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .welcome-banner {
            background: linear-gradient(135deg, #007bff, #00bcd4);
            color: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .action-btns .btn {
            margin-right: 5px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold" href="adminDashboard.jsp">Admin Dashboard</a>
    <div class="d-flex">
      <a href="logout" class="btn btn-outline-light">Logout</a>
    </div>
  </div>
</nav>

<!-- Container -->
<div class="container mt-4">

    <!-- Welcome Banner -->
<div class="welcome-banner shadow-sm">
    <h3>Welcome, <%= admin.getName() %> 👋</h3>
    <p>You have full access to manage user registrations and voting activity.</p>
</div>


    <!-- User Table -->
    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0">Registered Users</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped mb-0">
                <thead class="table-primary">
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
                            <a href="editUser?id=<%= u.getId() %>" class="btn btn-sm btn-warning">
                                <i class="bi bi-pencil-fill"></i> Edit
                            </a>
                            <form action="deleteUser" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="<%= u.getId() %>" />
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
                        <td colspan="5" class="text-center text-muted p-3">No users found.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
<%
    Boolean loginSuccess = (Boolean) session.getAttribute("loginSuccess");
    if (loginSuccess != null && loginSuccess) {
%>
    <div id="toast" style="
        position: fixed;
        top: 20px;
        left: 50%;
        transform: translateX(-50%);
        background: #28a745;
        color: white;
        padding: 15px 30px;
        border-radius: 10px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        font-size: 16px;
        z-index: 1000;
        opacity: 1;
        transition: opacity 0.5s ease;
    ">
        ✅ Login successful! Welcome back.
    </div>
    <script>
        setTimeout(() => {
            const toast = document.getElementById("toast");
            if (toast) toast.style.opacity = "0";
        }, 3000);
        setTimeout(() => {
            const toast = document.getElementById("toast");
            if (toast) toast.remove();
        }, 4000);
    </script>
<%
        session.removeAttribute("loginSuccess"); // remove so it doesn't show again
    }
%>

</html>
