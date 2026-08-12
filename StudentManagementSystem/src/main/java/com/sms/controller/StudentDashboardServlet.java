package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.sms.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("student") == null) {

            response.sendRedirect("student/login.jsp");
            return;

        }

        Student student = (Student) session.getAttribute("student");

        com.sms.dao.CourseDAO courseDAO = new com.sms.dao.CourseDAO();
        com.sms.dao.AttendanceDAO attendanceDAO = new com.sms.dao.AttendanceDAO();
        com.sms.dao.MarksDAO marksDAO = new com.sms.dao.MarksDAO();
        com.sms.dao.AnnouncementDAO announcementDAO = new com.sms.dao.AnnouncementDAO();

        // 1. Total Courses
        int totalCourses = courseDAO.getCoursesByDepartment(student.getDepartment()).size();

        // 2. Average Attendance
        ArrayList<com.sms.model.Attendance> attList = attendanceDAO.getAttendanceByStudentId(student.getStudentId());
        double avgAttendance = 0.0;
        if (!attList.isEmpty()) {
            double totalPercentage = 0.0;
            for (com.sms.model.Attendance a : attList) {
                totalPercentage += a.getAttendancePercentage();
            }
            avgAttendance = totalPercentage / attList.size();
        }

        // 3. Graded Courses
        int gradedCourses = marksDAO.getMarksByStudentId(student.getStudentId()).size();

        // 4. Recent Announcements
        ArrayList<com.sms.model.Announcement> recentAnnouncements = announcementDAO.getRecentAnnouncements(3);

        // 5. Assignment Statistics
        com.sms.dao.AssignmentDAO assignmentDAO = new com.sms.dao.AssignmentDAO();
        ArrayList<com.sms.model.Assignment> allAssignments = assignmentDAO.getAllAssignments();
        ArrayList<com.sms.model.Submission> studentSubmissions = assignmentDAO.getSubmissionsByStudent(student.getStudentId());

        java.util.Map<Integer, com.sms.model.Submission> subMap = new java.util.HashMap<>();
        for (com.sms.model.Submission sub : studentSubmissions) {
            subMap.put(sub.getAssignmentId(), sub);
        }

        int totalAssignments = allAssignments.size();
        int pendingAssignments = 0;
        int submittedAssignments = 0;
        int expiredAssignments = 0;
        long minRemainingDays = -1;
        
        java.time.LocalDate today = java.time.LocalDate.now();

        for (com.sms.model.Assignment a : allAssignments) {
            com.sms.model.Submission sub = subMap.get(a.getAssignmentId());
            if (sub != null) {
                submittedAssignments++;
            } else {
                java.time.LocalDate dueDate = java.time.LocalDate.parse(a.getDueDate());
                if (today.isAfter(dueDate)) {
                    expiredAssignments++;
                } else {
                    pendingAssignments++;
                    long days = java.time.temporal.ChronoUnit.DAYS.between(today, dueDate);
                    if (minRemainingDays == -1 || days < minRemainingDays) {
                        minRemainingDays = days;
                    }
                }
            }
        }
        String remainingDaysStr = minRemainingDays == -1 ? "N/A" : minRemainingDays + " Days";

        // Load latest details from database to ensure fresh content
        com.sms.dao.StudentDAO studentDAO = new com.sms.dao.StudentDAO();
        Student freshStudent = studentDAO.getStudentById(student.getStudentId());
        if (freshStudent != null) {
            student = freshStudent;
            session.setAttribute("student", student);
        }

        request.setAttribute("student", student);
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("avgAttendance", avgAttendance);
        request.setAttribute("gradedCourses", gradedCourses);
        request.setAttribute("recentAnnouncements", recentAnnouncements);
        request.setAttribute("totalAssignments", totalAssignments);
        request.setAttribute("pendingAssignments", pendingAssignments);
        request.setAttribute("submittedAssignments", submittedAssignments);
        request.setAttribute("expiredAssignments", expiredAssignments);
        request.setAttribute("remainingDaysStr", remainingDaysStr);

        request.getRequestDispatcher("student/studentDashboard.jsp")
               .forward(request, response);

    }

}