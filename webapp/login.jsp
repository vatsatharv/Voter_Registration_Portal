<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | Voter Portal</title>
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

        .form-box {
            background-color: white;
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 400px;
        }

        h2 {
            color: #00796b;
            margin-bottom: 25px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .btn-submit {
            background-color: #2196f3;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-submit:hover {
            background-color: #1976d2;
        }

        .main-page-btn {
            display: inline-block;
            margin-top: 20px;
            background-color: #4caf50;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .main-page-btn:hover {
            background-color: #388e3c;
        }

        .error {
            color: red;
            margin-top: 15px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="form-box">
            <h2>Login to Your Account</h2>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="text" name="email" placeholder="Enter Email" required>
                <input type="password" name="password" placeholder="Enter Password" required>
                <br><br>
                <button type="submit" class="btn-submit">Login</button>
            </form>

            <a href="main.jsp" class="main-page-btn">Go to Main Page</a>

            <% 
                String error = (String) request.getAttribute("error");
                if (error != null) { 
            %>
                <p class="error"><%= error %></p>
            <% } %>
        </div>
    </div>
<%@ include file="footer.jspf" %>
</body>
</html>
