<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String votedCandidate = (String) request.getAttribute("votedCandidate");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Vote | Voter Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e1f5fe, #fffde7);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .result-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            text-align: center;
            width: 400px;
        }

        h2 {
            color: #00796b;
        }

        .vote-result {
            margin-top: 20px;
            font-size: 20px;
            color: #d84315;
            font-weight: bold;
        }

        .btn {
            margin-top: 30px;
            padding: 10px 25px;
            background-color: #0288d1;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #0277bd;
        }
    </style>
</head>
<body>
    <div class="result-container">
        <h2>Your Vote</h2>
        <div class="vote-result">
            <% if (votedCandidate != null) { %>
                🗳️ You voted for <strong><%= votedCandidate %></strong>
            <% } else { %>
                ⚠️ No vote record found.
            <% } %>
        </div>

        <form action="voter_userDashboard.jsp">
            <button class="btn">Back to Dashboard</button>
        </form>
    </div>
</body>
</html>
