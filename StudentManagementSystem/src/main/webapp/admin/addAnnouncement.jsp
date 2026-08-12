<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Announcements | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addStudent.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="page-title">
        <h1>Post Announcement</h1>
        <p>Enter the announcement title and details below.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <p style="color: red; margin-bottom: 15px;"><%=request.getAttribute("error")%></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/AddAnnouncementServlet" method="post">
            <div class="row">
                <div class="input-group full-width">
                    <label>Announcement Title</label>
                    <input type="text" name="title" placeholder="e.g. Midterm Exam Schedule" required>
                </div>
            </div>

            <div class="row">
                <div class="input-group full-width">
                    <label>Description Details</label>
                    <textarea name="description" placeholder="Write full description here..." required style="width: 100%; height: 160px; padding: 12px; border-radius: 8px; border: 1px solid #ccc; font-family: inherit; resize: vertical;"></textarea>
                </div>
            </div>

            <button type="submit">
                <i class="fa-solid fa-paper-plane"></i>
                Post Notice
            </button>
        </form>
    </div>
</div>

</body>
</html>
