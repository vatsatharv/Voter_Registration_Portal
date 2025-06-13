<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.voter.portal.User" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"user".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    User loggedInUser = (User) session.getAttribute("user");
    boolean isApproved = (loggedInUser != null) ? loggedInUser.isApproved() : false;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard | Voter Portal</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #c8e6c9, #e0f2f1);
            font-family: 'Segoe UI', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .dashboard-container {
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            text-align: center;
            width: 400px;
        }

        h2 {
            color: #00796b;
            margin-bottom: 30px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 14px;
            margin: 10px 0;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            color: white;
            cursor: pointer;
            transition: 0.3s;
            text-decoration: none;
        }

        .btn-vote {
            background-color: #388e3c;
        }

        .btn-vote:hover {
            background-color: #2e7d32;
        }

        .btn-main {
            background-color: #0288d1;
        }

        .btn-main:hover {
            background-color: #0277bd;
        }

        .btn-disabled {
            background-color: gray;
            cursor: not-allowed;
        }

        .note {
            color: #d32f2f;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h2>Login Successful</h2>
        <h2>Welcome to Your Dashboard</h2>

        <% if (isApproved) { %>
    <% if (!loggedInUser.isHasVoted()) { %>
        <a href="voter_userDashboard.jsp" class="btn btn-vote">Vote Now</a>
    <% } else { %>
        <form action="ViewMyVoteServlet" method="get" style="display:inline;">
            <button class="btn btn-vote" type="submit">View My Vote</button>
        </form>
    <% } %>
<% } else { %>
    <button class="btn btn-disabled" disabled>Vote Now</button>
    <div class="note">Your registration is pending admin approval.</div>
<% } %>


        <a href="main.jsp" class="btn btn-main">Return to Main Menu</a>
    </div>
</body>

<%
    Boolean loginSuccess = (Boolean) session.getAttribute("loginSuccess");
    if (loginSuccess != null && loginSuccess) {
%>
    <div id="toast" style="
        position: fixed;
        top: 20px;
        left: 50%;
        transform: translateX(-50%);
        background: #28a745;
        color: white;
        padding: 15px 30px;
        border-radius: 10px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        font-size: 16px;
        z-index: 1000;
        opacity: 1;
        transition: opacity 0.5s ease;
    ">
        ✅ Login successful! Welcome back.
    </div>
    <script>
        setTimeout(() => {
            const toast = document.getElementById("toast");
            if (toast) toast.style.opacity = "0";
        }, 3000);
        setTimeout(() => {
            const toast = document.getElementById("toast");
            if (toast) toast.remove();
        }, 4000);
    </script>
<%
        session.removeAttribute("loginSuccess");
    }
%>

</html>
