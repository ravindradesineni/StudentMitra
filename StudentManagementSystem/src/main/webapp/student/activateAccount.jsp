<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Activate Account | StudentMitra</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/activateAccount.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

</head>

<body>

<div class="signup-container">

    <div class="signup-card">

        <div class="logo">

            <i class="fa-solid fa-user-graduate"></i>

        </div>

        <h2>Activate Account</h2>

        <p>

            Activate your account using your
            Student ID and default password.

        </p>
                   <%
String error = (String) request.getAttribute("error");

if(error != null){
%>

<div class="error-message">

    <%= error %>

</div>

<%
}

String success = (String) request.getAttribute("success");

if(success != null){
%>

<div class="success-message">

    <%= success %>

</div>

<script>

setTimeout(function(){

window.location.href="<%=request.getContextPath()%>/student/login.jsp";

},2000);

</script>

<%
}
%>

        <form action="${pageContext.request.contextPath}/ActivateAccountServlet"
              method="post">

            <div class="input-group">

                <label>Student ID</label>

                <input type="number"
                       name="studentId"
                       placeholder="Enter Student ID"
                       required>

            </div>

            <div class="input-group">

                <label>Default Password</label>

                <input type="password"
                       name="defaultPassword"
                       placeholder="Enter Default Password"
                       required>

            </div>

            <div class="input-group">

                <label>New Password</label>

                <input type="password"
                       name="newPassword"
                       placeholder="Create New Password"
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

                <i class="fa-solid fa-key"></i>

                Activate Account

            </button>

        </form>

        <div class="bottom-text">

            Already activated?

            <a href="${pageContext.request.contextPath}/student/login.jsp">

                Login

            </a>

        </div>

    </div>

</div>

</body>

</html>