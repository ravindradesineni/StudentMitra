<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Marks"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Marks | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>Grades & Marks Management</h1>
            <p>Manage student internal marks and final letter grades.</p>
        </div>
        <a href="${pageContext.request.contextPath}/DashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <div class="actions">
        <button onclick="window.location.href='${pageContext.request.contextPath}/AddMarksServlet'">
            <i class="fa-solid fa-plus"></i>
            Enter Student Marks
        </button>
    </div>

    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Student Name (ID)</th>
                    <th>Course Code</th>
                    <th>Course Name</th>
                    <th>Internal 1 (20)</th>
                    <th>Internal 2 (20)</th>
                    <th>Assignment (10)</th>
                    <th>Final Exam (50)</th>
                    <th>Total (100)</th>
                    <th>Grade</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<Marks> marksList = (ArrayList<Marks>) request.getAttribute("marksList");
            if (marksList != null && !marksList.isEmpty()) {
                for (Marks m : marksList) {
                    String gradeColor = "green";
                    if ("F".equals(m.getGrade())) {
                        gradeColor = "red";
                    } else if ("S".equals(m.getGrade()) || "A".equals(m.getGrade())) {
                        gradeColor = "#20b2aa";
                    }
            %>
            <tr>
                <td><%=m.getMarksId()%></td>
                <td><%=m.getStudentName()%> (ID: <%=m.getStudentId()%>)</td>
                <td><strong><%=m.getCourseCode()%></strong></td>
                <td><%=m.getCourseName()%></td>
                <td><%=m.getInternal1()%></td>
                <td><%=m.getInternal2()%></td>
                <td><%=m.getAssignment()%></td>
                <td><%=m.getFinalExam()%></td>
                <td><strong><%=m.getTotal()%></strong></td>
                <td><span style="background-color: <%=gradeColor%>; color: white; padding: 4px 10px; border-radius: 4px; font-weight: bold;"><%=m.getGrade()%></span></td>
                <td>
                    <a href="${pageContext.request.contextPath}/UpdateMarksServlet?id=<%=m.getMarksId()%>">Edit</a> |
                    <a href="${pageContext.request.contextPath}/DeleteMarksServlet?id=<%=m.getMarksId()%>"
                       onclick="return confirm('Are you sure you want to delete this mark record?')">Delete</a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="11">No Marks Records Available</td>
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
