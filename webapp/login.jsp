<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | Voter Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 320px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        input[type="submit"], .main-page-btn {
    width: 100%;
    background-color: #6c757d; /* Gray - Secondary */
    color: white;
    border: none;
    padding: 12px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
    text-align: center;
    display: block;
    text-decoration: none;
    margin-top: 10px;
}

.main-page-btn:hover {
    background-color: #5a6268;
}

        }

        input[type="submit"]:hover, .main-page-btn:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            text-align: center;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="login" method="post">
            <input type="text" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>

        <!-- New Button to Main Page -->
        <a href="register.jsp" class="main-page-btn">Go to Main Page</a>

        <% 
            String error = (String) request.getAttribute("error");
            if (error != null) { 
        %>
            <p class="error"><%= error %></p>
        <% } %>
    </div>
</body>
</html>
