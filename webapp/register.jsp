<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register | Voter Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .register-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 360px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        input[type="text"], input[type="password"], select {
            width: 100%;
            padding: 10px;
            margin-top: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        .message {
            text-align: center;
            color: green;
        }

        .error {
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Create Account</h2>
        <form action="register" method="post">
            <input type="text" name="name" placeholder="Full Name" required>
            
            <!-- Email with pattern validation -->
           <input type="text" name="email" placeholder="Email" required
       pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
       title="Enter a valid email address">


            
            <input type="password" name="password" placeholder="Password" required minlength="6"
                   title="Minimum 6 characters required">

            <!-- Confirm Password -->
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>

            
            <select name="userType" required>
                <option value="">-- Select User Type --</option>
                <option value="ADMIN">Admin</option>
                <option value="USER">User</option>
            </select>

            <input type="submit" value="Register">
        </form>

        <!-- Message Display -->
        <% 
            String msg = (String) request.getAttribute("message");
            String err = (String) request.getAttribute("error");
            if (msg != null) {
        %>
            <p class="message"><%= msg %></p>
        <% } else if (err != null) { %>
            <p class="error"><%= err %></p>
        <% } %>
    </div>

    <!-- JS for Confirm Password Validation -->
    <script>
        document.querySelector("form").addEventListener("submit", function(e) {
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
