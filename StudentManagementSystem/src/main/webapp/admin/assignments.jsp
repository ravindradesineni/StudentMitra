<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Assignment"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>Assignments Management</h1>
            <p>Create, update and manage college assignments.</p>
        </div>
        <a href="${pageContext.request.contextPath}/DashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <div class="actions">
        <button onclick="window.location.href='${pageContext.request.contextPath}/AddAssignmentServlet'">
            <i class="fa-solid fa-plus"></i>
            Create Assignment
        </button>
    </div>

    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Subject</th>
                    <th>Description</th>
                    <th>Due Date</th>
                    <th>Reference PDF</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<Assignment> list = (ArrayList<Assignment>) request.getAttribute("assignmentList");
            if (list != null && !list.isEmpty()) {
                for (Assignment a : list) {
            %>
            <tr>
                <td><%=a.getAssignmentId()%></td>
                <td><strong><%=a.getTitle()%></strong></td>
                <td><%=a.getSubject()%></td>
                <td style="max-width: 300px; white-space: normal; word-wrap: break-word;"><%=a.getDescription()%></td>
                <td><%=a.getDueDate()%></td>
                <td>
                    <% if (a.getPdfPath() != null && !a.getPdfPath().isEmpty()) { %>
                        <a href="${pageContext.request.contextPath}/<%=a.getPdfPath()%>" target="_blank" style="color: var(--color-primary); font-weight: 600;">
                            <i class="fa-solid fa-file-pdf"></i> View PDF
                        </a>
                    <% } else { %>
                        <span style="color: var(--text-muted);">None</span>
                    <% } %>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/UpdateAssignmentServlet?id=<%=a.getAssignmentId()%>">Edit</a> |
                    <a href="${pageContext.request.contextPath}/DeleteAssignmentServlet?id=<%=a.getAssignmentId()%>"
                       onclick="return confirm('Are you sure you want to delete this assignment?')">Delete</a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7">No Assignments Created</td>
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
