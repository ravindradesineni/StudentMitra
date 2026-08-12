package com.sms.controller;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

import com.sms.dao.StudentDAO;
import com.sms.dao.DepartmentDAO;
import com.sms.dao.CourseDAO;
import com.sms.dao.AnnouncementDAO;
import com.sms.model.Student;
import com.sms.model.Announcement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        StudentDAO studentDAO = new StudentDAO();
        DepartmentDAO departmentDAO = new DepartmentDAO();
        CourseDAO courseDAO = new CourseDAO();
        AnnouncementDAO announcementDAO = new AnnouncementDAO();

        int totalStudents = studentDAO.getTotalStudents();
        int totalDepartments = departmentDAO.getTotalDepartments();
        int totalCourses = courseDAO.getTotalCourses();
        int totalAnnouncements = announcementDAO.getTotalAnnouncements();

        ArrayList<Student> recentStudents = studentDAO.getRecentStudents();
        ArrayList<Announcement> recentAnnouncements = announcementDAO.getRecentAnnouncements(3);

        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("totalDepartments", totalDepartments);
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("totalAnnouncements", totalAnnouncements);
        request.setAttribute("recentStudents", recentStudents);
        request.setAttribute("recentAnnouncements", recentAnnouncements);

        request.getRequestDispatcher("admin/dashboard.jsp")
               .forward(request, response);

    }

}