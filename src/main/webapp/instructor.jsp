<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Dashboard</title>
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


        .alert-failure {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h1>Instructor Dashboard</h1>

    <!-- Message Section: Display if statusMessage is set -->
    <c:if test="${not empty statusMessage}">
        <div class="alert ${statusType == 'success' ? 'alert-success' : 'alert-failure'}">
                ${statusMessage}
        </div>
    </c:if>

    <!-- Tabs for different actions -->
    <ul class="nav nav-tabs" id="instructorTabs" role="tablist">
        <li class="nav-item">
            <a class="nav-link ${activeTab == 'showCourses' ? 'active' : ''}" id="showCourses-tab" data-toggle="tab" href="#showCourses" role="tab">Show Courses</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${activeTab == 'enterGrades' ? 'active' : ''}" id="enterGrades-tab" data-toggle="tab" href="#enterGrades" role="tab">Enter Grades</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${activeTab == 'showStudents' ? 'active' : ''}" id="showStudents-tab" data-toggle="tab" href="#showStudents" role="tab">Show Students</a>
        </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="instructorTabsContent">
        <!-- Show Courses Tab -->
        <div class="tab-pane fade ${activeTab == 'showCourses' ? 'show active' : ''}" id="showCourses" role="tabpanel">
            <h2>Your Courses</h2>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Course Name</th>
                </tr>
                </thead>
                <tbody>
                <!-- Check if courses list is not empty -->
                <c:if test="${not empty courses}">
                    <c:forEach var="course" items="${courses}">
                        <tr>
                            <td>${course}</td>
                        </tr>
                    </c:forEach>
                </c:if>
                <!-- If no courses available -->
                <c:if test="${empty courses}">
                    <tr>
                        <td>No courses available</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <!-- Enter Grades Tab -->
        <div class="tab-pane fade ${activeTab == 'enterGrades' ? 'show active' : ''}" id="enterGrades" role="tabpanel">
            <h2>Enter Grades</h2>
            <form action="instructor" method="post">
                <div class="form-group">
                    <label for="courseName">Course Name:</label>
                    <input type="text" id="courseName" name="courseName" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="studentUsername">Student Username:</label>
                    <input type="text" id="studentUsername" name="studentUsername" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="grade">Grade:</label>
                    <input type="number" id="grade" name="grade" class="form-control" required>
                </div>
                <input type="hidden" name="activeTab" value="enterGrades">  <!-- Hidden field to pass active tab -->
                <button type="submit" name="action" value="submitGrade" class="btn btn-primary">Submit Grade</button>
            </form>
        </div>

        <!-- Show Students Tab -->
        <div class="tab-pane fade ${activeTab == 'showStudents' ? 'show active' : ''}" id="showStudents" role="tabpanel">
            <h2>Students in Course</h2>
            <form action="instructor" method="post">
                <div class="form-group">
                    <label for="courseName">Enter Course Name:</label>
                    <input type="text" id="courseName" name="courseName" class="form-control" required>
                </div>
                <input type="hidden" name="activeTab" value="showStudents">  <!-- Hidden field to pass active tab -->
                <button type="submit" name="action" value="showStudents" class="btn btn-primary">Show Students</button>
            </form>

            <c:if test="${not empty students}">
                <h2>Students in Course: ${selectedCourse}</h2>
                <table class="table table-bordered mt-4">
                    <thead>
                    <tr>
                        <th>Student Information</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Iterate over the list of students -->
                    <c:forEach var="studentInfo" items="${students}">
                        <tr>
                            <td>${studentInfo}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
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
