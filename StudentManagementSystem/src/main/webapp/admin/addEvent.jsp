<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Calendar | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addStudent.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="page-title">
        <h1>Add Calendar Event</h1>
        <p>Schedule a new academic or co-curricular event.</p>
    </div>

    <div class="form-container">
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message" style="margin-bottom: 20px;">
                <i class="fa-solid fa-triangle-exclamation"></i> <%=request.getAttribute("error")%>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/AddEventServlet" method="post" onsubmit="return validateForm()">
            <!-- Title -->
            <div class="row">
                <div class="input-group full-width">
                    <label>Event Title</label>
                    <input type="text" name="title" id="title" placeholder="e.g. Midterm Physics Exam" required>
                </div>
            </div>

            <!-- Event Type & Status -->
            <div class="row">
                <div class="input-group">
                    <label>Event Type</label>
                    <select name="eventType" id="eventType" required>
                        <option value="">-- Select Event Type --</option>
                        <option value="Internal Exam">Internal Exam</option>
                        <option value="Semester Exam">Semester Exam</option>
                        <option value="Assignment Submission">Assignment Submission</option>
                        <option value="Holiday">Holiday</option>
                        <option value="Workshop">Workshop</option>
                        <option value="Seminar">Seminar</option>
                        <option value="Placement Drive">Placement Drive</option>
                        <option value="Cultural Event">Cultural Event</option>
                        <option value="Sports Event">Sports Event</option>
                        <option value="Meeting">Meeting</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="input-group">
                    <label>Status</label>
                    <select name="status" id="status" required>
                        <option value="Upcoming" selected>Upcoming</option>
                        <option value="Completed">Completed</option>
                        <option value="Cancelled">Cancelled</option>
                    </select>
                </div>
            </div>

            <!-- Date & Time -->
            <div class="row">
                <div class="input-group">
                    <label>Event Date</label>
                    <input type="date" name="eventDate" id="eventDate" required>
                </div>

                <div class="input-group">
                    <label>Event Time</label>
                    <input type="time" name="eventTime" id="eventTime" required>
                </div>
            </div>

            <!-- Description -->
            <div class="row">
                <div class="input-group full-width">
                    <label>Description</label>
                    <textarea name="description" id="description" rows="4" placeholder="Enter event details/description..." style="width: 100%; border: 1px solid var(--border-color); border-radius: var(--border-radius-sm); padding: 12px; font-size: 14px; outline: none; transition: var(--transition-smooth);"></textarea>
                </div>
            </div>

            <!-- Form Actions -->
            <div style="display: flex; gap: 15px; margin-top: 10px;">
                <button type="submit">
                    <i class="fa-solid fa-floppy-disk"></i> Save Event
                </button>
                <a href="${pageContext.request.contextPath}/AcademicCalendarServlet" class="btn btn-secondary" style="line-height: normal; text-align: center;">
                    Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<script>
function validateForm() {
    var title = document.getElementById("title").value.trim();
    var eventType = document.getElementById("eventType").value;
    var eventDate = document.getElementById("eventDate").value;
    var eventTime = document.getElementById("eventTime").value;

    if (title === "") {
        alert("Please enter an event title.");
        return false;
    }
    if (eventType === "") {
        alert("Please select an event type.");
        return false;
    }
    if (eventDate === "") {
        alert("Please select an event date.");
        return false;
    }
    if (eventTime === "") {
        alert("Please select an event time.");
        return false;
    }
    return true;
}
</script>

</body>
</html>
