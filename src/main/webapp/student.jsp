<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e9f5e9;
            font-family: Arial, sans-serif;
        }

        .container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 80%;
            margin: 0 auto;
            margin-top: 50px;
        }

        h1 {
            color: #000000;
            margin-bottom: 20px;
            text-align: center;
        }

        .btn-primary {
            background-color: #28a745;
            border: none;
            padding: 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.3s;
        }

        .btn-primary:hover {
            background-color: #218838;
        }

        .btn-primary:focus {
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.5);
        }

        .btn-logout {
            background-color: #dc3545;
            border: none;
            padding: 12px;
            border-radius: 4px;
            color: white;
            display: block;
            width: 150px;
            text-align: center;
            margin: 20px auto 0;
        }

        .btn-logout:hover {
            background-color: #c82333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        select {
            width: 100%;
            padding: 12px;
            border-radius: 5px;
            border: 1px solid #ddd;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Welcome, Student!</h1>
    <form action="student" method="post">
        <div class="form-group">
            <label for="options">Choose an option:</label>
            <select id="options" name="options" class="form-control">
                <option value="showGrades">Show Grades</option>
                <option value="showGPA">Show GPA</option>
            </select>
        </div>
        <button type="submit" class="btn-primary">Submit</button>
    </form>

    <!-- Logout button -->
    <a href="logout" class="btn-logout">Logout</a>
</div>
</body>
</html>
