<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Complete User Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f4f7fa;
            font-family: 'Roboto', sans-serif;
        }
        .container {
            max-width: 700px;
            background: white;
            padding: 40px;
            margin-top: 50px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .form-label {
            font-weight: 500;
            margin-top: 10px;
        }
        .form-control, .form-select {
            border-radius: 6px;
        }
        .btn-primary {
            margin-top: 20px;
            width: 100%;
        }
        .preview {
            margin-top: 10px;
            max-height: 100px;
            border-radius: 8px;
        }
        .note {
            font-size: 0.85rem;
            color: #6c757d;
        }

        /* Toast */
        #toast {
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
            opacity: 0;
            transition: opacity 0.4s ease;
        }
        #toast.show {
            opacity: 1;
        }
    </style>
</head>
<body>

<div class="container">
    <h3 class="mb-4 text-primary text-center">
        <i class="bi bi-person-plus-fill"></i> Complete User Registration
    </h3>

    <form action="registerUser" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Name:</label>
            <input type="text" name="name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email:</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password:</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Gender:</label>
            <select name="gender" class="form-select" required>
                <option value="">-- Select Gender --</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Age:</label>
            <input type="number" name="age" class="form-control" min="18" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Address:</label>
            <textarea name="address" class="form-control" rows="3" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Upload Photo:</label>
            <input type="file" name="photo" class="form-control" onchange="previewFile(this, 'photoPreview')" required>
            <img id="photoPreview" class="preview mt-2" alt="No Preview Available">
            <p class="note">All file types are accepted.</p>
        </div>

        <div class="mb-3">
            <label class="form-label">Upload ID Proof:</label>
            <input type="file" name="id_proof" class="form-control" onchange="previewFile(this, 'idPreview')" required>
            <img id="idPreview" class="preview mt-2" alt="No Preview Available">
            <p class="note">All file types are accepted.</p>
        </div>

        <button type="submit" class="btn btn-primary">
            <i class="bi bi-check-circle-fill"></i> Register User
        </button>
    </form>
</div>

<!-- Toast -->
<div id="toast"></div>

<!-- Scripts -->
<script>
    const params = new URLSearchParams(window.location.search);
    const msg = params.get('msg');
    const error = params.get('error');
    const toast = document.getElementById("toast");

    if (msg || error) {
        toast.innerText = msg || error;
        toast.style.backgroundColor = msg ? "#28a745" : "#dc3545";
        toast.classList.add("show");
        setTimeout(() => toast.classList.remove("show"), 4000);
    }

    function previewFile(input, previewId) {
        const preview = document.getElementById(previewId);
        const file = input.files[0];
        if (file && file.type.startsWith("image/")) {
            const reader = new FileReader();
            reader.onload = e => preview.src = e.target.result;
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
