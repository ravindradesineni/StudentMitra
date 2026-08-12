<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Attendance"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>Attendance Tracking</h1>
            <p>Monitor and update student class attendance.</p>
        </div>
        <a href="${pageContext.request.contextPath}/DashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <div class="actions">
        <button onclick="window.location.href='${pageContext.request.contextPath}/AddAttendanceServlet'">
            <i class="fa-solid fa-plus"></i>
            Add Attendance Record
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
                    <th>Total Classes</th>
                    <th>Classes Attended</th>
                    <th>Percentage</th>
                    <th>Status</th>
                    <th>Action</th>
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
                <td><%=att.getAttendanceId()%></td>
                <td><%=att.getStudentName()%> (ID: <%=att.getStudentId()%>)</td>
                <td><strong><%=att.getCourseCode()%></strong></td>
                <td><%=att.getCourseName()%></td>
                <td><%=att.getTotalClasses()%></td>
                <td><%=att.getAttendedClasses()%></td>
                <td><strong><%=String.format("%.1f", percentage)%>%</strong></td>
                <td><span style="color: <%=statusColor%>; font-weight: bold;"><%=status%></span></td>
                <td>
                    <a href="${pageContext.request.contextPath}/UpdateAttendanceServlet?id=<%=att.getAttendanceId()%>">Edit</a> |
                    <a href="${pageContext.request.contextPath}/DeleteAttendanceServlet?id=<%=att.getAttendanceId()%>"
                       onclick="return confirm('Are you sure you want to delete this attendance record?')">Delete</a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="9">No Attendance Records Available</td>
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
