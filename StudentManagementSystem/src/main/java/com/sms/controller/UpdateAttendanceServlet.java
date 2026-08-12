package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.AttendanceDAO;
import com.sms.dao.CourseDAO;
import com.sms.dao.StudentDAO;
import com.sms.model.Attendance;
import com.sms.model.Course;
import com.sms.model.Student;

@WebServlet("/UpdateAttendanceServlet")
public class UpdateAttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int attendanceId = Integer.parseInt(request.getParameter("id"));
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        Attendance attendance = attendanceDAO.getAttendanceById(attendanceId);

        if (attendance != null) {
            StudentDAO studentDAO = new StudentDAO();
            CourseDAO courseDAO = new CourseDAO();
            ArrayList<Student> studentList = studentDAO.getAllStudents();
            ArrayList<Course> courseList = courseDAO.getAllCourses();

            request.setAttribute("attendance", attendance);
            request.setAttribute("studentList", studentList);
            request.setAttribute("courseList", courseList);

            request.getRequestDispatcher("admin/updateAttendance.jsp").forward(request, response);
        } else {
            response.sendRedirect("AttendanceServlet");
        }
    }
}
