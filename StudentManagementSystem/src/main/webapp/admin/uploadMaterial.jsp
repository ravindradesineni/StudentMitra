<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Course"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Study Materials | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addStudent.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="page-title">
        <h1>Upload Study Material</h1>
        <p>Publish syllabus notes, handouts, lab manuals, or question banks.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message" style="margin-bottom: 20px;">
                <i class="fa-solid fa-triangle-exclamation"></i> <%=request.getAttribute("error")%>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/UploadMaterialServlet" method="post" enctype="multipart/form-data" onsubmit="return validateUpload()">
            <!-- Course & Semester -->
            <div class="row">
                <div class="input-group">
                    <label>Course</label>
                    <select name="course" id="course" required>
                        <option value="">-- Select Course --</option>
                        <%
                        ArrayList<Course> courseList = (ArrayList<Course>) request.getAttribute("courseList");
                        if (courseList != null) {
                            for (Course c : courseList) {
                                String val = c.getCourseCode();
                        %>
                            <option value="<%=val%>"><%=val%> - <%=c.getCourseName()%></option>
                        <%
                            }
                        }
                        %>
                    </select>
                </div>

                <div class="input-group">
                    <label>Semester</label>
                    <select name="semester" id="semester" required>
                        <option value="">-- Select Semester --</option>
                        <option value="Semester 1">Semester 1</option>
                        <option value="Semester 2">Semester 2</option>
                        <option value="Semester 3">Semester 3</option>
                        <option value="Semester 4">Semester 4</option>
                        <option value="Semester 5">Semester 5</option>
                        <option value="Semester 6">Semester 6</option>
                        <option value="Semester 7">Semester 7</option>
                        <option value="Semester 8">Semester 8</option>
                    </select>
                </div>
            </div>

            <!-- Category & Title -->
            <div class="row">
                <div class="input-group">
                    <label>Category</label>
                    <select name="category" id="category" required>
                        <option value="">-- Select Category --</option>
                        <option value="Notes">Notes</option>
                        <option value="Lab Manual">Lab Manual</option>
                        <option value="Assignment">Assignment</option>
                        <option value="Previous Question Paper">Previous Question Paper</option>
                        <option value="Presentation">Presentation</option>
                        <option value="Reference Material">Reference Material</option>
                        <option value="Syllabus">Syllabus</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="input-group">
                    <label>Material Title</label>
                    <input type="text" name="title" id="title" placeholder="e.g. Unit 3 Database Normalization Lecture" required>
                </div>
            </div>

            <!-- Description -->
            <div class="row">
                <div class="input-group full-width">
                    <label>Description</label>
                    <textarea name="description" id="description" rows="3" placeholder="Enter simple details/topics covered..." style="width: 100%; border: 1px solid var(--border-color); border-radius: var(--border-radius-sm); padding: 12px; font-size: 14px; outline: none; transition: var(--transition-smooth);"></textarea>
                </div>
            </div>

            <!-- File Input -->
            <div class="row">
                <div class="input-group full-width">
                    <label>Choose File (Max: 20 MB)</label>
                    <input type="file" name="file" id="file" accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.zip,.jpg,.jpeg,.png" required style="border: 1px solid var(--border-color); padding: 8px; width: 100%;">
                    <p style="font-size: 11.5px; color: var(--text-muted); margin-top: 5px;">
                        Supported types: PDF, DOC, DOCX, PPT, PPTX, XLS, XLSX, ZIP, JPG, JPEG, PNG.
                    </p>
                </div>
            </div>

            <!-- Buttons -->
            <div style="display: flex; gap: 15px; margin-top: 15px;">
                <button type="submit">
                    <i class="fa-solid fa-cloud-arrow-up"></i> Upload
                </button>
                <a href="${pageContext.request.contextPath}/StudyMaterialsServlet" class="btn btn-secondary" style="line-height: normal; text-align: center;">
                    Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<script>
function validateUpload() {
    var course = document.getElementById("course").value;
    var semester = document.getElementById("semester").value;
    var category = document.getElementById("category").value;
    var title = document.getElementById("title").value.trim();
    var fileInput = document.getElementById("file");

    if (course === "") {
        alert("Please select a course.");
        return false;
    }
    if (semester === "") {
        alert("Please select a semester.");
        return false;
    }
    if (category === "") {
        alert("Please select a category.");
        return false;
    }
    if (title === "") {
        alert("Please enter a title.");
        return false;
    }

    if (fileInput.files.length === 0) {
        alert("Please choose a file to upload.");
        return false;
    }

    var file = fileInput.files[0];
    
    // Validate File Size (20 MB max = 20971520 bytes)
    var maxSize = 20 * 1024 * 1024;
    if (file.size > maxSize) {
        alert("Oversized file detected! The file size must be less than 20 MB. Current file size: " + (file.size / (1024 * 1024)).toFixed(2) + " MB.");
        return false;
    }

    // Validate File Type
    var allowedExtensions = ["pdf", "doc", "docx", "ppt", "pptx", "xls", "xlsx", "zip", "jpg", "jpeg", "png"];
    var fileName = file.name;
    var fileExtension = fileName.split('.').pop().toLowerCase();
    
    if (allowedExtensions.indexOf(fileExtension) === -1) {
        alert("Invalid file type! Allowed file types are: PDF, DOC, DOCX, PPT, PPTX, XLS, XLSX, ZIP, JPG, JPEG, PNG.");
        return false;
    }

    return true;
}
</script>

</body>
</html>
