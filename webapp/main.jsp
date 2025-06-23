<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main | Voter Portal</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #e0f7fa, #ffffff);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .main-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }

        .box {
            background-color: white;
            padding: 30px 50px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 500px;
        }

        h2 {
            color: #00796b;
            margin-bottom: 30px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            font-size: 16px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-admin {
            background-color: #f44336;
            color: white;
        }

        .btn-admin:hover {
            background-color: #d32f2f;
        }

        .btn-user {
            background-color: #2196f3;
            color: white;
        }

        .btn-user:hover {
            background-color: #1976d2;
        }

        .btn-register {
            background-color: #4caf50;
            color: white;
        }

        .btn-register:hover {
            background-color: #388e3c;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="box">
            <h2>Welcome to the Online Voter Registration Portal</h2>
            <a href="login.jsp?type=admin" class="btn btn-admin">Login as Admin</a>
            <a href="login.jsp?type=user" class="btn btn-user">Login as User</a>
            <a href="register.jsp" class="btn btn-register">Register</a>
        </div>
    </div>

<%@ include file="footer.jspf" %>
</body>
</html>
