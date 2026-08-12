<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Marks"%>
<%@ page import="com.sms.model.Student"%>
<%@ page import="com.sms.model.Course"%>
<%
Marks marks = (Marks) request.getAttribute("marks");
%>
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
        <h1>Edit Marks</h1>
        <p>Modify exam and assignment grades for the student.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <p style="color: red; margin-bottom: 15px;"><%=request.getAttribute("error")%></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/UpdateMarksSaveServlet" method="post">
            <input type="hidden" name="marksId" value="<%=marks.getMarksId()%>">

            <div class="row">
                <div class="input-group">
                    <label>Student</label>
                    <select name="studentId" required style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #ccc; background-color: #e9ecef;" readonly>
                        <%
                        ArrayList<Student> studentList = (ArrayList<Student>) request.getAttribute("studentList");
                        if (studentList != null) {
                            for (Student s : studentList) {
                                boolean selected = s.getStudentId() == marks.getStudentId();
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
                                boolean selected = c.getCourseId() == marks.getCourseId();
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
                    <label>Internal Test 1 (Max 20)</label>
                    <input type="number" name="internal1" min="0" max="20" value="<%=marks.getInternal1()%>" required>
                </div>
                <div class="input-group">
                    <label>Internal Test 2 (Max 20)</label>
                    <input type="number" name="internal2" min="0" max="20" value="<%=marks.getInternal2()%>" required>
                </div>
            </div>

            <div class="row">
                <div class="input-group">
                    <label>Assignment Marks (Max 10)</label>
                    <input type="number" name="assignment" min="0" max="10" value="<%=marks.getAssignment()%>" required>
                </div>
                <div class="input-group">
                    <label>Final Exam Marks (Max 50)</label>
                    <input type="number" name="finalExam" min="0" max="50" value="<%=marks.getFinalExam()%>" required>
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
