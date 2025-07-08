<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error | Voter Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #f8d7da, #fff);
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .error-container {
            text-align: center;
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
        }

        .error-icon {
            font-size: 4rem;
            color: #dc3545;
        }

        .error-message {
            font-size: 1.25rem;
            color: #333;
            margin-top: 20px;
        }

        .btn-back {
            margin-top: 30px;
            background-color: #dc3545;
            border: none;
        }

        .btn-back:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

<div class="error-container">
    <div class="error-icon">
        <i class="fa-solid fa-triangle-exclamation"></i>
    </div>
    <h3 class="mt-3 text-danger">Oops! Something went wrong.</h3>
    <p class="error-message">
        <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unexpected error occurred. Please try again later." %>
    </p>
    <a href="main.jsp" class="btn btn-back text-white">
        <i class="fa-solid fa-arrow-left"></i> Back to Home
    </a>
</div>

</body>
</html>
