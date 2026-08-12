<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Course"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<!-- Sidebar -->
<jsp:include page="sidebar.jsp"/>

<!-- Main Content -->
<div class="main">
    <div class="top-bar">
        <div>
            <h1>Course Management</h1>
            <p>Manage all academic courses from one place.</p>
        </div>
        <a href="${pageContext.request.contextPath}/DashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <div class="actions">
        <button onclick="window.location.href='${pageContext.request.contextPath}/AddCourseServlet'">
            <i class="fa-solid fa-plus"></i>
            Add Course
        </button>
    </div>

    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Course Code</th>
                    <th>Course Name</th>
                    <th>Department</th>
                    <th>Semester</th>
                    <th>Faculty</th>
                    <th>Credits</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<Course> courseList = (ArrayList<Course>) request.getAttribute("courseList");
            if (courseList != null && !courseList.isEmpty()) {
                for (Course course : courseList) {
            %>
            <tr>
                <td><%=course.getCourseId()%></td>
                <td><strong><%=course.getCourseCode()%></strong></td>
                <td><%=course.getCourseName()%></td>
                <td><%=course.getDepartment()%></td>
                <td><%=course.getSemester()%></td>
                <td><%=course.getFaculty()%></td>
                <td><%=course.getCredits()%></td>
                <td>
                    <a href="${pageContext.request.contextPath}/UpdateCourseServlet?id=<%=course.getCourseId()%>">Edit</a> |
                    <a href="${pageContext.request.contextPath}/DeleteCourseServlet?id=<%=course.getCourseId()%>"
                       onclick="return confirm('Are you sure you want to delete this course?')">Delete</a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="8">No Courses Available</td>
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
