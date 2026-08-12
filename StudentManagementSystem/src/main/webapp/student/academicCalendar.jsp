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
    <style>
        .details-btn {
            background-color: var(--color-primary-light);
            color: var(--color-primary);
            border: 1px solid var(--color-primary);
            padding: 6px 12px;
            font-size: 12.5px;
            border-radius: var(--border-radius-sm);
            cursor: pointer;
            font-weight: 500;
            transition: var(--transition-smooth);
        }
        .details-btn:hover {
            background-color: var(--color-primary);
            color: var(--text-light);
        }
        /* Modal Styling */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            align-items: center;
            justify-content: center;
        }
        .modal-content {
            background-color: var(--bg-card);
            border-radius: var(--border-radius);
            padding: 30px;
            border: 1px solid var(--border-color);
            width: 90%;
            max-width: 500px;
            box-shadow: var(--shadow-hover);
            position: relative;
            animation: slideDown 0.3s ease-out;
        }
        @keyframes slideDown {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        .close-btn {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 24px;
            color: var(--text-muted);
            cursor: pointer;
            transition: var(--transition-smooth);
        }
        .close-btn:hover {
            color: var(--text-main);
        }
        .modal-title {
            font-size: 20px;
            color: var(--color-primary);
            font-weight: 600;
            margin-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 10px;
        }
        .modal-field {
            margin-bottom: 12px;
            font-size: 14px;
        }
        .modal-field strong {
            color: var(--text-main);
            display: inline-block;
            width: 120px;
        }
    </style>
</head>
<body>

<div class="sidebar student-sidebar">
    <h2>StudentMitra</h2>
    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/StudentDashboardServlet">
                <i class="fa-solid fa-house"></i>
                Dashboard
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentProfileServlet">
                <i class="fa-solid fa-user"></i>
                My Profile
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentCoursesServlet">
                <i class="fa-solid fa-book"></i>
                My Courses
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentAttendanceServlet">
                <i class="fa-solid fa-calendar-check"></i>
                Attendance
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentMarksServlet">
                <i class="fa-solid fa-marker"></i>
                Marks
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentAnnouncementsServlet">
                <i class="fa-solid fa-bullhorn"></i>
                Announcements
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/ChangePasswordServlet">
                <i class="fa-solid fa-key"></i>
                Change Password
            </a>
        </li>
        <li class="active">
            <a href="${pageContext.request.contextPath}/StudentAcademicCalendarServlet">
                <i class="fa-solid fa-calendar-days"></i>
                Academic Calendar
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/StudentStudyMaterialsServlet">
                <i class="fa-solid fa-file-pdf"></i>
                Study Materials
            </a>
        </li>
    </ul>
</div>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>Academic Calendar</h1>
            <p>View upcoming schedules, exam dates, and academic milestones.</p>
        </div>
        <a href="${pageContext.request.contextPath}/StudentDashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <!-- Actions & Filters -->
    <div class="actions" style="flex-wrap: wrap; gap: 15px; justify-content: space-between;">
        <form action="${pageContext.request.contextPath}/StudentAcademicCalendarServlet" method="get" style="display: flex; gap: 10px; flex-grow: 1; max-width: 100%; flex-wrap: wrap;">
            <input type="text" name="search" placeholder="Search events..." value="<%=request.getAttribute("search")%>" style="width: 25%; min-width: 150px;">
            
            <select name="type" style="width: 20%; min-width: 150px;">
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

            <div style="display: flex; align-items: center; gap: 8px; margin-right: 10px; background-color: var(--bg-card); border: 1px solid var(--border-color); border-radius: var(--border-radius-sm); padding: 0 12px; font-size: 14px;">
                <input type="checkbox" id="upcomingOnly" name="upcomingOnly" value="true" <%=(Boolean)request.getAttribute("upcomingOnly") ? "checked" : ""%> style="cursor: pointer; width: auto; margin-right: 4px;">
                <label for="upcomingOnly" style="margin-bottom: 0; cursor: pointer; font-weight: 500; font-size: 13.5px; color: var(--text-muted);">Upcoming Only</label>
            </div>

            <button type="submit">
                <i class="fa-solid fa-magnifying-glass"></i> Search & Filter
            </button>
        </form>
    </div>

    <!-- Calendar Table -->
    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>Event Title</th>
                    <th>Event Type</th>
                    <th>Event Date</th>
                    <th>Event Time</th>
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
                    
                    String descEscaped = event.getDescription() != null ? event.getDescription().replace("\"", "\\\"").replace("\n", " ") : "";
            %>
                <tr>
                    <td><strong><%=event.getTitle()%></strong></td>
                    <td>
                        <span class="info" style="padding: 4px 8px; border-radius: 6px; font-size: 11.5px; font-weight: 500;">
                            <%=event.getEventType()%>
                        </span>
                    </td>
                    <td><%=event.getEventDate()%></td>
                    <td><%=event.getEventTime() != null ? event.getEventTime().toString().substring(0, 5) : "--:--"%></td>
                    <td>
                        <span class="<%=statusClass%>" style="padding: 4px 8px; border-radius: 6px; font-size: 11.5px; font-weight: 600; display: inline-block;">
                            <%=event.getStatus()%>
                        </span>
                    </td>
                    <td>
                        <button class="details-btn" onclick="showEventDetails('<%=event.getTitle().replace("'", "\\'")%>', '<%=event.getEventType()%>', '<%=event.getEventDate()%>', '<%=event.getEventTime() != null ? event.getEventTime().toString().substring(0, 5) : ""%>', '<%=event.getStatus()%>', '<%=descEscaped.replace("'", "\\'")%>')">
                            <i class="fa-solid fa-eye"></i> View Details
                        </button>
                    </td>
                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="6">No Academic Events scheduled matching the criteria.</td>
                </tr>
            <%
            }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Event Details Modal -->
<div id="detailsModal" class="modal" onclick="closeModalOutside(event)">
    <div class="modal-content">
        <span class="close-btn" onclick="closeEventDetails()">&times;</span>
        <div class="modal-title" id="modalTitle">Event Title</div>
        
        <div class="modal-field">
            <strong>Event Type:</strong>
            <span id="modalType">Exam</span>
        </div>
        <div class="modal-field">
            <strong>Date:</strong>
            <span id="modalDate">2026-07-20</span>
        </div>
        <div class="modal-field">
            <strong>Time:</strong>
            <span id="modalTime">10:00</span>
        </div>
        <div class="modal-field">
            <strong>Status:</strong>
            <span id="modalStatus" style="font-weight: 600; padding: 2px 6px; border-radius: 4px;">Upcoming</span>
        </div>
        <div class="modal-field" style="margin-top: 15px;">
            <strong>Description:</strong>
            <div id="modalDesc" style="margin-top: 5px; color: var(--text-muted); line-height: 1.6; white-space: pre-wrap;">-</div>
        </div>
    </div>
</div>

<script>
function showEventDetails(title, type, date, time, status, desc) {
    document.getElementById("modalTitle").innerText = title;
    document.getElementById("modalType").innerText = type;
    document.getElementById("modalDate").innerText = date;
    document.getElementById("modalTime").innerText = time ? time : "N/A";
    
    var statusEl = document.getElementById("modalStatus");
    statusEl.innerText = status;
    
    // Apply styling based on status
    statusEl.className = ""; // clear
    if (status === "Upcoming") {
        statusEl.style.backgroundColor = "var(--color-warning-bg)";
        statusEl.style.color = "var(--color-warning-text)";
    } else if (status === "Completed") {
        statusEl.style.backgroundColor = "var(--color-success-bg)";
        statusEl.style.color = "var(--color-success-text)";
    } else {
        statusEl.style.backgroundColor = "var(--color-error-bg)";
        statusEl.style.color = "var(--color-error-text)";
    }

    document.getElementById("modalDesc").innerText = desc ? desc : "No description provided.";
    document.getElementById("detailsModal").style.display = "flex";
}

function closeEventDetails() {
    document.getElementById("detailsModal").style.display = "none";
}

function closeModalOutside(e) {
    if (e.target.id === "detailsModal") {
        closeEventDetails();
    }
}
</script>

<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
</body>
</html>
