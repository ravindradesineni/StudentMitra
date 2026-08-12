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
        .status-inactive {
            background-color: var(--color-error-bg);
            color: var(--color-error-text);
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
        .info-table {
            width: 100%;
            border-collapse: collapse;
        }
        .info-table td {
            padding: 12px 15px;
            text-align: left;
            font-size: 14px;
            border-bottom: 1px solid var(--border-color);
        }
        .info-table td.label {
            font-weight: 600;
            color: var(--text-muted);
            width: 35%;
        }
        .info-table td.val {
            color: var(--text-main);
        }
    </style>
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>Student Profile</h1>
            <p>Detailed overview of student statistics, academic marks, and files.</p>
        </div>
        <a href="${pageContext.request.contextPath}/StudentsServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <div class="profile-container">
        <!-- Left Section (Photo and Status) -->
        <div class="profile-left">
            <div class="photo-card">
                <% if (student.getProfilePhoto() != null && !student.getProfilePhoto().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/<%=student.getProfilePhoto()%>" class="profile-img" alt="Student Photo">
                <% } else { %>
                    <img src="${pageContext.request.contextPath}/uploads/students/default-avatar.png" class="profile-img" alt="Student Photo">
                <% } %>
                <div class="student-title"><%=student.getFullName()%></div>
                <div class="student-meta">ID: <%=student.getStudentId()%></div>
                <div style="margin-bottom: 25px;">
                    <span class="status-badge <%="Active".equalsIgnoreCase(student.getStatus()) ? "status-active" : "status-inactive"%>">
                        <%=student.getStatus() != null ? student.getStatus() : "Active" %>
                    </span>
                </div>

                <div style="display: flex; flex-direction: column; gap: 10px;">
                    <button onclick="window.location.href='${pageContext.request.contextPath}/UpdateStudentServlet?id=<%=student.getStudentId()%>'" class="portal-btn" style="width: 100%;">
                        <i class="fa-solid fa-user-pen"></i> Edit Student
                    </button>
                    <button onclick="window.location.href='${pageContext.request.contextPath}/StudentsServlet'" class="portal-btn secondary" style="width: 100%;">
                        Back to List
                    </button>
                </div>
            </div>
        </div>

        <!-- Right Section (Details, Attendance, Marks) -->
        <div class="profile-right">
            <!-- Stats Grid -->
            <div class="grid-info">
                <div class="stat-card">
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

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fa-solid fa-graduation-cap"></i>
                    </div>
                    <div class="stat-detail">
                        <h3>Graded Subjects</h3>
                        <p><%=marksList != null ? marksList.size() : 0%> Courses</p>
                    </div>
                </div>
            </div>

            <!-- Profile Details Card -->
            <div class="card" style="padding: 25px;">
                <h2 style="font-size: 16px; font-weight: 600; color: var(--color-primary); margin-bottom: 15px; border-bottom: 1px solid var(--border-color); padding-bottom: 8px;">
                    Personal & Academic Information
                </h2>
                <table class="info-table">
                    <tr>
                        <td class="label">Gender</td>
                        <td class="val"><%=student.getGender()%></td>
                        <td class="label">Date of Birth</td>
                        <td class="val"><%=student.getDob()%></td>
                    </tr>
                    <tr>
                        <td class="label">Email</td>
                        <td class="val"><%=student.getEmail()%></td>
                        <td class="label">Phone</td>
                        <td class="val"><%=student.getPhone()%></td>
                    </tr>
                    <tr>
                        <td class="label">Emergency Contact</td>
                        <td class="val"><%=student.getEmergencyContact() != null ? student.getEmergencyContact() : "N/A"%></td>
                        <td class="label">Address</td>
                        <td class="val"><%=student.getAddress() != null ? student.getAddress() : "N/A"%></td>
                    </tr>
                    <tr>
                        <td class="label">Department</td>
                        <td class="val"><%=student.getDepartment()%></td>
                        <td class="label">Year / Semester</td>
                        <td class="val">Year <%=student.getYear()%> / <%=student.getSemester() != null ? student.getSemester() : "N/A"%></td>
                    </tr>
                    <tr>
                        <td class="label">Course Registered</td>
                        <td class="val" colspan="3"><%=student.getCourse() != null ? student.getCourse() : "Not Registered"%></td>
                    </tr>
                </table>
            </div>

            <!-- Subject Marks Card -->
            <div class="card" style="padding: 25px;">
                <h2 style="font-size: 16px; font-weight: 600; color: var(--color-primary); margin-bottom: 15px; border-bottom: 1px solid var(--border-color); padding-bottom: 8px;">
                    Subject Marks Summary
                </h2>
                <% if (marksList != null && !marksList.isEmpty()) { %>
                    <table style="width: 100%; border-collapse: collapse; margin-top: 5px;">
                        <thead>
                            <tr style="font-size: 13px;">
                                <th>Subject Code</th>
                                <th>Subject Name</th>
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
                                <td><%=m.getCourseCode()%></td>
                                <td style="text-align: left;"><%=m.getCourseName()%></td>
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
                    <p style="color: var(--text-muted); font-size: 13.5px; text-align: center; padding: 15px 0;">
                        No graded subjects recorded yet for this student.
                    </p>
                <% } %>
            </div>
        </div>
    </div>
</div>

</body>
</html>
