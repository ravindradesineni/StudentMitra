<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addStudent.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="page-title">
        <h1>Create Assignment</h1>
        <p>Fill out the assignment guidelines and attach optional PDF material.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <div style="background-color: var(--color-error-bg, #fde8e8); color: var(--color-error-text, #e53e3e); padding: 12px 15px; border-radius: 8px; margin-bottom: 20px; font-weight: 500;">
                <i class="fa-solid fa-triangle-exclamation" style="margin-right: 5px;"></i> <%=request.getAttribute("error")%>
            </div>
        <% } %>
        <form action="${pageContext.request.contextPath}/AddAssignmentServlet" method="post" enctype="multipart/form-data">
            <div class="row">
                <div class="input-group">
                    <label>Assignment Title</label>
                    <input type="text" name="title" placeholder="e.g. Database Design Lab" required>
                </div>
                <div class="input-group">
                    <label>Subject / Course</label>
                    <input type="text" name="subject" placeholder="e.g. DBMS" required>
                </div>
            </div>

            <div class="row">
                <div class="input-group">
                    <label>Due Date</label>
                    <input type="date" name="dueDate" required>
                </div>
                <div class="input-group">
                    <label>Attach Assignment PDF (Optional)</label>
                    <input type="file" name="pdfFile" accept=".pdf" style="padding: 10px; border: 1px dashed var(--border-color, #ccc); border-radius: 8px;">
                </div>
            </div>

            <div class="row">
                <div class="input-group full-width">
                    <label>Assignment Description</label>
                    <textarea name="description" placeholder="Provide full details, guidelines and grading rubrics..." required style="width: 100%; height: 160px; padding: 12px; border-radius: 8px; border: 1px solid #ccc; font-family: inherit; resize: vertical;"></textarea>
                </div>
            </div>

            <button type="submit">
                <i class="fa-solid fa-square-plus"></i>
                Create Assignment
            </button>
        </form>
    </div>
</div>

</body>
</html>
