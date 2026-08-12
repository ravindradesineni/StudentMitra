<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.StudyMaterial"%>
<%@ page import="com.sms.model.Course"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Study Materials | StudentMitra</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/students.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <style>
        .materials-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        .material-card {
            background-color: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: var(--transition-smooth);
        }
        .material-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-hover);
            border-color: var(--border-color-hover);
        }
        .card-header {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 15px;
        }
        .file-icon {
            font-size: 38px;
            color: var(--color-primary);
        }
        .file-icon.pdf { color: #d9383a; }
        .file-icon.doc, .file-icon.docx { color: #2b579a; }
        .file-icon.ppt, .file-icon.pptx { color: #d24726; }
        .file-icon.xls, .file-icon.xlsx { color: #217346; }
        .file-icon.zip { color: #e6a23c; }
        .file-icon.image { color: #409eff; }
        
        .card-title-box {
            width: calc(100% - 55px);
        }
        .card-title {
            font-size: 15px;
            font-weight: 600;
            color: var(--text-main);
            line-height: 1.4;
            margin-bottom: 4px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .card-desc {
            font-size: 12.5px;
            color: var(--text-muted);
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 38px;
            margin-bottom: 10px;
        }
        .tag-container {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin-bottom: 15px;
        }
        .tag {
            font-size: 10.5px;
            padding: 3px 8px;
            border-radius: 4px;
            font-weight: 500;
        }
        .tag-course {
            background-color: var(--color-primary-light);
            color: var(--color-primary);
        }
        .tag-semester {
            background-color: #faf9f6;
            color: var(--text-main);
            border: 1px solid var(--border-color);
        }
        .tag-category {
            background-color: var(--color-warning-bg);
            color: var(--color-warning-text);
            font-weight: 600;
        }
        .card-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-top: 1px solid var(--border-color);
            padding-top: 15px;
            margin-top: auto;
        }
        .upload-date {
            font-size: 11px;
            color: var(--text-muted);
        }
        .download-btn {
            background-color: var(--color-primary);
            color: var(--text-light);
            border: 1px solid var(--color-primary);
            padding: 8px 16px;
            font-size: 12.5px;
            font-weight: 600;
            border-radius: var(--border-radius-sm);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: var(--transition-smooth);
            cursor: pointer;
        }
        .download-btn:hover {
            background-color: var(--color-primary-hover);
            border-color: var(--color-primary-hover);
            color: var(--text-light) !important;
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
        <li>
            <a href="${pageContext.request.contextPath}/StudentAcademicCalendarServlet">
                <i class="fa-solid fa-calendar-days"></i>
                Academic Calendar
            </a>
        </li>
        <li class="active">
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
            <h1>Study Materials</h1>
            <p>Search, filter, and download reference materials published by your instructors.</p>
        </div>
        <a href="${pageContext.request.contextPath}/StudentDashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>
    </div>

    <!-- Filters header -->
    <div class="actions" style="flex-wrap: wrap; gap: 15px; justify-content: space-between;">
        <form action="${pageContext.request.contextPath}/StudentStudyMaterialsServlet" method="get" style="display: flex; gap: 10px; flex-grow: 1; max-width: 100%; flex-wrap: wrap;">
            <input type="text" name="search" placeholder="Search resources..." value="<%=request.getAttribute("search")%>" style="width: 20%; min-width: 130px;">
            
            <select name="course" style="width: 20%; min-width: 140px;">
                <option value="All" <%="All".equals(request.getAttribute("course")) ? "selected" : ""%>>All Courses</option>
                <%
                ArrayList<Course> courseList = (ArrayList<Course>) request.getAttribute("courseList");
                if (courseList != null) {
                    for (Course c : courseList) {
                        String val = c.getCourseCode();
                %>
                    <option value="<%=val%>" <%=val.equals(request.getAttribute("course")) ? "selected" : ""%>><%=val%></option>
                <%
                    }
                }
                %>
            </select>

            <select name="semester" style="width: 20%; min-width: 130px;">
                <option value="All" <%="All".equals(request.getAttribute("semester")) ? "selected" : ""%>>All Semesters</option>
                <option value="Semester 1" <%="Semester 1".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 1</option>
                <option value="Semester 2" <%="Semester 2".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 2</option>
                <option value="Semester 3" <%="Semester 3".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 3</option>
                <option value="Semester 4" <%="Semester 4".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 4</option>
                <option value="Semester 5" <%="Semester 5".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 5</option>
                <option value="Semester 6" <%="Semester 6".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 6</option>
                <option value="Semester 7" <%="Semester 7".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 7</option>
                <option value="Semester 8" <%="Semester 8".equals(request.getAttribute("semester")) ? "selected" : ""%>>Semester 8</option>
            </select>

            <select name="category" style="width: 20%; min-width: 130px;">
                <option value="All" <%="All".equals(request.getAttribute("category")) ? "selected" : ""%>>All Categories</option>
                <option value="Notes" <%="Notes".equals(request.getAttribute("category")) ? "selected" : ""%>>Notes</option>
                <option value="Lab Manual" <%="Lab Manual".equals(request.getAttribute("category")) ? "selected" : ""%>>Lab Manual</option>
                <option value="Assignment" <%="Assignment".equals(request.getAttribute("category")) ? "selected" : ""%>>Assignment</option>
                <option value="Previous Question Paper" <%="Previous Question Paper".equals(request.getAttribute("category")) ? "selected" : ""%>>Previous Question Paper</option>
                <option value="Presentation" <%="Presentation".equals(request.getAttribute("category")) ? "selected" : ""%>>Presentation</option>
                <option value="Reference Material" <%="Reference Material".equals(request.getAttribute("category")) ? "selected" : ""%>>Reference Material</option>
                <option value="Syllabus" <%="Syllabus".equals(request.getAttribute("category")) ? "selected" : ""%>>Syllabus</option>
                <option value="Other" <%="Other".equals(request.getAttribute("category")) ? "selected" : ""%>>Other</option>
            </select>

            <button type="submit">
                <i class="fa-solid fa-magnifying-glass"></i> Search
            </button>
        </form>
    </div>

    <!-- Materials Grid -->
    <div class="materials-grid">
    <%
    ArrayList<StudyMaterial> materialList = (ArrayList<StudyMaterial>) request.getAttribute("materialList");
    if (materialList != null && !materialList.isEmpty()) {
        for (StudyMaterial sm : materialList) {
            // Determine icon class based on file type
            String type = sm.getFileType().toLowerCase();
            String iconClass = "fa-file";
            String colorClass = "";
            
            if ("pdf".equals(type)) {
                iconClass = "fa-file-pdf";
                colorClass = "pdf";
            } else if (type.contains("doc")) {
                iconClass = "fa-file-word";
                colorClass = "doc";
            } else if (type.contains("ppt")) {
                iconClass = "fa-file-powerpoint";
                colorClass = "ppt";
            } else if (type.contains("xls")) {
                iconClass = "fa-file-excel";
                colorClass = "xls";
            } else if ("zip".equals(type) || "rar".equals(type)) {
                iconClass = "fa-file-zipper";
                colorClass = "zip";
            } else if (type.equals("png") || type.equals("jpg") || type.equals("jpeg")) {
                iconClass = "fa-file-image";
                colorClass = "image";
            }
    %>
        <div class="material-card">
            <div>
                <div class="card-header">
                    <i class="fa-solid <%=iconClass%> file-icon <%=colorClass%>"></i>
                    <div class="card-title-box">
                        <div class="card-title" title="<%=sm.getTitle()%>"><%=sm.getTitle()%></div>
                        <div class="tag-container">
                            <span class="tag tag-course"><%=sm.getCourse()%></span>
                            <span class="tag tag-semester"><%=sm.getSemester()%></span>
                            <span class="tag tag-category"><%=sm.getCategory()%></span>
                        </div>
                    </div>
                </div>
                <div class="card-desc">
                    <%=sm.getDescription() != null && !sm.getDescription().trim().isEmpty() ? sm.getDescription() : "No additional description provided."%>
                </div>
            </div>
            
            <div class="card-footer">
                <div class="upload-date">
                    <i class="fa-solid fa-clock"></i> <%=sm.getUploadedDate().toString().substring(0, 10)%>
                </div>
                <a href="${pageContext.request.contextPath}/<%=sm.getFilePath()%>" download="<%=sm.getFileName()%>" class="download-btn">
                    <i class="fa-solid fa-download"></i> Download
                </a>
            </div>
        </div>
    <%
        }
    } else {
    %>
        <div style="grid-column: 1 / -1; background-color: var(--bg-card); padding: 40px; text-align: center; border: 1px solid var(--border-color); border-radius: var(--border-radius); color: var(--text-muted); font-size: 14px;">
            <i class="fa-solid fa-folder-open fa-3x" style="margin-bottom: 15px; color: var(--border-color-hover);"></i>
            <p>No study materials found matching your filters.</p>
        </div>
    <%
    }
    %>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
</body>
</html>
