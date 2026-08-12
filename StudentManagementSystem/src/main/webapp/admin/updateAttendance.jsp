<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Attendance"%>
<%@ page import="com.sms.model.Student"%>
<%@ page import="com.sms.model.Course"%>
<%
Attendance attendance = (Attendance) request.getAttribute("attendance");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addStudent.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="page-title">
        <h1>Edit Attendance</h1>
        <p>Modify attendance records for the student.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <p style="color: red; margin-bottom: 15px;"><%=request.getAttribute("error")%></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/UpdateAttendanceSaveServlet" method="post">
            <input type="hidden" name="attendanceId" value="<%=attendance.getAttendanceId()%>">

            <div class="row">
                <div class="input-group">
                    <label>Student</label>
                    <select name="studentId" required style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #ccc; background-color: #e9ecef;" readonly>
                        <%
                        ArrayList<Student> studentList = (ArrayList<Student>) request.getAttribute("studentList");
                        if (studentList != null) {
                            for (Student s : studentList) {
                                boolean selected = s.getStudentId() == attendance.getStudentId();
                                if (selected) {
                        %>
                        <option value="<%=s.getStudentId()%>" selected><%=s.getFullName()%> (ID: <%=s.getStudentId()%>)</option>
                        <%
                                }
                            }
                        }
                        %>
                    </select>
                </div>
                <div class="input-group">
                    <label>Course</label>
                    <select name="courseId" required style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #ccc; background-color: #e9ecef;" readonly>
                        <%
                        ArrayList<Course> courseList = (ArrayList<Course>) request.getAttribute("courseList");
                        if (courseList != null) {
                            for (Course c : courseList) {
                                boolean selected = c.getCourseId() == attendance.getCourseId();
                                if (selected) {
                        %>
                        <option value="<%=c.getCourseId()%>" selected><%=c.getCourseName()%> (<%=c.getCourseCode()%>)</option>
                        <%
                                }
                            }
                        }
                        %>
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="input-group">
                    <label>Total Conducted Classes</label>
                    <input type="number" name="totalClasses" min="1" value="<%=attendance.getTotalClasses()%>" required>
                </div>
                <div class="input-group">
                    <label>Classes Attended</label>
                    <input type="number" name="attendedClasses" min="0" value="<%=attendance.getAttendedClasses()%>" required>
                </div>
            </div>

            <button type="submit">
                <i class="fa-solid fa-floppy-disk"></i>
                Save Changes
            </button>
        </form>
    </div>
</div>

</body>
</html>
