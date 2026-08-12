package com.sms.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.CourseDAO;
import com.sms.model.Course;

@WebServlet("/UpdateCourseSaveServlet")
public class UpdateCourseSaveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String courseCode = request.getParameter("courseCode");
        String courseName = request.getParameter("courseName");
        String department = request.getParameter("department");
        String semester = request.getParameter("semester");
        String faculty = request.getParameter("faculty");
        int credits = Integer.parseInt(request.getParameter("credits"));

        Course course = new Course();
        course.setCourseId(courseId);
        course.setCourseCode(courseCode);
        course.setCourseName(courseName);
        course.setDepartment(department);
        course.setSemester(semester);
        course.setFaculty(faculty);
        course.setCredits(credits);

        CourseDAO courseDAO = new CourseDAO();
        boolean status = courseDAO.updateCourse(course);

        if (status) {
            response.sendRedirect("CoursesServlet");
        } else {
            request.setAttribute("error", "Failed to update course!");
            request.getRequestDispatcher("UpdateCourseServlet?id=" + courseId).forward(request, response);
        }
    }
}
