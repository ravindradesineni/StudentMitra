<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Marks"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Marks | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentDashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<div class="sidebar student-sidebar">
    <h2>StudentMitra</h2>
    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/StudentDashboardServlet">
                <i class="fa-solid fa-house"></i>
                Dashboard
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentProfileServlet">
                <i class="fa-solid fa-user"></i>
                My Profile
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentCoursesServlet">
                <i class="fa-solid fa-book"></i>
                My Courses
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentAttendanceServlet">
                <i class="fa-solid fa-calendar-check"></i>
                Attendance
            </a>
        </li>
        <li class="active">
            <a href="${pageContext.request.contextPath}/StudentMarksServlet">
                <i class="fa-solid fa-marker"></i>
                Marks
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentAnnouncementsServlet">
                <i class="fa-solid fa-bullhorn"></i>
                Announcements
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/ChangePasswordServlet">
                <i class="fa-solid fa-key"></i>
                Change Password
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentAcademicCalendarServlet">
                <i class="fa-solid fa-calendar-days"></i>
                Academic Calendar
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentStudyMaterialsServlet">
                <i class="fa-solid fa-file-pdf"></i>
                Study Materials
            </a>
        </li>
    
    </ul>
</div>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>My Marks</h1>
            <p>View your course grades and evaluation results.</p>
        </div>
        <a href="${pageContext.request.contextPath}/StudentLogoutServlet" class="logout">
            <i class="fa-solid fa-right-from-bracket"></i>
            Logout
        </a>
    </div>

    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>Course Code</th>
                    <th>Course Name</th>
                    <th>Internal 1 (20)</th>
                    <th>Internal 2 (20)</th>
                    <th>Assignment (10)</th>
                    <th>Final Exam (50)</th>
                    <th>Total (100)</th>
                    <th>Grade</th>
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
                <td><strong><%=m.getCourseCode()%></strong></td>
                <td><%=m.getCourseName()%></td>
                <td><%=m.getInternal1()%></td>
                <td><%=m.getInternal2()%></td>
                <td><%=m.getAssignment()%></td>
                <td><%=m.getFinalExam()%></td>
                <td><strong><%=m.getTotal()%></strong></td>
                <td><span style="background-color: <%=gradeColor%>; color: white; padding: 4px 10px; border-radius: 4px; font-weight: bold;"><%=m.getGrade()%></span></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="8">No mark records found for your account.</td>
            </tr>
            <%
            }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
</body>
</html>
