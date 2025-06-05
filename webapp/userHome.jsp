<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    if (session == null || session.getAttribute("userType") == null || 
        !session.getAttribute("userType").equals("USER")) {
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
    <title>User Dashboard</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            background-color: #f4f4f4;
        }

        .content {
            flex: 1;
            padding: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .dashboard-card {
            background: white;
            padding: 30px;
            max-width: 600px;
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .badge {
            padding: 5px 10px;
            background-color: #dc3545;
            color: white;
            border-radius: 5px;
            font-size: 12px;
            margin-left: 8px;
        }

        .logout-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #1976d2;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
        }

        .logout-btn:hover {
            background-color: #0d47a1;
        }
    </style>
</head>
<body>
    <%@ include file="header.jspf" %>

    <div class="content">
        <div class="dashboard-card">
            <h2>Welcome to the Voter Portal, <%= name %><span class="badge">USER</span></h2>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Login Time:</strong> <%= loginTime %></p>
            <a href="logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <%@ include file="footer.jspf" %>
</body>
</html>
