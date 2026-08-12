package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.CourseDAO;
import com.sms.model.Course;
import com.sms.model.Student;

@WebServlet("/StudentCoursesServlet")
public class StudentCoursesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        CourseDAO courseDAO = new CourseDAO();
        ArrayList<Course> courseList = courseDAO.getCoursesByDepartment(student.getDepartment());

        request.setAttribute("courseList", courseList);
        request.getRequestDispatcher("student/myCourses.jsp").forward(request, response);
    }
}
