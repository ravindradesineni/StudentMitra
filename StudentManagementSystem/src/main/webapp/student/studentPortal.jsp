<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Student Portal | StudentMitra</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/studentPortal.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

</head>

<body>

<div class="container">

    <div class="card">

        <div class="logo">

            <i class="fa-solid fa-user-graduate"></i>

        </div>

        <h2>Student Portal</h2>

        <p>

            Login to your student account or
            activate your account to continue.

        </p>

        <a href="${pageContext.request.contextPath}/student/login.jsp"
           class="portal-btn">

            <i class="fa-solid fa-right-to-bracket"></i>

            Login

        </a>

        <a href="${pageContext.request.contextPath}/student/activateAccount.jsp"
           class="portal-btn secondary">

            <i class="fa-solid fa-user-check"></i>

            Activate Account

        </a>

    </div>

</div>

</body>

</html>