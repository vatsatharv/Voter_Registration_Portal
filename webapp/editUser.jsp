<%@ page import="com.voter.portal.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="p-4">

<div class="container">
    <h2 class="mb-4">Edit User Registration</h2>
    <form action="editUser" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= user.getId() %>">

        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" class="form-control" value="<%= user.getName() %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="text" class="form-control" value="<%= user.getEmail() %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Gender</label>
            <input type="text" name="gender" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Age</label>
            <input type="number" name="age" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Address</label>
            <textarea name="address" class="form-control" rows="2" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Upload Photo</label>
            <input type="file" name="photo" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Upload ID Proof</label>
            <input type="file" name="id_proof" class="form-control" required>
        </div>

        <div class="form-check mb-3">
            <input class="form-check-input" type="checkbox" name="isApproved" value="true" id="approveCheck">
            <label class="form-check-label" for="approveCheck">Approve User</label>
        </div>

        <button type="submit" class="btn btn-success">Submit & Approve</button>
        <a href="adminDashboard.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>

</body>
</html>
