<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.voter.portal.User" %>
<%@ page session="true" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null || !"user".equalsIgnoreCase((String) session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    boolean isApproved = loggedInUser.isApproved();
    boolean hasVoted = loggedInUser.isHasVoted();
    String userName = loggedInUser.getName();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cast Your Vote | Voter Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #fff3e0, #e1f5fe);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .vote-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            text-align: center;
            width: 450px;
        }

        h2 {
            color: #0277bd;
        }

        .candidate {
            margin: 15px 0;
            text-align: left;
        }

        .btn {
            padding: 12px 30px;
            background-color: #388e3c;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
        }

        .btn:hover {
            background-color: #2e7d32;
        }

        .disabled-message {
            color: #d32f2f;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="vote-container">
        <h2>Hello, <%= userName %>!</h2>
        <h3>Cast Your Vote</h3>

        <% if (!isApproved) { %>
            <div class="disabled-message">
                ⚠️ You are not yet approved by the admin. Please wait.
            </div>
        <% } else if (hasVoted) { %>
    <div class="disabled-message">
        ✅ You have already voted. Thank you!
    </div>

    <form action="ViewVoteServlet" method="post">
        <button class="btn" type="submit" style="background-color: #f57c00;">View Your Vote</button>
    </form>
<% } else { %>

            <form action="VoteServlet" method="post">
                <div class="candidate">
                    <input type="radio" name="candidate" value="Candidate A" required> Candidate A
                </div>
                <div class="candidate">
                    <input type="radio" name="candidate" value="Candidate B"> Candidate B
                </div>
                <div class="candidate">
                    <input type="radio" name="candidate" value="Candidate C"> Candidate C
                </div>

                <button class="btn" type="submit">Submit Vote</button>
            </form>
        <% } %>

        <br>
        <a href="userDashboard.jsp" class="btn" style="background-color: #0288d1;">Back to Dashboard</a>
    </div>
</body>
</html>
