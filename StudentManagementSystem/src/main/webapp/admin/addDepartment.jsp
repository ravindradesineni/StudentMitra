<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

        <h1>Add Department</h1>

        <p>Enter the department name below.</p>

    </div>

    <div class="form-container">

        <form action="${pageContext.request.contextPath}/AddDepartmentServlet"
              method="post">

            <div class="row">

                <div class="input-group full-width">

                    <label>Department Name</label>

                    <input type="text"
                           name="departmentName"
                           placeholder="Enter Department Name"
                           required>

                </div>

            </div>

            <button type="submit">

                <i class="fa-solid fa-floppy-disk"></i>

                Save Department

            </button>

        </form>

    </div>

</div>

</body>

</html>