<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.sms.model.Assignment"%>
<%@ page import="com.sms.model.Submission"%>
<%@ page import="com.sms.model.Student"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<%
Student student = (Student) session.getAttribute("student");
ArrayList<Assignment> assignments = (ArrayList<Assignment>) request.getAttribute("assignmentList");
Map<Integer, Submission> submissionMap = (Map<Integer, Submission>) request.getAttribute("submissionMap");
LocalDate today = LocalDate.now();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentDashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <style>
        .status-badge {
            padding: 6px 12px;
            border-radius: var(--border-radius-sm, 6px);
            font-weight: 600;
            font-size: 12px;
            display: inline-block;
        }
        .status-pending {
            background-color: #fef3c7;
            color: #d97706;
        }
        .status-submitted {
            background-color: #d1fae5;
            color: #059669;
        }
        .status-late {
            background-color: #fee2e2;
            color: #dc2626;
        }
        .status-expired {
            background-color: #f3f4f6;
            color: #4b5563;
        }
        .upload-form {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
        }
        .file-input-wrapper input[type=file] {
            font-size: 100px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
        }
        .btn-upload-select {
            border: 1px dashed var(--color-primary, #56ab2f);
            background-color: white;
            color: var(--color-primary, #56ab2f);
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .btn-submit-file {
            background: var(--color-primary, #56ab2f);
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .btn-submit-file:hover {
            opacity: 0.9;
        }
        .file-name-display {
            font-size: 12px;
            color: var(--text-muted, #666);
            max-width: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</head>
<body>

<div class="sidebar student-sidebar">
    <h2>StudentMitra</h2>
    <div style="text-align: center; padding: 20px 10px; border-bottom: 1px solid rgba(255,255,255,0.1); margin-bottom: 15px;">
        <% if (student.getProfilePhoto() != null && !student.getProfilePhoto().isEmpty()) { %>
            <img src="${pageContext.request.contextPath}/<%=student.getProfilePhoto()%>" style="width: 75px; height: 75px; border-radius: 50%; object-fit: cover; border: 2px solid #56ab2f; margin-bottom: 5px;" alt="Avatar">
        <% } else { %>
            <img src="${pageContext.request.contextPath}/uploads/students/default-avatar.png" style="width: 75px; height: 75px; border-radius: 50%; object-fit: cover; border: 2px solid #56ab2f; margin-bottom: 5px;" alt="Avatar">
        <% } %>
        <h3 style="color: #fff; font-size: 14px; margin-top: 5px; font-weight: 600; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"><%=student.getFullName()%></h3>
        <p style="color: rgba(255,255,255,0.6); font-size: 11px;">ID: <%=student.getStudentId()%></p>
    </div>
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
        <li class="active">
            <a href="${pageContext.request.contextPath}/StudentAssignmentsServlet">
                <i class="fa-solid fa-pen-to-square"></i>
                Assignments
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
        <li>
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
            <h1>My Assignments</h1>
            <p>View assignments, reference materials, track remaining days, and upload submissions.</p>
        </div>
        <a href="${pageContext.request.contextPath}/StudentDashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <!-- Alerts from submission redirect -->
    <% if (session.getAttribute("success") != null) { %>
        <div class="success-message" style="margin-bottom: 20px;">
            <i class="fa-solid fa-circle-check"></i> <%=session.getAttribute("success")%>
        </div>
        <% session.removeAttribute("success"); %>
    <% } %>
    <% if (session.getAttribute("error") != null) { %>
        <div class="error-message" style="margin-bottom: 20px;">
            <i class="fa-solid fa-triangle-exclamation"></i> <%=session.getAttribute("error")%>
        </div>
        <% session.removeAttribute("error"); %>
    <% } %>

    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>Title & Subject</th>
                    <th>Guidelines</th>
                    <th>Reference</th>
                    <th>Due Date</th>
                    <th>Remaining Days</th>
                    <th>Status</th>
                    <th style="width: 300px;">Submission Action</th>
                </tr>
            </thead>
            <tbody>
            <%
            if (assignments != null && !assignments.isEmpty()) {
                for (Assignment a : assignments) {
                    // 1. Calculate Remaining Days
                    LocalDate dueDate = LocalDate.parse(a.getDueDate());
                    long daysBetween = ChronoUnit.DAYS.between(today, dueDate);
                    String remainingStr = "";
                    if (daysBetween > 0) {
                        remainingStr = daysBetween + " Days";
                    } else if (daysBetween == 0) {
                        remainingStr = "Today";
                    } else {
                        remainingStr = "Expired";
                    }

                    // 2. Determine Submission Status & Submission Object
                    Submission sub = submissionMap != null ? submissionMap.get(a.getAssignmentId()) : null;
                    String statusLabel = "Pending";
                    String badgeClass = "status-pending";
                    boolean isSubmitted = false;

                    if (sub != null) {
                        isSubmitted = true;
                        if ("Late Submission".equalsIgnoreCase(sub.getStatus())) {
                            statusLabel = "Late Submission";
                            badgeClass = "status-late";
                        } else {
                            statusLabel = "Submitted";
                            badgeClass = "status-submitted";
                        }
                    } else {
                        if (today.isAfter(dueDate)) {
                            statusLabel = "Expired";
                            badgeClass = "status-expired";
                        }
                    }
            %>
            <tr>
                <td>
                    <strong><%=a.getTitle()%></strong><br>
                    <span style="font-size: 12px; color: #56ab2f; font-weight: 500;"><%=a.getSubject()%></span>
                </td>
                <td style="max-width: 220px; white-space: normal; word-wrap: break-word; font-size: 13px;"><%=a.getDescription()%></td>
                <td>
                    <% if (a.getPdfPath() != null && !a.getPdfPath().isEmpty()) { %>
                        <a href="${pageContext.request.contextPath}/<%=a.getPdfPath()%>" target="_blank" style="color: #2196F3; font-weight: 600; font-size: 13px;">
                            <i class="fa-solid fa-file-pdf"></i> Guidelines.pdf
                        </a>
                    <% } else { %>
                        <span style="color: var(--text-muted); font-size: 13px;">None</span>
                    <% } %>
                </td>
                <td><%=a.getDueDate()%></td>
                <td>
                    <span style="font-weight: 600; color: <%=daysBetween < 0 ? "#dc2626" : (daysBetween <= 2 ? "#d97706" : "#222")%>;"><%=remainingStr%></span>
                </td>
                <td>
                    <span class="status-badge <%=badgeClass%>"><%=statusLabel%></span>
                </td>
                <td>
                    <% if ("Expired".equalsIgnoreCase(statusLabel)) { %>
                        <button class="btn btn-secondary" disabled style="width: 100%; opacity: 0.6; cursor: not-allowed; padding: 10px 15px; border-radius: 6px;">
                            <i class="fa-solid fa-ban"></i> Assignment Expired
                        </button>
                    <% } else if (isSubmitted) { %>
                        <div style="color: #059669; font-weight: 600; font-size: 13.5px; display: inline-flex; align-items: center; gap: 6px; padding: 8px 12px; background-color: #d1fae5; border-radius: 6px; border: 1px solid #a7f3d0; box-shadow: var(--shadow-sm);">
                            <i class="fa-solid fa-circle-check"></i> Assignment Submitted Successfully
                        </div>
                    <% } else { %>
                        <form action="${pageContext.request.contextPath}/SubmitAssignmentServlet" method="post" enctype="multipart/form-data" class="upload-form" id="form-<%=a.getAssignmentId()%>">
                            <input type="hidden" name="assignmentId" value="<%=a.getAssignmentId()%>">
                            
                            <div class="file-input-wrapper">
                                <button type="button" class="btn-upload-select" id="btn-select-<%=a.getAssignmentId()%>">
                                    <i class="fa-solid fa-file-arrow-up"></i> Select File
                                </button>
                                <input type="file" name="submissionFile" accept=".pdf,.doc,.docx" required onchange="handleFileSelect(this, <%=a.getAssignmentId()%>)">
                            </div>
                            
                            <button type="submit" class="btn-submit-file">
                                Submit
                            </button>
                        </form>
                        <div id="file-name-<%=a.getAssignmentId()%>" class="file-name-display" style="margin-top: 5px;">
                            <span style="font-style: italic;">No file selected (PDF, DOC, DOCX. Max: 10MB)</span>
                        </div>
                    <% } %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7">No assignments available currently. Keep check!</td>
            </tr>
            <%
            }
            %>
            </tbody>
        </table>
    </div>
</div>

<script>
function handleFileSelect(input, assignmentId) {
    var display = document.getElementById("file-name-" + assignmentId);
    if (input.files && input.files[0]) {
        var file = input.files[0];
        var name = file.name;
        var size = file.size; // bytes
        
        // 10MB = 10 * 1024 * 1024 bytes
        var maxLimit = 10 * 1024 * 1024;
        
        if (size > maxLimit) {
            alert("File size exceeds 10 MB limit! Please choose a smaller file.");
            input.value = ""; // clear
            display.innerHTML = "<span style='color: red; font-weight: 500;'>File too large (> 10MB)</span>";
            return;
        }
        
        // Check extensions
        var allowed = ["pdf", "doc", "docx"];
        var ext = name.split('.').pop().toLowerCase();
        if (allowed.indexOf(ext) === -1) {
            alert("Invalid file type! Only PDF, DOC, and DOCX files are allowed.");
            input.value = ""; // clear
            display.innerHTML = "<span style='color: red; font-weight: 500;'>Invalid file type</span>";
            return;
        }
        
        display.innerHTML = "<span style='color: #56ab2f; font-weight: 600;'><i class='fa-solid fa-file-circle-check'></i> Selected: " + name + "</span>";
    } else {
        display.innerHTML = "<span style='font-style: italic;'>No file selected (PDF, DOC, DOCX. Max: 10MB)</span>";
    }
}
</script>
<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
</body>
</html>
