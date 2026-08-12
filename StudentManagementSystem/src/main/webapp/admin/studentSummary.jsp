<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Student"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Students | StudentMitra</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/students.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">

    <div class="top-bar">

        <div>

            <h1>Total Students</h1>

            <p>Student ID, Name and Department Summary</p>

        </div>

        <a href="${pageContext.request.contextPath}/DashboardServlet"
           class="logout">

            <i class="fa-solid fa-arrow-left"></i>

            Back

        </a>

    </div>

    <div class="table-box">

        <table>

            <thead>

                <tr>

                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Department</th>

                </tr>

            </thead>

            <tbody>

            <%

            ArrayList<Student> studentList =
            (ArrayList<Student>)request.getAttribute("studentList");

            if(studentList != null && !studentList.isEmpty()){

                for(Student student : studentList){

            %>

            <tr>

                <td><%=student.getStudentId()%></td>

                <td><%=student.getFullName()%></td>

                <td><%=student.getDepartment()%></td>

            </tr>

            <%

                }

            }else{

            %>

            <tr>

                <td colspan="3">

                    No Students Found

                </td>

            </tr>

            <%

            }

            %>

            </tbody>

        </table>

    </div>

</div>

</body>

</html>