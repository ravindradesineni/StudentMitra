<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Attendance"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance | StudentMitra</title>
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
        <li class="active">
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
            <h1>My Attendance</h1>
            <p>View your class attendance statistics.</p>
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
                    <th>Total Classes</th>
                    <th>Classes Attended</th>
                    <th>Attendance Percentage</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<Attendance> attendanceList = (ArrayList<Attendance>) request.getAttribute("attendanceList");
            if (attendanceList != null && !attendanceList.isEmpty()) {
                for (Attendance att : attendanceList) {
                    double percentage = att.getAttendancePercentage();
                    String status = "Good";
                    String statusColor = "green";
                    if (percentage < 75.0) {
                        status = "Shortage";
                        statusColor = "red";
                    }
            %>
            <tr>
                <td><strong><%=att.getCourseCode()%></strong></td>
                <td><%=att.getCourseName()%></td>
                <td><%=att.getTotalClasses()%></td>
                <td><%=att.getAttendedClasses()%></td>
                <td><strong><%=String.format("%.1f", percentage)%>%</strong></td>
                <td><span style="color: <%=statusColor%>; font-weight: bold;"><%=status%></span></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6">No attendance records found for your account.</td>
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
