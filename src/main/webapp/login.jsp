<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e9f5e9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            max-width: 360px;
            width: 100%;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            box-sizing: border-box;
        }

        h2 {
            margin: 0 0 20px;
            text-align: center;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
            font-weight: bold;
        }

        input[type="text"], input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            background-color: #28a745; /* Green background */
            color: #fff;
            border: none;
            padding: 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.3s;
        }

        button:hover {
            background-color: #218838; /* Darker green on hover */
            transform: translateY(-2px); /* Slight lift effect */
        }

        p {
            margin-top: 15px;
            color: #d9534f; /* Red color for error messages */
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Login</h2>
    <form action="login" method="post">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Login</button>
    </form>

    <!-- Display error message if available -->
    <c:if test="${not empty errorMessage}">
        <p>${errorMessage}</p>
    </c:if>
</div>
</body>
</html>
