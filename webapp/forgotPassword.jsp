<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password | Voter Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    <style>
        body {
            background: linear-gradient(to right, #dbeafe, #f0f9ff);
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            border-radius: 12px;
        }
        .btn-primary {
            background-color: #1e40af;
            border: none;
        }
        .btn-primary:hover {
            background-color: #1e3a8a;
        }
        .toast-msg {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-body">
                    <h4 class="text-center text-primary mb-4"><i class="fa-solid fa-key"></i> Forgot Password</h4>
                    
                    <form id="forgotPasswordForm">
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" name="email" class="form-control" placeholder="Enter your registered email" required />
                        </div>

                        <div class="d-grid mb-3">
                            <button type="button" class="btn btn-primary" onclick="sendOTP()">Send OTP</button>
                        </div>

                        <div id="otpSection" style="display: none;">
                            <div class="mb-3">
                                <label class="form-label">OTP</label>
                                <input type="text" name="otp" class="form-control" placeholder="Enter OTP" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">New Password</label>
                                <input type="password" name="newPassword" class="form-control" placeholder="Enter new password" minlength="6"/>
                            </div>
                            <div class="d-grid mb-2">
                                <button type="button" class="btn btn-success" onclick="resetPassword()">Reset Password</button>
                            </div>
                        </div>
                    </form>

                    <div id="messageBox" class="text-center mt-3"></div>

                    <div class="text-center mt-3">
                        <a href="login.jsp" class="text-decoration-none"><i class="fa-solid fa-arrow-left"></i> Back to Login</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Toast -->
<div class="toast-msg" id="toastBox" style="display:none;"></div>

<%@ include file="footer.jspf" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function showToast(message, type) {
        const toastBox = document.getElementById("toastBox");
        toastBox.innerHTML = `<div class="alert alert-${type}" role="alert">${message}</div>`;
        toastBox.style.display = 'block';
        setTimeout(() => toastBox.style.display = 'none', 3500);
    }

    function sendOTP() {
        const email = document.querySelector('input[name="email"]').value;
        fetch('SendOTPServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'email=' + encodeURIComponent(email)
        })
        .then(res => res.text())
        .then(msg => {
            if (msg.includes("success")) {
                document.getElementById("otpSection").style.display = "block";
                showToast("✅ OTP sent to your email.", "success");
            } else {
                showToast("❌ " + msg, "danger");
            }
        })
        .catch(err => showToast("❌ Something went wrong!", "danger"));
    }

    function resetPassword() {
        const email = document.querySelector('input[name="email"]').value;
        const otp = document.querySelector('input[name="otp"]').value;
        const newPassword = document.querySelector('input[name="newPassword"]').value;

        if (otp.trim() === "" || newPassword.trim().length < 6) {
            showToast("❗ Please fill in all fields correctly.", "warning");
            return;
        }

        fetch('ResetPasswordServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `email=${encodeURIComponent(email)}&otp=${encodeURIComponent(otp)}&newPassword=${encodeURIComponent(newPassword)}`
        })
        .then(res => res.text())
        .then(msg => {
            if (msg.includes("success")) {
                showToast("✅ Password changed successfully!", "success");
                setTimeout(() => window.location.href = "login.jsp", 3000);
            } else {
                showToast("❌ " + msg, "danger");
            }
        })
        .catch(err => showToast("❌ Server error!", "danger"));
    }
</script>
</body>
</html>
