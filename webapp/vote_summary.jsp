<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%
    Map<String, Integer> voteMap = (Map<String, Integer>) request.getAttribute("voteMap");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Vote Summary | Admin Panel</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #f3e5f5, #e3f2fd);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .summary-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            text-align: center;
            width: 500px;
        }

        h2 {
            color: #6a1b9a;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f0f4c3;
            color: #333;
        }

        td {
            font-size: 18px;
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
    <div class="summary-container">
        <h2>🗳️ Vote Summary</h2>
        
        <%
    int totalVotes = 0;
    if (voteMap != null) {
        for (Integer count : voteMap.values()) {
            totalVotes += count;
        }
    }
%>

<p style="font-size: 18px; font-weight: bold; margin-bottom: 20px;">
    🧮 Total Votes Cast: <%= totalVotes %>
</p>
        

        <table>
            <tr>
                <th>Candidate</th>
                <th>Total Votes</th>
            </tr>
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
        </table>

        <form action="adminDashboard"  method="get">
            <button class="btn">Back to Dashboard</button>
        </form>
       </div>

    <!-- ✅ Toast Message for Vote Summary Loaded -->
    <%
        Boolean voteSummarySuccess = (Boolean) session.getAttribute("voteSummarySuccess");
        if (voteSummarySuccess != null && voteSummarySuccess) {
    %>
        <div id="toast" style="
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: #17a2b8;
            color: white;
            padding: 15px 30px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            font-size: 16px;
            z-index: 1000;
            opacity: 1;
            transition: opacity 0.5s ease;
        ">
            ✅ Vote summary loaded successfully!
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
            session.removeAttribute("voteSummarySuccess");
        }
    %>

</body>
</html>
