<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.voter.portal.User" %>
<%@ page session="true" %>

<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }

    String photoPath = user.getPhotoPath();     // Assuming getters are available
    String idPath = user.getIdProofPath();
    boolean isApproved = user.isApproved();     // Assuming boolean getter
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complete Registration - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f2f4f8;
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
        }
        .container {
            max-width: 600px;
        }
        .form-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
        }
        .form-control[readonly] {
            background-color: #f9f9f9;
        }
        .preview-box {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-box">
        <h3 class="mb-4 text-primary">Complete User Registration</h3>

        <form action="EditUserServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= user.getId() %>">

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" class="form-control" value="<%= user.getName() %>" readonly>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="text" class="form-control" value="<%= user.getEmail() %>" readonly>
            </div>

            <!-- Preview existing photo -->
            <% if (photoPath != null && !photoPath.isEmpty()) { %>
                <div class="preview-box">
                    <label class="form-label">Current Photo</label><br>
                    <img src="<%= photoPath %>" alt="User Photo" style="max-height: 100px; border: 1px solid #ccc;">
                </div>
            <% } %>

            <div class="mb-3">
                <label class="form-label">Upload New Photo</label>
                <input type="file" name="photo" class="form-control" accept="image/*">
            </div>

            <!-- Preview existing ID Proof -->
            <% if (idPath != null && !idPath.isEmpty()) { %>
                <div class="preview-box">
                    <label class="form-label">Current ID Proof</label><br>
                    <a href="<%= idPath %>" target="_blank">View Uploaded ID</a>
                </div>
            <% } %>

            <div class="mb-3">
                <label class="form-label">Upload New ID Proof</label>
                <input type="file" name="idProof" class="form-control">
            </div>

            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" name="isApproved" id="approveCheck" <%= isApproved ? "checked" : "" %>>
                <label class="form-check-label" for="approveCheck">
                    Approve this user
                </label>
            </div>

            <button type="submit" class="btn btn-success w-100">Save & Complete Registration</button>
        </form>

        <div class="mt-3 text-center">
            <a href="adminDashboardServlet" class="btn btn-secondary">← Back to Dashboard</a>
        </div>
    </div>
</div>

</body>
</html>
