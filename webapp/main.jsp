<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Voter Registration Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #2980b9, #6dd5fa);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background: white;
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.15);
            text-align: center;
            width: 350px;
        }

        h1 {
            color: #2c3e50;
            margin-bottom: 25px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            margin: 12px 0;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
            text-decoration: none;
            color: white;
        }

        .btn-new {
            background-color: #27ae60;
        }

        .btn-new:hover {
            background-color: #1e8449;
        }

        .btn-old {
            background-color: #2980b9;
        }

        .btn-old:hover {
            background-color: #1f618d;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to the Voter Portal</h1>
        <a href="register.jsp" class="btn btn-new">New User - Register</a>
        <a href="login.jsp" class="btn btn-old">Existing User - Login</a>
    </div>
</body>
</html>
