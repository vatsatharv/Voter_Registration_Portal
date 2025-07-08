<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | Voter Portal</title>

    <!-- Responsive Meta Tag -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
        }

        .register-container {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            width: 100%;
            max-width: 500px;
            padding: 30px;
            border-radius: 10px;
            background-color: #ffffff;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
        }

        h3 {
            color: #1a237e;
            margin-bottom: 20px;
            text-align: center;
        }

        .btn-primary {
            background-color: #1a237e;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0d164d;
        }

        .form-text a {
            text-decoration: none;
            color: #1a237e;
            font-size: 14px;
        }

        .error-msg {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }

        .success-msg {
            color: green;
            font-size: 14px;
            margin-top: 10px;
        }

        .back-btn-container {
            position: fixed;
            bottom: 10px;
            left: 10px;
        }

        .back-btn {
            background-color: #4caf50;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
        }

        .back-btn:hover {
            background-color: #388e3c;
        }
    </style>
</head>
<body>

<div class="register-container">
    <div class="card">
        <h3>Create Your Account</h3>

        <form action="register" method="post">
            <div class="mb-3">
                <input type="text" class="form-control" name="name" placeholder="Full Name" required>
            </div>

            <div class="mb-3">
                <input type="email" class="form-control" name="email" placeholder="Email" required
                       pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                       title="Enter a valid email address">
            </div>

            <div class="mb-3">
                <input type="password" class="form-control" name="password" placeholder="Password" required minlength="6"
                       title="Minimum 6 characters required">
            </div>

            <div class="mb-3">
                <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm Password" required>
            </div>

            <div class="mb-3">
                <select name="userType" class="form-select" required>
                    <option value="">-- Select User Type --</option>
                    <option value="ADMIN">Admin</option>
                    <option value="USER">User</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100">Register</button>

            <%-- Show message based on server feedback --%>
            <%
                String msg = (String) request.getAttribute("message");
                String err = (String) request.getAttribute("error");
                if (msg != null) {
            %>
                <p class="success-msg text-center"><%= msg %></p>
            <% } else if (err != null) { %>
                <p class="error-msg text-center"><%= err %></p>
            <% } %>
        </form>
    </div>
</div>

<%@ include file="footer.jspf" %>

<!-- Back Button -->
<div class="back-btn-container">
    <a href="main.jsp" class="back-btn">← Back to Main Page</a>
</div>

<script>
    // Password match validation
    document.querySelector("form").addEventListener("submit", function (e) {
        const pwd = document.querySelector('input[name="password"]').value;
        const cpwd = document.querySelector('input[name="confirmPassword"]').value;
        if (pwd !== cpwd) {
            e.preventDefault();
            alert("Passwords do not match!");
        }
    });
</script>

</body>
</html>
