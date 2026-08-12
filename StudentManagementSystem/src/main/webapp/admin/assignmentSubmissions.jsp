<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Submission"%>
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
            padding: 5px 10px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }
        .status-pending { background-color: #fef3c7; color: #d97706; }
        .status-submitted { background-color: #ecfdf5; color: #059669; }
        .status-late { background-color: #fff7ed; color: #ea580c; }
        .status-graded { background-color: #eff6ff; color: #2563eb; }
        .status-expired { background-color: #fef2f2; color: #dc2626; }

        .search-filter-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 20px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            margin-bottom: 25px;
            gap: 15px;
            flex-wrap: wrap;
        }
        .search-filter-bar form {
            display: flex;
            align-items: center;
            gap: 15px;
            width: 100%;
            flex-wrap: wrap;
        }
        .search-input-wrapper {
            position: relative;
            flex: 1;
            min-width: 250px;
        }
        .search-input-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }
        .search-input-wrapper input {
            padding-left: 40px !important;
            width: 100%;
        }
        .filter-select {
            width: auto;
            min-width: 180px;
        }
        .btn-search {
            height: 46px;
            padding: 0 24px;
        }
        .action-link {
            font-size: 13px !important;
            padding: 6px 12px !important;
            border-radius: 4px !important;
        }
        .action-link.btn-view {
            background-color: var(--color-primary-light) !important;
            color: var(--color-primary) !important;
        }
        .action-link.btn-view:hover {
            background-color: var(--color-primary) !important;
            color: white !important;
        }
        .action-link.btn-download {
            background-color: #eff6ff !important;
            color: #2563eb !important;
        }
        .action-link.btn-download:hover {
            background-color: #2563eb !important;
            color: white !important;
        }
        .action-link.btn-grade {
            background-color: #fef3c7 !important;
            color: #d97706 !important;
        }
        .action-link.btn-grade:hover {
            background-color: #d97706 !important;
            color: white !important;
        }
        .action-link.disabled {
            background-color: #f3f4f6 !important;
            color: #9ca3af !important;
            cursor: not-allowed !important;
            pointer-events: none;
        }
    </style>
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
    <div class="top-bar">
        <div>
            <h1>Assignment Submissions</h1>
            <p>Track, evaluate, grade, and review student assignment submissions.</p>
        </div>
        <a href="${pageContext.request.contextPath}/DashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <!-- Search and Filters -->
    <div class="search-filter-bar">
        <form action="${pageContext.request.contextPath}/AssignmentSubmissionsServlet" method="get">
            <div class="search-input-wrapper">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" name="search" placeholder="Search by student, ID, title, or department..." value="<%= request.getAttribute("search") %>">
            </div>
            
            <select name="status" class="filter-select">
                <option value="All" <%= "All".equals(request.getAttribute("status")) ? "selected" : "" %>>All Statuses</option>
                <option value="Pending" <%= "Pending".equals(request.getAttribute("status")) ? "selected" : "" %>>Pending</option>
                <option value="Submitted" <%= "Submitted".equals(request.getAttribute("status")) ? "selected" : "" %>>Submitted</option>
                <option value="Late Submission" <%= "Late Submission".equals(request.getAttribute("status")) ? "selected" : "" %>>Late Submission</option>
                <option value="Graded" <%= "Graded".equals(request.getAttribute("status")) ? "selected" : "" %>>Graded</option>
                <option value="Expired" <%= "Expired".equals(request.getAttribute("status")) ? "selected" : "" %>>Expired</option>
            </select>

            <select name="sort" class="filter-select">
                <option value="" <%= "".equals(request.getAttribute("sort")) ? "selected" : "" %>>Sort By</option>
                <option value="Submission Date" <%= "Submission Date".equals(request.getAttribute("sort")) ? "selected" : "" %>>Submission Date</option>
                <option value="Due Date" <%= "Due Date".equals(request.getAttribute("sort")) ? "selected" : "" %>>Due Date</option>
                <option value="Student Name" <%= "Student Name".equals(request.getAttribute("sort")) ? "selected" : "" %>>Student Name</option>
                <option value="Assignment Title" <%= "Assignment Title".equals(request.getAttribute("sort")) ? "selected" : "" %>>Assignment Title</option>
            </select>

            <button type="submit" class="btn-search">
                <i class="fa-solid fa-filter"></i> Apply Filters
            </button>
        </form>
    </div>

    <!-- Table -->
    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>Sub. ID</th>
                    <th>Assignment Title</th>
                    <th>Subject</th>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Department</th>
                    <th>Submission Date</th>
                    <th>Due Date</th>
                    <th>Status</th>
                    <th>Marks</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
                ArrayList<Submission> submissions = (ArrayList<Submission>) request.getAttribute("submissions");
                if (submissions != null && !submissions.isEmpty()) {
                    for (Submission sub : submissions) {
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
                            statusText = "Late";
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
                <tr>
                    <td><%= sub.getSubmissionId() > 0 ? sub.getSubmissionId() : "-" %></td>
                    <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                        <strong><%= sub.getAssignmentTitle() %></strong>
                    </td>
                    <td><%= sub.getSubject() %></td>
                    <td><%= sub.getStudentId() %></td>
                    <td><%= sub.getStudentName() %></td>
                    <td><%= sub.getDepartment() %></td>
                    <td><%= sub.getSubmissionDate() != null ? sub.getSubmissionDate() : "-" %></td>
                    <td><%= sub.getDueDate() %></td>
                    <td><span class="status-badge <%= badgeClass %>"><i class="fa-solid <%= iconClass %>" style="margin-right: 5px;"></i><%= statusText %></span></td>
                    <td>
                        <strong>
                        <%= sub.getMarks() != null ? sub.getMarks() + " Marks" : "-" %>
                        </strong>
                    </td>
                    <td>
                        <div style="display: flex; gap: 5px; justify-content: center;">
                            <% if (sub.getSubmissionId() > 0) { %>
                                <a href="ViewSubmissionServlet?submissionId=<%= sub.getSubmissionId() %>" class="action-link btn-view">
                                    <i class="fa-solid fa-eye"></i> View
                                </a>
                                <a href="${pageContext.request.contextPath}/<%= sub.getFilePath() %>" target="_blank" class="action-link btn-download">
                                    <i class="fa-solid fa-download"></i> Download
                                </a>
                                <a href="ViewSubmissionServlet?submissionId=<%= sub.getSubmissionId() %>#grade-form" class="action-link btn-grade">
                                    <i class="fa-solid fa-marker"></i> Grade
                                </a>
                            <% } else { %>
                                <a href="ViewSubmissionServlet?studentId=<%= sub.getStudentId() %>&assignmentId=<%= sub.getAssignmentId() %>" class="action-link btn-view">
                                    <i class="fa-solid fa-eye"></i> View
                                </a>
                                <a href="#" class="action-link btn-download disabled">
                                    <i class="fa-solid fa-download"></i> Download
                                </a>
                                <a href="#" class="action-link btn-grade disabled">
                                    <i class="fa-solid fa-marker"></i> Grade
                                </a>
                            <% } %>
                        </div>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="11" style="padding: 30px; text-align: center;">No submissions match the selected filters.</td>
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
