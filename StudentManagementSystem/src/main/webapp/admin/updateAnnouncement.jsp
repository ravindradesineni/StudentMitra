<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.Announcement"%>
<%
Announcement announcement = (Announcement) request.getAttribute("announcement");
%>
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
        <h1>Edit Announcement</h1>
        <p>Modify the announcement details below.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <p style="color: red; margin-bottom: 15px;"><%=request.getAttribute("error")%></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/UpdateAnnouncementSaveServlet" method="post">
            <input type="hidden" name="announcementId" value="<%=announcement.getAnnouncementId()%>">

            <div class="row">
                <div class="input-group full-width">
                    <label>Announcement Title</label>
                    <input type="text" name="title" value="<%=announcement.getTitle()%>" required>
                </div>
            </div>

            <div class="row">
                <div class="input-group full-width">
                    <label>Description Details</label>
                    <textarea name="description" required style="width: 100%; height: 160px; padding: 12px; border-radius: 8px; border: 1px solid #ccc; font-family: inherit; resize: vertical;"><%=announcement.getDescription()%></textarea>
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
