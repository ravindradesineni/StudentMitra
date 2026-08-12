<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.StudyMaterial"%>
<%@ page import="com.sms.model.Course"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Study Materials | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>Study Materials</h1>
            <p>Upload, update, and manage student course notes and academic materials.</p>
        </div>
        <a href="${pageContext.request.contextPath}/DashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <!-- Filter & Action Actions Header -->
    <div class="actions" style="flex-wrap: wrap; gap: 15px; justify-content: space-between;">
        <form action="${pageContext.request.contextPath}/StudyMaterialsServlet" method="get" style="display: flex; gap: 10px; flex-grow: 1; max-width: 80%; flex-wrap: wrap;">
            <input type="text" name="search" placeholder="Search title or files..." value="<%=request.getAttribute("search")%>" style="width: 20%; min-width: 130px;">
            
            <select name="course" style="width: 20%; min-width: 140px;">
                <option value="All" <%="All".equals(request.getAttribute("course")) ? "selected" : ""%>>All Courses</option>
                <%
                ArrayList<Course> courseList = (ArrayList<Course>) request.getAttribute("courseList");
                if (courseList != null) {
                    for (Course c : courseList) {
                        String val = c.getCourseCode();
                %>
                    <option value="<%=val%>" <%=val.equals(request.getAttribute("course")) ? "selected" : ""%>><%=val%></option>
                <%
                    }
                }
                %>
            </select>

            <select name="semester" style="width: 20%; min-width: 130px;">
                <option value="All" <%="All".equals(request.getAttribute("semester")) ? "selected" : ""%>>All Semesters</option>
                <option value="Semester 1" <%="Semester 1".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 1</option>
                <option value="Semester 2" <%="Semester 2".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 2</option>
                <option value="Semester 3" <%="Semester 3".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 3</option>
                <option value="Semester 4" <%="Semester 4".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 4</option>
                <option value="Semester 5" <%="Semester 5".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 5</option>
                <option value="Semester 6" <%="Semester 6".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 6</option>
                <option value="Semester 7" <%="Semester 7".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 7</option>
                <option value="Semester 8" <%="Semester 8".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 8</option>
            </select>

            <select name="category" style="width: 20%; min-width: 130px;">
                <option value="All" <%="All".equals(request.getAttribute("category")) ? "selected" : ""%>>All Categories</option>
                <option value="Notes" <%="Notes".equals(request.getAttribute("category")) ? "selected" : ""%>>Notes</option>
                <option value="Lab Manual" <%="Lab Manual".equals(request.getAttribute("category")) ? "selected" : ""%>>Lab Manual</option>
                <option value="Assignment" <%="Assignment".equals(request.getAttribute("category")) ? "selected" : ""%>>Assignment</option>
                <option value="Previous Question Paper" <%="Previous Question Paper".equals(request.getAttribute("category")) ? "selected" : ""%>>Previous Question Paper</option>
                <option value="Presentation" <%="Presentation".equals(request.getAttribute("category")) ? "selected" : ""%>>Presentation</option>
                <option value="Reference Material" <%="Reference Material".equals(request.getAttribute("category")) ? "selected" : ""%>>Reference Material</option>
                <option value="Syllabus" <%="Syllabus".equals(request.getAttribute("category")) ? "selected" : ""%>>Syllabus</option>
                <option value="Other" <%="Other".equals(request.getAttribute("category")) ? "selected" : ""%>>Other</option>
            </select>

            <button type="submit">
                <i class="fa-solid fa-filter"></i> Apply
            </button>
        </form>

        <button onclick="window.location.href='${pageContext.request.contextPath}/UploadMaterialServlet'" style="white-space: nowrap;">
            <i class="fa-solid fa-cloud-arrow-up"></i> Upload Material
        </button>
    </div>

    <!-- Table Box -->
    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>Material ID</th>
                    <th>Title</th>
                    <th>Course</th>
                    <th>Semester</th>
                    <th>Category</th>
                    <th>File Name</th>
                    <th>File Type</th>
                    <th>Uploaded Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<StudyMaterial> materialList = (ArrayList<StudyMaterial>) request.getAttribute("materialList");
            if (materialList != null && !materialList.isEmpty()) {
                for (StudyMaterial sm : materialList) {
            %>
                <tr>
                    <td><%=sm.getMaterialId()%></td>
                    <td><strong><%=sm.getTitle()%></strong></td>
                    <td><%=sm.getCourse()%></td>
                    <td><%=sm.getSemester()%></td>
                    <td>
                        <span class="info" style="padding: 4px 8px; border-radius: 6px; font-size: 11.5px; font-weight: 600;">
                            <%=sm.getCategory()%>
                        </span>
                    </td>
                    <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=sm.getFileName()%></td>
                    <td><%=sm.getFileType()%></td>
                    <td><%=sm.getUploadedDate().toString().substring(0, 16)%></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/<%=sm.getFilePath()%>" download="<%=sm.getFileName()%>">Download</a> |
                        <a href="${pageContext.request.contextPath}/UpdateMaterialServlet?id=<%=sm.getMaterialId()%>">Edit</a> |
                        <a href="${pageContext.request.contextPath}/DeleteMaterialServlet?id=<%=sm.getMaterialId()%>" 
                           onclick="return confirm('Are you sure you want to delete this material?')" 
                           class="text-danger">Delete</a>
                    </td>
                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="9">No study materials uploaded matching the criteria.</td>
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
