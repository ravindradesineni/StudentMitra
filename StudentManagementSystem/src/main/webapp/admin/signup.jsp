<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Create Admin Account | StudentMitra</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/signup.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

</head>

<body>

<div class="signup-container">

    <div class="signup-card">

        <div class="logo">
            <i class="fa-solid fa-user-shield"></i>
        </div>

        <h2>Create Admin Account</h2>

        <p>Create a new administrator account.</p>

        <!-- Error Message -->
        <%
        String error = (String) request.getAttribute("error");

        if(error != null){
        %>

        <div class="error-message">
            <%= error %>
        </div>

        <%
        }
        %>

        <!-- Success Message -->
        <%
        String success = (String) request.getAttribute("success");

        if(success != null){
        %>

        <div class="success-message">
            <%= success %>
        </div>

        <script>

        setTimeout(function(){

            window.location.href="<%=request.getContextPath()%>/admin/login.jsp";

        },2000);

        </script>

        <%
        }
        %>

        <form action="${pageContext.request.contextPath}/AdminSignupServlet"
              method="post">

            <div class="input-group">

                <label>Full Name</label>

                <input type="text"
                       name="fullName"
                       placeholder="Enter Full Name"
                       value="<%= request.getAttribute("fullName") == null ? "" : request.getAttribute("fullName") %>"
                       required>

            </div>

            <div class="input-group">

                <label>Email</label>

                <input type="email"
                       name="email"
                       placeholder="Enter Email Address"
                       value="<%= request.getAttribute("email") == null ? "" : request.getAttribute("email") %>"
                       required>

            </div>

            <div class="input-group">

                <label>Username</label>

                <input type="text"
                       name="username"
                       placeholder="Choose Username"
                       value="<%= request.getAttribute("username") == null ? "" : request.getAttribute("username") %>"
                       required>

            </div>

            <div class="input-group">

                <label>Password</label>

                <input type="password"
                       name="password"
                       placeholder="Create Password"
                       required>

            </div>

            <div class="input-group">

                <label>Confirm Password</label>

                <input type="password"
                       name="confirmPassword"
                       placeholder="Confirm Password"
                       required>

            </div>

            <button type="submit" class="signup-btn">

                <i class="fa-solid fa-user-plus"></i>

                Create Account

            </button>

        </form>

        <div class="bottom-text">

            Already have an account?

            <a href="${pageContext.request.contextPath}/admin/login.jsp">

                Login

            </a>

        </div>

    </div>

</div>

</body>

</html>