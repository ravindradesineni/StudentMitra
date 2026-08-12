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
import com.sms.dao.DepartmentDAO;
import com.sms.model.Course;
import com.sms.model.Department;

@WebServlet("/UpdateCourseServlet")
public class UpdateCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int courseId = Integer.parseInt(request.getParameter("id"));
        CourseDAO courseDAO = new CourseDAO();
        Course course = courseDAO.getCourseById(courseId);

        if (course != null) {
            DepartmentDAO deptDAO = new DepartmentDAO();
            ArrayList<Department> departmentList = deptDAO.getAllDepartments();
            request.setAttribute("course", course);
            request.setAttribute("departmentList", departmentList);
            request.getRequestDispatcher("admin/updateCourse.jsp").forward(request, response);
        } else {
            response.sendRedirect("CoursesServlet");
        }
    }
}
