<%@ page import="com.voter.portal.User" %>
<%
    User editUser = (User) request.getAttribute("editUser");
    if (editUser == null) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complete User Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f4f7fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .form-container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        h3 {
            color: #007bff;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h3>Complete Registration for: <%= editUser.getName() %></h3>
    <form action="editUser" method="post" enctype="multipart/form-data">

        <!-- Hidden User ID -->
        <input type="hidden" name="id" value="<%= editUser.getId() %>">

        <!-- Email (readonly) -->
        <div class="mb-3">
            <label>Email:</label>
            <input type="email" class="form-control" value="<%= editUser.getEmail() %>" readonly>
        </div>

        <!-- Gender -->
        <div class="mb-3">
            <label>Gender:</label>
            <input type="text" name="gender" class="form-control" required>
        </div>

        <!-- Age -->
        <div class="mb-3">
            <label>Age:</label>
            <input type="number" name="age" class="form-control" min="18" required>
        </div>

        <!-- Address -->
        <div class="mb-3">
            <label>Address:</label>
            <textarea name="address" class="form-control" rows="3" required></textarea>
        </div>

        <!-- Photo Upload -->
        <div class="mb-3">
            <label>Upload Photo:</label>
            <input type="file" name="photo" class="form-control" required>
            <small class="text-muted">All file types allowed. Will be renamed automatically.</small>
        </div>

        <!-- ID Proof Upload -->
        <div class="mb-3">
            <label>Upload ID Proof:</label>
            <input type="file" name="id_proof" class="form-control" required>
            <small class="text-muted">All file types allowed. Will be renamed automatically.</small>
        </div>

        <!-- Approval Checkbox -->
        <div class="form-check mb-4">
            <input class="form-check-input" type="checkbox" name="isApproved" id="isApproved">
            <label class="form-check-label" for="isApproved">Mark as Approved</label>
        </div>

        <div class="d-flex justify-content-between">
            <a href="adminDashboard" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="btn btn-primary">Submit & Save</button>
        </div>
    </form>
</div>

</body>
</html>
