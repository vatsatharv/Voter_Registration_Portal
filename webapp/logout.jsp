<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logged Out</title>
    <meta http-equiv="refresh" content="6;URL=main.jsp">
    <style>
        body {
            background-color: #f4f6f8;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
        }

        .main-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .box {
            background: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            animation: fadeIn 1.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 10px;
        }

        p {
            color: #555;
        }

        .btn {
            display: inline-block;
            margin: 15px 10px 0 10px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .redirect-note {
            font-size: 0.9rem;
            color: #888;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="box">
            <h2>You have successfully logged out.</h2>
            <p>Thank you for using the Online Voter Registration Portal.</p>
            <a href="login.jsp" class="btn">Back to Login</a>
            <a href="main.jsp" class="btn">Go to Main Page</a>
            <p class="redirect-note">You will be redirected to the main page in 6 seconds...</p>
        </div>
    </div>

    <%@ include file="footer.jspf" %>
</body>
</html>
