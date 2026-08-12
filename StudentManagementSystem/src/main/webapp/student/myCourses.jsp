<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Course"%>
<%@ page import="com.sms.model.Student"%>
<%
Student student = (Student) session.getAttribute("student");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses | StudentMitra</title>
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
        <li class="active">
            <a href="${pageContext.request.contextPath}/StudentCoursesServlet">
                <i class="fa-solid fa-book"></i>
                My Courses
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentAssignmentsServlet">
                <i class="fa-solid fa-pen-to-square"></i>
                Assignments
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentAttendanceServlet">
                <i class="fa-solid fa-calendar-check"></i>
                Attendance
            </a>
        </li>
        <li>
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
            <h1>My Courses</h1>
            <p>List of all courses assigned to the <%=student.getDepartment()%>.</p>
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
                    <th>Semester</th>
                    <th>Faculty Name</th>
                    <th>Credits</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<Course> courseList = (ArrayList<Course>) request.getAttribute("courseList");
            if (courseList != null && !courseList.isEmpty()) {
                for (Course c : courseList) {
            %>
            <tr>
                <td><strong><%=c.getCourseCode()%></strong></td>
                <td><%=c.getCourseName()%></td>
                <td><%=c.getSemester()%></td>
                <td><%=c.getFaculty()%></td>
                <td><%=c.getCredits()%></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5">No courses registered for your department yet.</td>
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
