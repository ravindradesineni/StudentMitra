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

            <h1>Students Management</h1>

            <p>Manage all students from one place.</p>

        </div>

        <a href="${pageContext.request.contextPath}/DashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>

    </div>

    <div class="actions">

    <form action="${pageContext.request.contextPath}/StudentsServlet"
          method="get"
          style="display:flex; width:75%;">

        <input type="text"
               name="search"
               placeholder="Search by ID, Name or Email..."
               style="width:100%;">

        <button type="submit"
                style="margin-left:10px;">

            <i class="fa-solid fa-magnifying-glass"></i>

            Search

        </button>

    </form>

    <button onclick="window.location.href='${pageContext.request.contextPath}/admin/addStudent.html'">

        <i class="fa-solid fa-user-plus"></i>

        Add Student

    </button>

</div>

    <div class="table-box">

        <table>

            <thead>

                <tr>

                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Department</th>
                    <th>Year</th>
                    <th>Action</th>

                </tr>

            </thead>

            <tbody>

            <%

            ArrayList<Student> studentList =
                    (ArrayList<Student>) request.getAttribute("studentList");

            if(studentList != null && !studentList.isEmpty()){

                for(Student student : studentList){

            %>

            <tr>

                <td><%=student.getStudentId()%></td>

                <td><%=student.getFullName()%></td>

                <td><%=student.getEmail()%></td>

                <td><%=student.getDepartment()%></td>

                <td><%=student.getYear()%></td>

                <td>

                    <a href="${pageContext.request.contextPath}/AdminStudentProfileServlet?id=<%=student.getStudentId()%>" style="margin-right: 5px;">
                       👁 View Profile
                    </a>
                    |
                    <a href="${pageContext.request.contextPath}/UpdateStudentServlet?id=<%=student.getStudentId()%>">
                       Edit
                    </a>
                    |
                    <a href="${pageContext.request.contextPath}/DeleteStudentServlet?id=<%=student.getStudentId()%>"
                       onclick="return confirm('Are you sure you want to delete this student?')">
                       Delete
                    </a>

                </td>

            </tr>

            <%

                }

            }else{

            %>

            <tr>

                <td colspan="6">

                    No Students Available

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