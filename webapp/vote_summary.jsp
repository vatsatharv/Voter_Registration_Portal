<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%
    Map<String, Integer> voteMap = (Map<String, Integer>) request.getAttribute("voteMap");
    int totalVotes = 0;
    if (voteMap != null) {
        for (Integer count : voteMap.values()) {
            totalVotes += count;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vote Summary | Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #e0f7fa, #f3e5f5);
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }

        .summary-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 700px;
        }

        h2 {
            color: #6a1b9a;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
        }

        th, td {
            text-align: center;
            padding: 12px;
        }

        th {
            background-color: #d1c4e9;
            color: #333;
        }

        .total-votes {
            font-size: 18px;
            font-weight: 500;
            margin: 20px 0;
            color: #00796b;
        }

        .btn-back {
            margin-top: 30px;
        }

        #toast {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: #17a2b8;
            color: white;
            padding: 15px 30px;
            border-radius: 10px;
            font-size: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            opacity: 0;
            transition: opacity 0.4s ease;
            z-index: 1000;
        }

        #toast.show {
            opacity: 1;
        }
    </style>
</head>
<body>

<div class="summary-container">
    <h2><i class="bi bi-bar-chart-line-fill"></i> Vote Summary</h2>

    <p class="total-votes">
        🧮 Total Votes Cast: <%= totalVotes %>
    </p>

    <table class="table table-bordered table-hover table-striped">
        <thead>
            <tr>
                <th>Candidate</th>
                <th>Total Votes</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (voteMap != null && !voteMap.isEmpty()) {
                    for (Map.Entry<String, Integer> entry : voteMap.entrySet()) {
            %>
                <tr>
                    <td><%= entry.getKey() %></td>
                    <td><%= entry.getValue() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="2">No votes cast yet.</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <form action="adminDashboard" method="get" class="text-center">
        <button type="submit" class="btn btn-primary btn-back">
            <i class="bi bi-arrow-left-circle-fill"></i> Back to Dashboard
        </button>
    </form>
</div>

<% 
    Boolean voteSummarySuccess = (Boolean) session.getAttribute("voteSummarySuccess");
    if (voteSummarySuccess != null && voteSummarySuccess) {
%>
    <div id="toast">✅ Vote summary loaded successfully!</div>
    <script>
        const toast = document.getElementById("toast");
        toast.classList.add("show");
        setTimeout(() => toast.classList.remove("show"), 4000);
    </script>
<% 
    session.removeAttribute("voteSummarySuccess");
    }
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
