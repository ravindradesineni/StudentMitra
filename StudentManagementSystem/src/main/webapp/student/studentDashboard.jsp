<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.Student"%>
<%@ page import="com.sms.model.Announcement"%>
<%@ page import="java.util.ArrayList"%>

<%
Student student = (Student) request.getAttribute("student");
int totalCourses = (Integer) request.getAttribute("totalCourses");
double avgAttendance = (Double) request.getAttribute("avgAttendance");
int gradedCourses = (Integer) request.getAttribute("gradedCourses");
ArrayList<Announcement> recentAnnouncements = (ArrayList<Announcement>) request.getAttribute("recentAnnouncements");
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Dashboard | StudentMitra</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/studentDashboard.css">
<!-- Reuse the table style from admin side for announcements -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/students.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

</head>

<body>

<!-- Sidebar -->

<div class="sidebar student-sidebar">
    <h2>StudentMitra</h2>
    <div style="text-align: center; padding: 20px 10px; border-bottom: 1px solid rgba(255,255,255,0.1); margin-bottom: 15px;">
        <% if (student.getProfilePhoto() != null && !student.getProfilePhoto().isEmpty()) { %>
            <img src="${pageContext.request.contextPath}/<%=student.getProfilePhoto()%>" style="width: 75px; height: 75px; border-radius: 50%; object-fit: cover; border: 2px solid #56ab2f; margin-bottom: 5px;" alt="Avatar">
        <% } else { %>
            <img src="${pageContext.request.contextPath}/uploads/students/default-avatar.png" style="width: 75px; height: 75px; border-radius: 50%; object-fit: cover; border: 2px solid #56ab2f; margin-bottom: 5px;" alt="Avatar">
        <% } %>
        <h3 style="color: #fff; font-size: 14px; margin-top: 5px; font-weight: 600; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"><%=student.getFullName()%></h3>
        <p style="color: rgba(255,255,255,0.6); font-size: 11px;">ID: <%=student.getStudentId()%></p>
    </div>
    <ul>
        <li class="active">
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

<!-- Main -->
<div class="main">
    <div class="top-bar">
        <div style="display: flex; align-items: center; gap: 15px;">
            <% if (student.getProfilePhoto() != null && !student.getProfilePhoto().isEmpty()) { %>
                <img src="${pageContext.request.contextPath}/<%=student.getProfilePhoto()%>" style="width: 55px; height: 55px; border-radius: 50%; object-fit: cover; border: 2px solid #56ab2f;" alt="Avatar">
            <% } else { %>
                <img src="${pageContext.request.contextPath}/uploads/students/default-avatar.png" style="width: 55px; height: 55px; border-radius: 50%; object-fit: cover; border: 2px solid #56ab2f;" alt="Avatar">
            <% } %>
            <div>
                <h1>Welcome, <%=student.getFullName()%> 👋</h1>
                <p>Student Dashboard</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/StudentLogoutServlet" class="logout">
            <i class="fa-solid fa-right-from-bracket"></i>
            Logout
        </a>
    </div>

    <!-- Stats Cards -->
    <div class="cards" style="margin-bottom: 30px;">
        <div class="card">
            <h3>My Courses</h3>
            <h2><%=totalCourses%></h2>
        </div>
        <div class="card">
            <h3>Attendance</h3>
            <h2><%=String.format("%.1f", avgAttendance)%>%</h2>
        </div>
        <div class="card">
            <h3>Graded Courses</h3>
            <h2><%=gradedCourses%></h2>
        </div>
    </div>

    <!-- Assignments Summary Section -->
    <h2 style="margin-bottom: 15px; color: #222; font-size: 20px;">
        <i class="fa-solid fa-book-open" style="margin-right: 8px; color: #1b3b32;"></i>
        Assignments
    </h2>
    <div class="cards" style="margin-bottom: 40px; display: grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap: 20px;">
        <div class="card" style="border-left: 5px solid #2196F3; padding: 15px 20px;">
            <h3 style="font-size: 13px;">Total Assignments</h3>
            <h2 style="font-size: 24px; margin-top: 5px;"><%=request.getAttribute("totalAssignments")%></h2>
        </div>
        <div class="card" style="border-left: 5px solid #FFC107; padding: 15px 20px;">
            <h3 style="font-size: 13px;">Pending</h3>
            <h2 style="font-size: 24px; margin-top: 5px;"><%=request.getAttribute("pendingAssignments")%></h2>
        </div>
        <div class="card" style="border-left: 5px solid #4CAF50; padding: 15px 20px;">
            <h3 style="font-size: 13px;">Submitted</h3>
            <h2 style="font-size: 24px; margin-top: 5px;"><%=request.getAttribute("submittedAssignments")%></h2>
        </div>
        <div class="card" style="border-left: 5px solid #F44336; padding: 15px 20px;">
            <h3 style="font-size: 13px;">Expired</h3>
            <h2 style="font-size: 24px; margin-top: 5px;"><%=request.getAttribute("expiredAssignments")%></h2>
        </div>
        <div class="card" style="border-left: 5px solid #9C27B0; padding: 15px 20px;">
            <h3 style="font-size: 13px;">Remaining Days</h3>
            <h2 style="font-size: 24px; margin-top: 5px;"><%=request.getAttribute("remainingDaysStr")%></h2>
        </div>
    </div>

    <!-- Recent Announcements -->
    <div class="table-box">
        <h2 style="margin-bottom: 15px; color: #222; font-size: 20px;">
            <i class="fa-solid fa-bullhorn" style="margin-right: 8px; color: #1b3b32;"></i>
            Recent Announcements
        </h2>
        <table>
            <thead>
                <tr>
                    <th style="width: 25%;">Title</th>
                    <th>Notice Details</th>
                    <th style="width: 20%;">Posted Date</th>
                </tr>
            </thead>
            <tbody>
            <%
            if (recentAnnouncements != null && !recentAnnouncements.isEmpty()) {
                for (Announcement a : recentAnnouncements) {
            %>
            <tr>
                <td><strong><%=a.getTitle()%></strong></td>
                <td style="white-space: normal; word-wrap: break-word;"><%=a.getDescription()%></td>
                <td><%=a.getPostedDate()%></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="3">No Announcements Available</td>
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