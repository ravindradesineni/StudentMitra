<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login | StudentMitra</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/login.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>

.error-message{

    background:#FEE2E2;
    color:#B91C1C;
    border:1px solid #FCA5A5;
    padding:12px;
    border-radius:8px;
    margin-bottom:20px;
    text-align:center;
    font-weight:600;

}

</style>

</head>

<body>

<div class="container">

    <div class="login-card">

        <a href="${pageContext.request.contextPath}/index.html" class="back-btn">

            <i class="fa-solid fa-arrow-left"></i>

            Back to Home

        </a>

        <div class="logo">

            <i class="fa-solid fa-user-shield"></i>

        </div>

        <h1>Admin Login</h1>

        <p class="subtitle">

            Login using your administrator credentials.

        </p>

        <% String error = (String)request.getAttribute("error"); %>

        <% if(error != null){ %>

            <div class="error-message">

                <%= error %>

            </div>

        <% } %>

        <form action="${pageContext.request.contextPath}/AdminLoginServlet" method="post">

            <div class="input-group">

                <label>Username</label>

                <input
                    type="text"
                    name="username"
                    placeholder="Enter Username"
                    required>

            </div>

            <div class="input-group">

                <label>Password</label>

                <input
                    type="password"
                    name="password"
                    placeholder="Enter Password"
                    required>

            </div>

            <button type="submit">

                <i class="fa-solid fa-right-to-bracket"></i>

                Login

            </button>

        </form>

    </div>

</div>

</body>

</html>