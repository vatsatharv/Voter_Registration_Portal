<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    // Restrict access to only normal users
    String role = (String) session.getAttribute("role");
    if (session == null || role == null || !"user".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard | Voter Portal</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #c8e6c9, #e0f2f1);
            font-family: 'Segoe UI', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .dashboard-container {
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            text-align: center;
            width: 400px;
        }

        h2 {
            color: #00796b;
            margin-bottom: 30px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 14px;
            margin: 10px 0;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            color: white;
            cursor: pointer;
            transition: 0.3s;
            text-decoration: none;
        }

        .btn-vote {
            background-color: #388e3c;
        }

        .btn-vote:hover {
            background-color: #2e7d32;
        }

        .btn-main {
            background-color: #0288d1;
        }

        .btn-main:hover {
            background-color: #0277bd;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h2>Welcome to Your Dashboard</h2>
        <a href="vote.jsp" class="btn btn-vote">Vote Now</a>
        <a href="main.jsp" class="btn btn-main">Return to Main Menu</a>
    </div>
</body>
</html>
