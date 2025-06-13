<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register New User</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f0f8ff, #e0f7fa);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #00796b;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        input[type="file"] {
            margin-top: 10px;
        }

        .note {
            font-size: 12px;
            color: #888;
        }

        .btn-submit {
            margin-top: 30px;
            background-color: #0288d1;
            color: white;
            border: none;
            padding: 12px 24px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }

        .btn-submit:hover {
            background-color: #0277bd;
        }

        .preview {
            margin-top: 10px;
            max-width: 100px;
            max-height: 100px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        /* Toast */
        #toast {
            visibility: hidden;
            min-width: 300px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 8px;
            padding: 16px;
            position: fixed;
            z-index: 1000;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 14px;
        }

        #toast.show {
            visibility: visible;
            animation: fadein 0.5s, fadeout 0.5s 3s;
        }

        @keyframes fadein {
            from { bottom: 0; opacity: 0; }
            to { bottom: 30px; opacity: 1; }
        }

        @keyframes fadeout {
            from { bottom: 30px; opacity: 1; }
            to { bottom: 0; opacity: 0; }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Register New User</h2>

    <form action="registerUser" method="post" enctype="multipart/form-data">
        <label>Name:</label>
        <input type="text" name="name" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <label>Gender:</label>
        <select name="gender" required>
            <option value="">-- Select Gender --</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select>

        <label>Age:</label>
        <input type="number" name="age" min="18" required>

        <label>Address:</label>
        <textarea name="address" rows="3" required></textarea>

        <label>Upload Photo:</label>
        <input type="file" name="photo" accept="*" onchange="previewFile(this, 'photoPreview')" required>
        <img id="photoPreview" class="preview" alt="No Preview Available">
        <p class="note">Note: All file types are accepted</p>

        <label>Upload ID Proof:</label>
        <input type="file" name="id_proof" accept="*" onchange="previewFile(this, 'idPreview')" required>
        <img id="idPreview" class="preview" alt="No Preview Available">
        <p class="note">Note: All file types are accepted</p>

        <button type="submit" class="btn-submit">Register User</button>
    </form>
</div>

<div id="toast"></div>

<script>
    // Show toast if success or error message present
    const urlParams = new URLSearchParams(window.location.search);
    const msg = urlParams.get('msg');
    const error = urlParams.get('error');

    if (msg || error) {
        const toast = document.getElementById("toast");
        toast.innerText = msg || error;
        toast.style.backgroundColor = msg ? "#4CAF50" : "#f44336";
        toast.className = "show";
        setTimeout(() => { toast.className = toast.className.replace("show", ""); }, 4000);
    }

    function previewFile(input, previewId) {
        const preview = document.getElementById(previewId);
        const file = input.files[0];

        if (file && file.type.startsWith("image/")) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
        }
    }
</script>

</body>
</html>
