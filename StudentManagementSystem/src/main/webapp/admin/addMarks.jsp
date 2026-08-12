<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Student"%>
<%@ page import="com.sms.model.Course"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Marks | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addStudent.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="page-title">
        <h1>Enter Student Marks</h1>
        <p>Record exam and assignment marks for a student.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <p style="color: red; margin-bottom: 15px;"><%=request.getAttribute("error")%></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/AddMarksServlet" method="post">
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
                    <label>Internal Test 1 (Max 20)</label>
                    <input type="number" name="internal1" min="0" max="20" placeholder="e.g. 18" required>
                </div>
                <div class="input-group">
                    <label>Internal Test 2 (Max 20)</label>
                    <input type="number" name="internal2" min="0" max="20" placeholder="e.g. 17" required>
                </div>
            </div>

            <div class="row">
                <div class="input-group">
                    <label>Assignment Marks (Max 10)</label>
                    <input type="number" name="assignment" min="0" max="10" placeholder="e.g. 9" required>
                </div>
                <div class="input-group">
                    <label>Final Exam Marks (Max 50)</label>
                    <input type="number" name="finalExam" min="0" max="50" placeholder="e.g. 42" required>
                </div>
            </div>

            <button type="submit">
                <i class="fa-solid fa-floppy-disk"></i>
                Save Marks
            </button>
        </form>
    </div>
</div>

</body>
</html>
