<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Event"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Calendar | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>Academic Calendar</h1>
            <p>Schedule, filter, and track college events and exams.</p>
        </div>
        <a href="${pageContext.request.contextPath}/DashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <!-- Actions & Filtering bar -->
    <div class="actions" style="flex-wrap: wrap; gap: 15px; justify-content: space-between;">
        <form action="${pageContext.request.contextPath}/AcademicCalendarServlet" method="get" style="display: flex; gap: 10px; flex-grow: 1; max-width: 80%;">
            <input type="text" name="search" placeholder="Search events..." value="<%=request.getAttribute("search")%>" style="width: 30%; min-width: 150px;">
            
            <select name="type" style="width: 25%; min-width: 150px;">
                <option value="All" <%="All".equals(request.getAttribute("type")) ? "selected" : ""%>>All Event Types</option>
                <option value="Internal Exam" <%="Internal Exam".equals(request.getAttribute("type")) ? "selected" : ""%>>Internal Exam</option>
                <option value="Semester Exam" <%="Semester Exam".equals(request.getAttribute("type")) ? "selected" : ""%>>Semester Exam</option>
                <option value="Assignment Submission" <%="Assignment Submission".equals(request.getAttribute("type")) ? "selected" : ""%>>Assignment Submission</option>
                <option value="Holiday" <%="Holiday".equals(request.getAttribute("type")) ? "selected" : ""%>>Holiday</option>
                <option value="Workshop" <%="Workshop".equals(request.getAttribute("type")) ? "selected" : ""%>>Workshop</option>
                <option value="Seminar" <%="Seminar".equals(request.getAttribute("type")) ? "selected" : ""%>>Seminar</option>
                <option value="Placement Drive" <%="Placement Drive".equals(request.getAttribute("type")) ? "selected" : ""%>>Placement Drive</option>
                <option value="Cultural Event" <%="Cultural Event".equals(request.getAttribute("type")) ? "selected" : ""%>>Cultural Event</option>
                <option value="Sports Event" <%="Sports Event".equals(request.getAttribute("type")) ? "selected" : ""%>>Sports Event</option>
                <option value="Meeting" <%="Meeting".equals(request.getAttribute("type")) ? "selected" : ""%>>Meeting</option>
                <option value="Other" <%="Other".equals(request.getAttribute("type")) ? "selected" : ""%>>Other</option>
            </select>

            <select name="sort" style="width: 25%; min-width: 150px;">
                <option value="ASC" <%="ASC".equals(request.getAttribute("sort")) ? "selected" : ""%>>Date: Chronological</option>
                <option value="DESC" <%="DESC".equals(request.getAttribute("sort")) ? "selected" : ""%>>Date: Reverse Chronological</option>
            </select>

            <button type="submit">
                <i class="fa-solid fa-filter"></i> Apply
            </button>
        </form>

        <button onclick="window.location.href='${pageContext.request.contextPath}/AddEventServlet'" style="white-space: nowrap;">
            <i class="fa-solid fa-plus"></i> Add Event
        </button>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%=request.getAttribute("error")%></div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
        <div class="success"><%=request.getAttribute("success")%></div>
    <% } %>

    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>Event ID</th>
                    <th>Event Title</th>
                    <th>Event Type</th>
                    <th>Event Date</th>
                    <th>Event Time</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<Event> eventList = (ArrayList<Event>) request.getAttribute("eventList");
            if (eventList != null && !eventList.isEmpty()) {
                for (Event event : eventList) {
                    String statusClass = "";
                    if ("Upcoming".equalsIgnoreCase(event.getStatus())) {
                        statusClass = "alert-warning";
                    } else if ("Completed".equalsIgnoreCase(event.getStatus())) {
                        statusClass = "alert-success";
                    } else if ("Cancelled".equalsIgnoreCase(event.getStatus())) {
                        statusClass = "alert-danger";
                    }
            %>
                <tr>
                    <td><%=event.getEventId()%></td>
                    <td><strong><%=event.getTitle()%></strong></td>
                    <td>
                        <span class="info" style="padding: 4px 8px; border-radius: 6px; font-size: 11.5px; font-weight: 500;">
                            <%=event.getEventType()%>
                        </span>
                    </td>
                    <td><%=event.getEventDate()%></td>
                    <td><%=event.getEventTime() != null ? event.getEventTime().toString().substring(0, 5) : "--:--"%></td>
                    <td style="max-width: 250px; text-align: left; white-space: normal; word-wrap: break-word;"><%=event.getDescription() != null ? event.getDescription() : ""%></td>
                    <td>
                        <span class="<%=statusClass%>" style="padding: 4px 8px; border-radius: 6px; font-size: 11.5px; font-weight: 600; display: inline-block;">
                            <%=event.getStatus()%>
                        </span>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/UpdateEventServlet?id=<%=event.getEventId()%>">Edit</a> |
                        <a href="${pageContext.request.contextPath}/DeleteEventServlet?id=<%=event.getEventId()%>" 
                           onclick="return confirm('Are you sure you want to delete this event?')" 
                           class="text-danger">Delete</a>
                    </td>
                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="8">No Academic Events Scheduled.</td>
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
