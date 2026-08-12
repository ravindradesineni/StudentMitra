<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.Submission"%>
<%
    Submission sub = (Submission) request.getAttribute("submission");
    String status = sub.getStatus();
    String badgeClass = "status-pending";
    String statusText = "Pending";
    String iconClass = "fa-clock";
    
    if ("Submitted".equalsIgnoreCase(status)) {
        badgeClass = "status-submitted";
        statusText = "Submitted";
        iconClass = "fa-circle-check";
    } else if ("Late Submission".equalsIgnoreCase(status)) {
        badgeClass = "status-late";
        statusText = "Late Submission";
        iconClass = "fa-hourglass-half";
    } else if ("Graded".equalsIgnoreCase(status)) {
        badgeClass = "status-graded";
        statusText = "Graded";
        iconClass = "fa-award";
    } else if ("Expired".equalsIgnoreCase(status)) {
        badgeClass = "status-expired";
        statusText = "Expired";
        iconClass = "fa-calendar-times";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <style>
        .status-badge {
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
        }
        .status-pending { background-color: #fef3c7; color: #d97706; }
        .status-submitted { background-color: #ecfdf5; color: #059669; }
        .status-late { background-color: #fff7ed; color: #ea580c; }
        .status-graded { background-color: #eff6ff; color: #2563eb; }
        .status-expired { background-color: #fef2f2; color: #dc2626; }

        .submission-card {
            background: white;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            padding: 35px;
            margin-bottom: 30px;
        }
        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        .detail-item h3 {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--text-muted);
            margin-bottom: 6px;
        }
        .detail-item p {
            font-size: 16px;
            font-weight: 500;
            color: var(--text-main);
        }
        .grade-form-section {
            background: #fdfdfd;
            border-top: 1px solid var(--border-color);
            padding-top: 30px;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>Submission Details</h1>
            <p>Review student details, view the uploaded document, and enter grades/feedback.</p>
        </div>
        <a href="AssignmentSubmissionsServlet" class="logout" style="background-color: var(--color-primary-hover);">
            <i class="fa-solid fa-arrow-left"></i>
            Back to List
        </a>
    </div>

    <!-- Notifications -->
    <% if (session.getAttribute("success") != null) { %>
        <div class="success-message">
            <i class="fa-solid fa-circle-check"></i> <%= session.getAttribute("success") %>
        </div>
        <% session.removeAttribute("success"); %>
    <% } %>
    <% if (session.getAttribute("error") != null) { %>
        <div class="error-message">
            <i class="fa-solid fa-circle-exclamation"></i> <%= session.getAttribute("error") %>
        </div>
        <% session.removeAttribute("error"); %>
    <% } %>

    <div class="submission-card">
        <!-- Status Header -->
        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border-color); padding-bottom: 20px; margin-bottom: 25px;">
            <h2 style="font-size: 22px; font-weight: 600;"><%= sub.getAssignmentTitle() %></h2>
            <span class="status-badge <%= badgeClass %>"><i class="fa-solid <%= iconClass %>" style="margin-right: 5px;"></i><%= statusText %></span>
        </div>

        <!-- Details Grid -->
        <div class="details-grid">
            <div class="detail-item">
                <h3>Subject</h3>
                <p><%= sub.getSubject() %></p>
            </div>
            <div class="detail-item">
                <h3>Due Date</h3>
                <p><%= sub.getDueDate() %></p>
            </div>
            <div class="detail-item">
                <h3>Student Name</h3>
                <p><%= sub.getStudentName() %> (ID: <%= sub.getStudentId() %>)</p>
            </div>
            <div class="detail-item">
                <h3>Department</h3>
                <p><%= sub.getDepartment() %></p>
            </div>
            <div class="detail-item">
                <h3>Student Email</h3>
                <p><%= sub.getStudentEmail() %></p>
            </div>
            <div class="detail-item">
                <h3>Submission Date</h3>
                <p><%= sub.getSubmissionDate() != null ? sub.getSubmissionDate() : "N/A" %></p>
            </div>
        </div>

        <!-- File Section -->
        <div style="background: var(--bg-base); padding: 20px; border-radius: 8px; border: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
            <div style="display: flex; align-items: center; gap: 15px;">
                <i class="fa-solid fa-file-pdf" style="font-size: 32px; color: #dc2626;"></i>
                <div>
                    <h4 style="margin: 0; font-size: 15px; font-weight: 600;"><%= sub.getFileName() != null ? sub.getFileName() : "No submission file" %></h4>
                    <p style="margin: 0; font-size: 13px; color: var(--text-muted);">
                        <%= sub.getSubmissionId() > 0 ? "Uploaded File (PDF/DOC/DOCX)" : "The student has not submitted this assignment yet." %>
                    </p>
                </div>
            </div>
            <% if (sub.getSubmissionId() > 0) { %>
                <a href="${pageContext.request.contextPath}/<%= sub.getFilePath() %>" target="_blank" class="btn" style="background-color: #2563eb; border-color: #2563eb;">
                    <i class="fa-solid fa-download"></i> Download Submission
                </a>
            <% } else { %>
                <button class="btn btn-secondary" disabled style="opacity: 0.6; cursor: not-allowed;">
                    <i class="fa-solid fa-ban"></i> Download Unavailable
                </button>
            <% } %>
        </div>

        <!-- Grading Section -->
        <% if (sub.getSubmissionId() > 0) { %>
            <div class="grade-form-section" id="grade-form">
                <h3 style="font-size: 18px; font-weight: 600; margin-bottom: 20px;">
                    <i class="fa-solid fa-marker" style="margin-right: 8px; color: var(--color-accent);"></i>
                    Grade Assignment
                </h3>
                
                <form action="GradeSubmissionServlet" method="post" style="max-width: 600px;">
                    <input type="hidden" name="submissionId" value="<%= sub.getSubmissionId() %>">
                    
                    <div class="form-group">
                        <label for="marks">Marks / Score</label>
                        <input type="number" name="marks" id="marks" placeholder="Enter Score (e.g. 85)" required min="0" max="100" value="<%= sub.getMarks() != null ? sub.getMarks() : "" %>">
                    </div>

                    <div class="form-group">
                        <label for="feedback">Feedback & Comments</label>
                        <textarea name="feedback" id="feedback" rows="5" placeholder="Enter feedback for the student..." required><%= sub.getFeedback() != null ? sub.getFeedback() : "" %></textarea>
                    </div>

                    <% if ("Graded".equalsIgnoreCase(status) && sub.getGradedOn() != null) { %>
                        <div style="font-size: 13px; color: var(--text-muted); margin-bottom: 20px; font-style: italic;">
                            <i class="fa-solid fa-clock"></i> Graded on: <%= sub.getGradedOn() %>
                        </div>
                    <% } %>

                    <button type="submit">
                        <i class="fa-solid fa-circle-check"></i> Save Grades & Feedback
                    </button>
                </form>
            </div>
        <% } %>
    </div>
</div>

</body>
</html>
