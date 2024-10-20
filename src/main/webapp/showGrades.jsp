<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Grades</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f9; /* Light background */
            font-family: Arial, sans-serif;
        }

        .container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            margin-top: 50px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #444; /* Dark gray color for heading */
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #28a745;
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Your Grades</h1>

    <table class="table">
        <thead>
        <tr>
            <th>Course Name</th>
            <th>Grade</th>
        </tr>
        </thead>
        <tbody>
        <!-- Iterate over the list of grades passed from the servlet -->
        <c:forEach var="grade" items="${studentChoice}">
            <tr>
                <!-- Extract Course Name -->
                <td>
                    <c:out value="${fn:split(grade, ',')[0]}" />
                </td>
                <!-- Extract Grade -->
                <td>
                    <c:out value="${fn:split(grade, ',')[1]}" />
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <a href="/student" class="btn btn-primary mt-3">Back to Dashboard</a>
</div>
</body>
</html>
