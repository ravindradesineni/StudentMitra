<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="sidebar">
    <h2>StudentMitra</h2>
    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/DashboardServlet">
                <i class="fa-solid fa-house"></i>
                Dashboard
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentsServlet">
                <i class="fa-solid fa-user-graduate"></i>
                Students
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/DepartmentsServlet">
                <i class="fa-solid fa-building"></i>
                Departments
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/CoursesServlet">
                <i class="fa-solid fa-book"></i>
                Courses
            </a>
        </li>
        <li class="has-submenu">
            <a href="#" class="submenu-toggle">
                <i class="fa-solid fa-pen-to-square"></i>
                Assignments
                <i class="fa-solid fa-chevron-right arrow-icon"></i>
            </a>
            <ul class="submenu">
                <li class="submenu-item">
                    <a href="${pageContext.request.contextPath}/AddAssignmentServlet">
                        <i class="fa-solid fa-plus"></i> Create Assignment
                    </a>
                </li>
                <li class="submenu-item">
                    <a href="${pageContext.request.contextPath}/AdminAssignmentsServlet">
                        <i class="fa-solid fa-list"></i> View Assignments
                    </a>
                </li>
                <li class="submenu-item">
                    <a href="${pageContext.request.contextPath}/AssignmentSubmissionsServlet">
                        <i class="fa-solid fa-file-invoice"></i> Submissions
                    </a>
                </li>
            </ul>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/AttendanceServlet">
                <i class="fa-solid fa-calendar-check"></i>
                Attendance
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/MarksServlet">
                <i class="fa-solid fa-marker"></i>
                Marks
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/AnnouncementsServlet">
                <i class="fa-solid fa-bullhorn"></i>
                Announcements
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/AcademicCalendarServlet">
                <i class="fa-solid fa-calendar-days"></i>
                Academic Calendar
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudyMaterialsServlet">
                <i class="fa-solid fa-file-pdf"></i>
                Study Materials
            </a>
        </li>
    </ul>
</div>
<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
