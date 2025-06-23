<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | Voter Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0f7fa, #ffffff);
            margin: 0;
            padding: 0;
        }

        .center-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 100px);
        }

        .login-box {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            text-align: center;
            width: 350px;
        }

        input[type="email"], input[type="password"], input[type="number"], button {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        button {
            background-color: #2196f3;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #1976d2;
        }

        #otpSection {
            display: none;
        }

        .error {
            color: red;
        }
    </style>
</head>
<body>

<%@ include file="header.jspf" %>

<div class="center-wrapper">
    <div class="login-box">
        <h2>Login</h2>
        <form id="loginForm">
            <input type="email" id="email" name="email" placeholder="Email" required /><br>
            <input type="password" id="password" name="password" placeholder="Password" required /><br>

            <% String loginType = request.getParameter("type"); %>

            <div id="otpSection">
                <input type="number" id="otp" name="otp" placeholder="Enter OTP" /><br>
            </div>

            <button type="button" id="loginButton">Login</button>
        </form>
        <p id="errorMsg" class="error"></p>
    </div>
</div>

<%@ include file="footer.jspf" %>

<script>
    const loginType = "<%= loginType %>";

    document.getElementById("loginButton").addEventListener("click", function () {
        const email = document.getElementById("email").value;
        const password = document.getElementById("password").value;

        if (loginType === "user") {
            const otpSection = document.getElementById("otpSection");
            const otpInput = document.getElementById("otp");

            if (!otpSection.style.display || otpSection.style.display === "none") {
                // Step 1: Send OTP
                fetch("sendOTP", {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: "email=" + encodeURIComponent(email) + "&password=" + encodeURIComponent(password)
                })
                .then(res => res.text())
                .then(data => {
                    if (data === "OTP_SENT") {
                        otpSection.style.display = "block";
                        document.getElementById("loginButton").textContent = "Verify OTP";
                        document.getElementById("errorMsg").textContent = "";
                    } else {
                        document.getElementById("errorMsg").textContent = "Invalid credentials or error sending OTP.";
                    }
                });
            } else {
                // Step 2: Verify OTP
                const otp = otpInput.value;

                fetch("verifyOTP", {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: "email=" + encodeURIComponent(email) + "&otp=" + encodeURIComponent(otp)
                })
                .then(res => res.text())
                .then(data => {
                    if (data === "OTP_VERIFIED") {
                        window.location.href = "voter_userDashboard.jsp";
                    } else {
                        document.getElementById("errorMsg").textContent = "Invalid OTP.";
                    }
                });
            }

        } else {
            // Admin login
            fetch("login", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "email=" + encodeURIComponent(email) + "&password=" + encodeURIComponent(password)
            })
            .then(res => res.text())
            .then(data => {
                if (data === "LOGIN_SUCCESS_ADMIN") {
                    window.location.href = "adminDashboard";
                } else {
                    document.getElementById("errorMsg").textContent = "Invalid admin credentials.";
                }
            });
        }
    });
</script>

</body>
</html>
