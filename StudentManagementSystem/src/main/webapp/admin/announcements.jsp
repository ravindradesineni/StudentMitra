<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Announcement"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Announcements | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>Announcements Management</h1>
            <p>Post and update college-wide announcements and notices.</p>
        </div>
        <a href="${pageContext.request.contextPath}/DashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <div class="actions">
        <button onclick="window.location.href='${pageContext.request.contextPath}/AddAnnouncementServlet'">
            <i class="fa-solid fa-plus"></i>
            Post Announcement
        </button>
    </div>

    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Posted Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<Announcement> list = (ArrayList<Announcement>) request.getAttribute("announcementList");
            if (list != null && !list.isEmpty()) {
                for (Announcement a : list) {
            %>
            <tr>
                <td><%=a.getAnnouncementId()%></td>
                <td><strong><%=a.getTitle()%></strong></td>
                <td style="max-width: 400px; white-space: normal; word-wrap: break-word;"><%=a.getDescription()%></td>
                <td><%=a.getPostedDate()%></td>
                <td>
                    <a href="${pageContext.request.contextPath}/UpdateAnnouncementServlet?id=<%=a.getAnnouncementId()%>">Edit</a> |
                    <a href="${pageContext.request.contextPath}/DeleteAnnouncementServlet?id=<%=a.getAnnouncementId()%>"
                       onclick="return confirm('Are you sure you want to delete this announcement?')">Delete</a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5">No Announcements Posted</td>
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
