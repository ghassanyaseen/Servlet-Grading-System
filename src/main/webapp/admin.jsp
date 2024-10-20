<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #e9f5e9;
            font-family: Arial, sans-serif;
        }

        .container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #000000;
            margin-bottom: 20px;
        }

        .nav-tabs .nav-link.active {
            background-color: #28a745;
            color: #fff;
        }

        .btn-primary {
            background-color: #28a745;
            border: none;
        }

        .btn-primary:hover {
            background-color: #218838;
        }

        .alert {
            padding: 15px;
            margin-top: 20px;
            border-radius: 5px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
        }

        .alert-failure {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
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
    </style>
</head>
<body>

<div class="container mt-5">
    <h1>Admin Dashboard</h1>

    <!-- Message Section: Display if a message or error is set -->
    <c:if test="${not empty message}">
        <div class="alert alert-success">
                ${message}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-failure">
                ${error}
        </div>
    </c:if>

    <!-- Tabs for different actions -->
    <ul class="nav nav-tabs" id="adminTabs" role="tablist">
        <li class="nav-item">
            <a class="nav-link ${activeTab == 'createUser' ? 'active' : ''}" id="createUser-tab" data-toggle="tab" href="#createUser" role="tab">Create User</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${activeTab == 'createCourse' ? 'active' : ''}" id="createCourse-tab" data-toggle="tab" href="#createCourse" role="tab">Create Course</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${activeTab == 'enrollStudent' ? 'active' : ''}" id="enrollStudent-tab" data-toggle="tab" href="#enrollStudent" role="tab">Enroll Student</a>
        </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="adminTabsContent">
        <!-- Create User Tab -->
        <div class="tab-pane fade ${activeTab == 'createUser' ? 'show active' : ''}" id="createUser" role="tabpanel">
            <h2>Create User</h2>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="createUser"/>
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="type">User Type:</label>
                    <select id="type" name="type" class="form-control" required>
                        <option value="student">Student</option>
                        <option value="instructor">Instructor</option>
                        <option value="admin">Admin</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Create User</button>
            </form>
        </div>

        <!-- Create Course Tab -->
        <div class="tab-pane fade ${activeTab == 'createCourse' ? 'show active' : ''}" id="createCourse" role="tabpanel">
            <h2>Create Course</h2>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="createCourse"/>
                <div class="form-group">
                    <label for="courseName">Course Name:</label>
                    <input type="text" id="courseName" name="courseName" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="instructorUsername">Instructor Username:</label>
                    <input type="text" id="instructorUsername" name="instructorUsername" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary">Create Course</button>
            </form>
        </div>

        <!-- Enroll Student Tab -->
        <div class="tab-pane fade ${activeTab == 'enrollStudent' ? 'show active' : ''}" id="enrollStudent" role="tabpanel">
            <h2>Enroll Student</h2>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="enrollStudent"/>
                <div class="form-group">
                    <label for="studentUsername">Student Username:</label>
                    <input type="text" id="studentUsername" name="studentUsername" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="courseName">Course Name:</label>
                    <input type="text" id="courseName" name="courseName" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary">Enroll Student</button>
            </form>
        </div>

        <!-- Logout button -->
        <a href="logout" class="btn-logout">Logout</a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
