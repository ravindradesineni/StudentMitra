<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addStudent.css">
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
        <li class="active">
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
    <div class="page-title">
        <h1>Change Password</h1>
        <p>Update your portal access password.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <p style="color: red; margin-bottom: 15px; font-weight: 500;">
                <i class="fa-solid fa-triangle-exclamation"></i> <%=request.getAttribute("error")%>
            </p>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <p style="color: green; margin-bottom: 15px; font-weight: 500;">
                <i class="fa-solid fa-circle-check"></i> <%=request.getAttribute("success")%>
            </p>
        <% } %>
        <form action="${pageContext.request.contextPath}/ChangePasswordServlet" method="post">
            <div class="row">
                <div class="input-group full-width">
                    <label>Current Password</label>
                    <input type="password" name="currentPassword" placeholder="Enter Current Password" required>
                </div>
            </div>

            <div class="row">
                <div class="input-group">
                    <label>New Password</label>
                    <input type="password" name="newPassword" placeholder="Enter New Password" required>
                </div>
                <div class="input-group">
                    <label>Confirm New Password</label>
                    <input type="password" name="confirmPassword" placeholder="Confirm New Password" required>
                </div>
            </div>

            <button type="submit">
                <i class="fa-solid fa-key"></i>
                Update Password
            </button>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
</body>
</html>
