<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Course"%>
<%@ page import="com.sms.model.Department"%>
<%
Course course = (Course) request.getAttribute("course");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addStudent.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="page-title">
        <h1>Edit Course</h1>
        <p>Modify the course details below.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <p style="color: red; margin-bottom: 15px;"><%=request.getAttribute("error")%></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/UpdateCourseSaveServlet" method="post">
            <input type="hidden" name="courseId" value="<%=course.getCourseId()%>">

            <div class="row">
                <div class="input-group">
                    <label>Course Code</label>
                    <input type="text" name="courseCode" value="<%=course.getCourseCode()%>" required>
                </div>
                <div class="input-group">
                    <label>Course Name</label>
                    <input type="text" name="courseName" value="<%=course.getCourseName()%>" required>
                </div>
            </div>

            <div class="row">
                <div class="input-group">
                    <label>Department</label>
                    <select name="department" required style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #ccc;">
                        <%
                        ArrayList<Department> deptList = (ArrayList<Department>) request.getAttribute("departmentList");
                        if (deptList != null) {
                            for (Department d : deptList) {
                                boolean selected = d.getDepartmentName().equals(course.getDepartment());
                        %>
                        <option value="<%=d.getDepartmentName()%>" <%=selected ? "selected" : ""%>><%=d.getDepartmentName()%></option>
                        <%
                            }
                        }
                        %>
                    </select>
                </div>
                <div class="input-group">
                    <label>Semester</label>
                    <select name="semester" required style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #ccc;">
                        <option value="Semester 1" <%="Semester 1".equals(course.getSemester()) ? "selected" : ""%>>Semester 1</option>
                        <option value="Semester 2" <%="Semester 2".equals(course.getSemester()) ? "selected" : ""%>>Semester 2</option>
                        <option value="Semester 3" <%="Semester 3".equals(course.getSemester()) ? "selected" : ""%>>Semester 3</option>
                        <option value="Semester 4" <%="Semester 4".equals(course.getSemester()) ? "selected" : ""%>>Semester 4</option>
                        <option value="Semester 5" <%="Semester 5".equals(course.getSemester()) ? "selected" : ""%>>Semester 5</option>
                        <option value="Semester 6" <%="Semester 6".equals(course.getSemester()) ? "selected" : ""%>>Semester 6</option>
                        <option value="Semester 7" <%="Semester 7".equals(course.getSemester()) ? "selected" : ""%>>Semester 7</option>
                        <option value="Semester 8" <%="Semester 8".equals(course.getSemester()) ? "selected" : ""%>>Semester 8</option>
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="input-group">
                    <label>Faculty Name</label>
                    <input type="text" name="faculty" value="<%=course.getFaculty()%>" required>
                </div>
                <div class="input-group">
                    <label>Credits</label>
                    <select name="credits" required style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #ccc;">
                        <option value="1" <%=course.getCredits() == 1 ? "selected" : ""%>>1</option>
                        <option value="2" <%=course.getCredits() == 2 ? "selected" : ""%>>2</option>
                        <option value="3" <%=course.getCredits() == 3 ? "selected" : ""%>>3</option>
                        <option value="4" <%=course.getCredits() == 4 ? "selected" : ""%>>4</option>
                        <option value="5" <%=course.getCredits() == 5 ? "selected" : ""%>>5</option>
                    </select>
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
