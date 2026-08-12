<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Student"%>
<%@ page import="com.sms.model.Course"%>
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
        <h1>Add Attendance</h1>
        <p>Record attendance for a student in a specific course.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <p style="color: red; margin-bottom: 15px;"><%=request.getAttribute("error")%></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/AddAttendanceServlet" method="post">
            <div class="row">
                <div class="input-group">
                    <label>Select Student</label>
                    <select name="studentId" required style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #ccc;">
                        <option value="">Choose Student</option>
                        <%
                        ArrayList<Student> studentList = (ArrayList<Student>) request.getAttribute("studentList");
                        if (studentList != null) {
                            for (Student s : studentList) {
                        %>
                        <option value="<%=s.getStudentId()%>"><%=s.getFullName()%> (ID: <%=s.getStudentId()%>)</option>
                        <%
                            }
                        }
                        %>
                    </select>
                </div>
                <div class="input-group">
                    <label>Select Course</label>
                    <select name="courseId" required style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #ccc;">
                        <option value="">Choose Course</option>
                        <%
                        ArrayList<Course> courseList = (ArrayList<Course>) request.getAttribute("courseList");
                        if (courseList != null) {
                            for (Course c : courseList) {
                        %>
                        <option value="<%=c.getCourseId()%>"><%=c.getCourseName()%> (<%=c.getCourseCode()%>)</option>
                        <%
                            }
                        }
                        %>
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="input-group">
                    <label>Total Conducted Classes</label>
                    <input type="number" name="totalClasses" min="1" placeholder="e.g. 50" required>
                </div>
                <div class="input-group">
                    <label>Classes Attended</label>
                    <input type="number" name="attendedClasses" min="0" placeholder="e.g. 45" required>
                </div>
            </div>

            <button type="submit">
                <i class="fa-solid fa-floppy-disk"></i>
                Save Attendance
            </button>
        </form>
    </div>
</div>

</body>
</html>
