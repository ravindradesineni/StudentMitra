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
import com.sms.dao.MarksDAO;
import com.sms.dao.StudentDAO;
import com.sms.model.Course;
import com.sms.model.Marks;
import com.sms.model.Student;

@WebServlet("/UpdateMarksServlet")
public class UpdateMarksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int marksId = Integer.parseInt(request.getParameter("id"));
        MarksDAO marksDAO = new MarksDAO();
        Marks marks = marksDAO.getMarksById(marksId);

        if (marks != null) {
            StudentDAO studentDAO = new StudentDAO();
            CourseDAO courseDAO = new CourseDAO();
            ArrayList<Student> studentList = studentDAO.getAllStudents();
            ArrayList<Course> courseList = courseDAO.getAllCourses();

            request.setAttribute("marks", marks);
            request.setAttribute("studentList", studentList);
            request.setAttribute("courseList", courseList);

            request.getRequestDispatcher("admin/updateMarks.jsp").forward(request, response);
        } else {
            response.sendRedirect("MarksServlet");
        }
    }
}
