<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Student"%>
<%@ page import="com.sms.model.Announcement"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dashboard | StudentMitra</title>

    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/students.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
    <jsp:include page="sidebar.jsp"/>
    <div class="main">
        <!-- Header -->

        <div class="header">

            <div>

                <h1>Welcome Back, Admin</h1>

                <p>Manage your Student Management System</p>

            </div>

            <div class="right-header">

                <span>

                    <i class="fa-solid fa-circle-user"></i>

                    Admin

                </span>

                <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout" style="background:#dc2626; color:white; padding:10px 18px; border-radius:8px; text-decoration:none;">

                    <i class="fa-solid fa-right-from-bracket"></i>

                    Logout

                </a>

            </div>

        </div>

        <!-- Statistics -->

        <div class="stats" style="display: flex; gap: 20px; margin-bottom: 30px; flex-wrap: wrap;">

         <a href="${pageContext.request.contextPath}/StudentSummaryServlet"
            style="text-decoration:none; color:inherit; flex: 1; min-width: 200px;">
            <div class="card">
                <i class="fa-solid fa-users"></i>
                <h2><%= request.getAttribute("totalStudents") %></h2>
                <p>Total Students</p>
            </div>
         </a>

         <a href="${pageContext.request.contextPath}/DepartmentSummaryServlet"
            style="text-decoration:none; color:inherit; flex: 1; min-width: 200px;">
            <div class="card">
                <i class="fa-solid fa-building-columns"></i>
                <h2><%= request.getAttribute("totalDepartments") %></h2>
                <p>Departments</p>
            </div>
         </a>

         <a href="${pageContext.request.contextPath}/CoursesServlet"
            style="text-decoration:none; color:inherit; flex: 1; min-width: 200px;">
            <div class="card">
                <i class="fa-solid fa-book"></i>
                <h2><%= request.getAttribute("totalCourses") %></h2>
                <p>Courses</p>
            </div>
         </a>

          <a href="${pageContext.request.contextPath}/AnnouncementsServlet"
             style="text-decoration:none; color:inherit; flex: 1; min-width: 200px;">
             <div class="card">
                 <i class="fa-solid fa-bullhorn"></i>
                 <h2><%= request.getAttribute("totalAnnouncements") %></h2>
                 <p>Announcements</p>
             </div>
          </a>

         </div>

        <!-- Two Columns Layout for Recent Data -->
        <div style="display: flex; gap: 30px; margin-top: 30px; flex-wrap: wrap;">

            <!-- Recent Students -->
            <div class="table-container" style="flex: 1; min-width: 300px; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">

                <h2>Recent Students</h2>

                <table style="width: 100%; border-collapse: collapse; margin-top: 15px;">

                    <thead>

                        <tr style="border-bottom: 2px solid #eee; text-align: left;">

                            <th style="padding: 10px;">ID</th>

                            <th style="padding: 10px;">Name</th>

                            <th style="padding: 10px;">Department</th>

                            <th style="padding: 10px;">Year</th>

                        </tr>

                    </thead>

                    <tbody>

                    <%

                    ArrayList<Student> recentStudents =
                    (ArrayList<Student>) request.getAttribute("recentStudents");

                    if(recentStudents != null && !recentStudents.isEmpty()){

                        for(Student student : recentStudents){

                    %>

                    <tr style="border-bottom: 1px solid #eee;">

                        <td style="padding: 10px;"><%=student.getStudentId()%></td>

                        <td style="padding: 10px;"><%=student.getFullName()%></td>

                        <td style="padding: 10px;"><%=student.getDepartment()%></td>

                        <td style="padding: 10px;"><%=student.getYear()%></td>

                    </tr>

                    <%

                        }

                    }else{

                    %>

                    <tr>

                        <td colspan="4" style="padding: 15px; text-align: center;">

                            No students available.

                        </td>

                    </tr>

                    <%

                    }

                    %>

                    </tbody>
                </table>

            </div>

            <!-- Recent Announcements -->
            <div class="table-container" style="flex: 1; min-width: 300px; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">

                <h2>Recent Announcements</h2>

                <table style="width: 100%; border-collapse: collapse; margin-top: 15px;">

                    <thead>

                        <tr style="border-bottom: 2px solid #eee; text-align: left;">

                            <th style="padding: 10px; width: 35%;">Title</th>

                            <th style="padding: 10px;">Description</th>

                            <th style="padding: 10px; width: 25%;">Posted</th>

                        </tr>

                    </thead>

                    <tbody>

                    <%

                    ArrayList<Announcement> recentAnnouncements =
                    (ArrayList<Announcement>) request.getAttribute("recentAnnouncements");

                    if(recentAnnouncements != null && !recentAnnouncements.isEmpty()){

                        for(Announcement a : recentAnnouncements){

                    %>

                    <tr style="border-bottom: 1px solid #eee;">

                        <td style="padding: 10px;"><strong><%=a.getTitle()%></strong></td>

                        <td style="padding: 10px; font-size: 13px;"><%=a.getDescription()%></td>

                        <td style="padding: 10px; font-size: 12px; color: #777;"><%=a.getPostedDate().substring(0, 10)%></td>

                    </tr>

                    <%

                        }

                    }else{

                    %>

                    <tr>

                        <td colspan="3" style="padding: 15px; text-align: center;">

                            No announcements posted yet.

                        </td>

                    </tr>

                    <%

                    }

                    %>

                    </tbody>
                </table>

            </div>

        </div>

    </div>

</body>

</html>
