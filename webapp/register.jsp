<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register | Voter Portal</title>
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
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #1e3a8a;
            margin-bottom: 25px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }

        .btn-submit {
            background-color: #1e40af;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
            width: 100%;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background-color: #1e3a8a;
        }

        .message {
            margin-top: 15px;
            font-weight: bold;
        }

        .message.success {
            color: green;
        }

        .message.error {
            color: red;
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
    <div class="main-container">
        <div class="form-box">
            <h2>Create Your Account</h2>
            <form action="register" method="post">
                <input type="text" name="name" placeholder="Full Name" required>

                <input type="text" name="email" placeholder="Email" required
                    pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                    title="Enter a valid email address">

                <input type="password" name="password" placeholder="Password" required minlength="6"
                    title="Minimum 6 characters required">

                <input type="password" name="confirmPassword" placeholder="Confirm Password" required>

                <select name="userType" required>
                    <option value="">-- Select User Type --</option>
                    <option value="ADMIN">Admin</option>
                    <option value="USER">User</option>
                </select>

                <button type="submit" class="btn-submit">Register</button>
            </form>

            <%-- Display success or error messages --%>
            <%
                String msg = (String) request.getAttribute("message");
                String err = (String) request.getAttribute("error");
                if (msg != null) {
            %>
                <p class="message success"><%= msg %></p>
            <% } else if (err != null) { %>
                <p class="message error"><%= err %></p>
            <% } %>
        </div>
    </div>

    <%@ include file="footer.jspf" %>

    <!-- Back to Main Page Button -->
    <div class="back-btn-container">
        <a href="main.jsp" class="back-btn">← Back to Main Page</a>
    </div>

    <script>
        // Client-side password match validation
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
