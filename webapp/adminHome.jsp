<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    if (session == null || session.getAttribute("userType") == null || 
        !session.getAttribute("userType").equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
    String loginTime = (String) session.getAttribute("loginTime");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f4f4f4;
        }
        .badge {
            padding: 5px 10px;
            background-color: #dc3545;
            color: white;
            border-radius: 5px;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <h2>Welcome, <%= name %> <span class="badge">ADMIN</span></h2>
    <p><strong>Email:</strong> <%= email %></p>
    <p><strong>Login Time:</strong> <%= loginTime %></p>
    <p>You have full access to the portal.</p>
    <a href="logout">Logout</a>
</body>
</html>
