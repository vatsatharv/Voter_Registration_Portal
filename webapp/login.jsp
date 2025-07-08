<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | Online Voter Portal</title>
    
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
            margin: 0;
        }

        .login-container {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            width: 100%;
            max-width: 400px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            background-color: #ffffff;
        }

        .card h3 {
            color: #1a237e;
            margin-bottom: 20px;
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

        #otpSection {
            display: none;
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
    </style>
</head>
<body>

<%@ include file="header.jspf" %>

<div class="login-container">
    <div class="card">
        <h3 class="text-center">Login to Voter Portal</h3>

        <% String loginType = request.getParameter("type"); %>
        <% if ("success".equals(request.getParameter("reset"))) { %>
            <div class="success-msg text-center">Password reset successful! Please log in.</div>
        <% } %>

        <form id="loginForm">
            <div class="mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
            </div>

            <div class="mb-3">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
            </div>

            <div class="mb-3" id="otpSection">
                <input type="number" class="form-control" id="otp" name="otp" placeholder="Enter OTP">
            </div>

            <button type="button" class="btn btn-primary w-100" id="loginButton">Login</button>

            <div class="form-text text-center mt-2">
                <a href="forgotPassword.jsp">Forgot Password?</a>
            </div>

            <p id="errorMsg" class="error-msg text-center mt-2"></p>
        </form>
    </div>
</div>

<%@ include file="footer.jspf" %>

<!-- Scripts -->
<script>
    const loginType = "<%= loginType %>";
   
    function showToast(message, type = 'primary') {
        const toastEl = document.getElementById('customToast');
        const toastMsg = document.getElementById('toastMessage');

        toastMsg.textContent = message;
        toastEl.className = `toast align-items-center text-bg-${type} border-0`;

        const toast = new bootstrap.Toast(toastEl);
        toast.show();
    }


    document.getElementById("loginButton").addEventListener("click", function () {
        const email = document.getElementById("email").value;
        const password = document.getElementById("password").value;
        const otpSection = document.getElementById("otpSection");
        const otpInput = document.getElementById("otp");
        const errorMsg = document.getElementById("errorMsg");

        if (loginType === "user") {
            if (!otpSection.style.display || otpSection.style.display === "none") {
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
                        errorMsg.textContent = "";
                    } else {
                    	showToast("Invalid credentials or error sending OTP.", "danger");
                    }
                });
            } else {
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
                    	showToast("Invalid OTP.", "danger");
                    }
                });
            }
        } else {
            fetch("login", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "email=" + encodeURIComponent(email) + "&password=" + encodeURIComponent(password)
            })
            .then(res => res.text())
            .then(data => {
            	console.log("Raw response:",data);
                if (data === "LOGIN_SUCCESS_ADMIN") {
                	console.log("Login Success: Redirecting to adminDashboard");
                    window.location.href = "adminDashboard";
                } else {
                	showToast("Invalid admin credentials.", "danger");
                }
            });
        }
    });
</script>
<!-- Toast Container -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 9999">
    <div id="customToast" class="toast align-items-center text-bg-primary border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body" id="toastMessage">Placeholder message</div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
