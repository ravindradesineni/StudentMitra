<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.Student"%>
<%@ page import="com.sms.model.Marks"%>
<%@ page import="java.util.ArrayList"%>
<%
Student student = (Student) request.getAttribute("student");
double overallAttendance = (Double) request.getAttribute("overallAttendance");
ArrayList<Marks> marksList = (ArrayList<Marks>) request.getAttribute("marksList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addStudent.css">
    <!-- Reuse tables style from admin/students.css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <style>
        .profile-container {
            display: flex;
            gap: 30px;
            margin-top: 20px;
        }
        .profile-left {
            width: 30%;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .profile-right {
            width: 70%;
            display: flex;
            flex-direction: column;
            gap: 25px;
        }
        .photo-card {
            background-color: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            padding: 30px;
            width: 100%;
            text-align: center;
            box-shadow: var(--shadow-sm);
        }
        .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--color-primary);
            box-shadow: var(--shadow-sm);
            margin-bottom: 20px;
        }
        .profile-icon-fallback {
            color: var(--color-primary);
            font-size: 130px;
            margin-bottom: 20px;
        }
        .student-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 5px;
        }
        .student-meta {
            font-size: 13.5px;
            color: var(--text-muted);
            margin-bottom: 15px;
        }
        .status-badge {
            padding: 6px 12px;
            border-radius: var(--border-radius-sm);
            font-weight: 600;
            font-size: 12px;
            display: inline-block;
        }
        .status-active {
            background-color: var(--color-success-bg);
            color: var(--color-success-text);
        }
        .grid-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .stat-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            padding: 20px 25px;
            display: flex;
            align-items: center;
            gap: 20px;
            box-shadow: var(--shadow-sm);
        }
        .stat-icon {
            font-size: 32px;
            color: var(--color-primary);
            background-color: var(--color-primary-light);
            width: 60px;
            height: 60px;
            border-radius: var(--border-radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .stat-detail h3 {
            font-size: 13px;
            color: var(--text-muted);
            text-transform: uppercase;
            font-weight: 500;
            margin-bottom: 4px;
        }
        .stat-detail p {
            font-size: 22px;
            font-weight: 700;
            color: var(--text-main);
        }
        .progress-bar-container {
            width: 100%;
            height: 8px;
            background-color: var(--border-color);
            border-radius: 4px;
            margin-top: 10px;
            overflow: hidden;
        }
        .progress-bar {
            height: 100%;
            background-color: var(--color-primary);
            border-radius: 4px;
        }
        /* Style for photo upload input */
        .upload-btn-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
            margin-bottom: 10px;
        }
        .upload-btn-wrapper input[type=file] {
            font-size: 100px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
        }
    </style>
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
        <li>
            <a href="${pageContext.request.contextPath}/StudentDashboardServlet">
                <i class="fa-solid fa-house"></i>
                Dashboard
            </a>
        </li>
        <li class="active">
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

<!-- Main Content -->
<div class="main">
    <div class="top-bar">
        <div>
            <h1>My Profile</h1>
            <p>View your details and update your contact information.</p>
        </div>
        <a href="${pageContext.request.contextPath}/StudentDashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <!-- Message Alerts -->
    <% if (request.getAttribute("error") != null) { %>
        <div class="error-message">
            <i class="fa-solid fa-triangle-exclamation"></i> <%=request.getAttribute("error")%>
        </div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
        <div class="success-message">
            <i class="fa-solid fa-circle-check"></i> <%=request.getAttribute("success")%>
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/StudentProfileServlet" method="post" enctype="multipart/form-data">
        <div class="profile-container">
            <!-- Left Side (Avatar upload & stats) -->
            <div class="profile-left">
                <div class="photo-card">
                    <% if (student.getProfilePhoto() != null && !student.getProfilePhoto().isEmpty()) { %>
                        <img src="${pageContext.request.contextPath}/<%=student.getProfilePhoto()%>" class="profile-img" alt="My Photo">
                    <% } else { %>
                        <img src="${pageContext.request.contextPath}/uploads/students/default-avatar.png" class="profile-img" alt="My Photo">
                    <% } %>
                    <div class="student-title"><%=student.getFullName()%></div>
                    <div class="student-meta">ID: <%=student.getStudentId()%></div>
                    
                    <div style="margin-bottom: 20px;">
                        <span class="status-badge status-active">Active</span>
                    </div>

                    <!-- Upload Field -->
                    <div class="upload-btn-wrapper">
                        <button type="button" class="btn btn-secondary" style="width: 100%;">
                            <i class="fa-solid fa-camera"></i> Change Photo
                        </button>
                        <input type="file" name="profilePicture" accept=".jpg,.jpeg,.png">
                    </div>
                    <p style="font-size: 11px; color: var(--text-muted); margin-bottom: 25px;">Allowed types: JPG, JPEG, PNG. Max: 2MB</p>

                    <button type="submit" class="portal-btn" style="width: 100%;">
                        <i class="fa-solid fa-floppy-disk"></i> Save Changes
                    </button>
                </div>
            </div>

            <!-- Right Side (Editable & Readonly form columns, Marks summary) -->
            <div class="profile-right">
                <!-- Top Attendance bar -->
                <div class="stat-card" style="width: 100%;">
                    <div class="stat-icon">
                        <i class="fa-solid fa-calendar-days"></i>
                    </div>
                    <div class="stat-detail" style="width: calc(100% - 80px);">
                        <h3>Overall Attendance</h3>
                        <p><%=String.format("%.1f", overallAttendance)%>%</p>
                        <div class="progress-bar-container">
                            <div class="progress-bar" style="width: <%=overallAttendance%>%"></div>
                        </div>
                    </div>
                </div>

                <!-- Form Fields Card -->
                <div class="card" style="padding: 25px; box-shadow: var(--shadow-sm);">
                    <h2 style="font-size: 15px; font-weight: 600; color: var(--color-primary); margin-bottom: 15px; border-bottom: 1px solid var(--border-color); padding-bottom: 8px;">
                        Personal & Contact Information
                    </h2>
                    
                    <!-- Read-only section -->
                    <div class="row">
                        <div class="input-group">
                            <label>Student ID</label>
                            <input type="text" value="<%=student.getStudentId()%>" readonly style="background-color: #f5f5f5;">
                        </div>
                        <div class="input-group">
                            <label>Full Name</label>
                            <input type="text" value="<%=student.getFullName()%>" readonly style="background-color: #f5f5f5;">
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-group">
                            <label>Email Address</label>
                            <input type="text" value="<%=student.getEmail()%>" readonly style="background-color: #f5f5f5;">
                        </div>
                        <div class="input-group">
                            <label>Gender</label>
                            <input type="text" value="<%=student.getGender()%>" readonly style="background-color: #f5f5f5;">
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-group">
                            <label>Department</label>
                            <input type="text" value="<%=student.getDepartment()%>" readonly style="background-color: #f5f5f5;">
                        </div>
                        <div class="input-group">
                            <label>Course Name</label>
                            <input type="text" value="<%=student.getCourse() != null ? student.getCourse() : "Not Assigned"%>" readonly style="background-color: #f5f5f5;">
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-group">
                            <label>Semester</label>
                            <input type="text" value="<%=student.getSemester() != null ? student.getSemester() : "Not Assigned"%>" readonly style="background-color: #f5f5f5;">
                        </div>
                        <div class="input-group">
                            <!-- Editable Phone -->
                            <label>Phone Number</label>
                            <input type="text" name="phone" value="<%=student.getPhone()%>" required>
                        </div>
                    </div>

                    <!-- Editable Section -->
                    <div class="row">
                        <div class="input-group">
                            <label>Emergency Contact</label>
                            <input type="text" name="emergencyContact" value="<%=student.getEmergencyContact() != null ? student.getEmergencyContact() : ""%>" maxlength="10" required>
                        </div>
                        <div class="input-group">
                            <label>Residential Address</label>
                            <input type="text" name="address" value="<%=student.getAddress() != null ? student.getAddress() : ""%>" required>
                        </div>
                    </div>
                </div>

                <!-- Marks Summary -->
                <div class="card" style="padding: 25px; box-shadow: var(--shadow-sm);">
                    <h2 style="font-size: 15px; font-weight: 600; color: var(--color-primary); margin-bottom: 15px; border-bottom: 1px solid var(--border-color); padding-bottom: 8px;">
                        My Grades & Marks
                    </h2>
                    <% if (marksList != null && !marksList.isEmpty()) { %>
                        <table style="width: 100%; border-collapse: collapse; margin-top: 5px;">
                            <thead>
                                <tr style="font-size: 13px;">
                                    <th>Subject</th>
                                    <th>Int 1</th>
                                    <th>Int 2</th>
                                    <th>Assign</th>
                                    <th>Final</th>
                                    <th>Total</th>
                                    <th>Grade</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% for (Marks m : marksList) { %>
                                <tr style="font-size: 13px;">
                                    <td style="text-align: left;"><strong><%=m.getCourseCode()%></strong> - <%=m.getCourseName()%></td>
                                    <td><%=m.getInternal1()%></td>
                                    <td><%=m.getInternal2()%></td>
                                    <td><%=m.getAssignment()%></td>
                                    <td><%=m.getFinalExam()%></td>
                                    <td><strong><%=m.getTotal()%></strong></td>
                                    <td>
                                        <span style="font-weight: 700; color: <%="F".equals(m.getGrade()) ? "var(--color-error-text)" : "var(--color-primary)"%>;"><%=m.getGrade()%></span>
                                    </td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    <% } else { %>
                        <p style="color: var(--text-muted); font-size: 13px; text-align: center; padding: 15px 0;">
                            No subjects have been graded yet.
                        </p>
                    <% } %>
                </div>
            </div>
        </div>
    </form>
</div>

<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
</body>
</html>