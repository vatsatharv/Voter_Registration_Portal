<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");
    String redirectPage = "userDashboard.jsp";
    if ("admin".equalsIgnoreCase(role)) {
        redirectPage = "adminDashboard";  // This is the correct page
    }

%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/style.css">
    <meta charset="UTF-8">
    <title>Login Successful</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: url('bg.jpg') no-repeat center center fixed;
            background-size: cover;
            backdrop-filter: blur(6px);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }

        .success-box {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 0 30px rgba(0,0,0,0.1);
            text-align: center;
        }

        .success-box .checkmark {
            font-size: 48px;
            color: #28a745;
            margin-bottom: 20px;
        }

        .success-box h2 {
            margin: 10px 0;
            font-size: 26px;
            color: #333;
        }

        .success-box p {
            color: #555;
            margin-bottom: 30px;
        }

        .btn-continue {
            background-color: #5bc0de;
            border: none;
            padding: 12px 24px;
            font-size: 16px;
            border-radius: 8px;
            color: white;
            cursor: pointer;
            transition: background 0.3s ease;
            text-decoration: none;
        }

        .btn-continue:hover {
            background-color: #31b0d5;
        }
    </style>
</head>
<body>

    <div class="success-box">
        <div class="checkmark">&#10004;</div>
        <h2>Login Successful</h2>
        <p>Welcome, <%= name %>! You have successfully logged in to the Voter Portal.</p>
        <a href="<%= redirectPage %>" class="btn-continue">Continue to Dashboard</a>
    </div>
</body>
</html>
