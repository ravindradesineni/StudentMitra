<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sms.model.Department"%>

<%
Department department = (Department) request.getAttribute("department");
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Departments | StudentMitra</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/addStudent.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">

    <div class="page-title">

        <h1>Update Department</h1>

        <p>Edit Department Details</p>

    </div>

    <div class="form-container">

        <form action="${pageContext.request.contextPath}/UpdateDepartmentSaveServlet"
              method="post">

            <div class="row">

                <div class="input-group">

                    <label>Department ID</label>

                    <input type="number"
                           name="departmentId"
                           value="<%=department.getDepartmentId()%>"
                           readonly>

                </div>

                <div class="input-group">

                    <label>Department Name</label>

                    <input type="text"
                           name="departmentName"
                           value="<%=department.getDepartmentName()%>"
                           required>

                </div>

            </div>

            <button type="submit">

                <i class="fa-solid fa-pen-to-square"></i>

                Update Department

            </button>

        </form>

    </div>

</div>

</body>

</html>