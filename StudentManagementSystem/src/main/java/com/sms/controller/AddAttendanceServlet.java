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

@WebServlet("/AddAttendanceServlet")
public class AddAttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        StudentDAO studentDAO = new StudentDAO();
        CourseDAO courseDAO = new CourseDAO();

        ArrayList<Student> studentList = studentDAO.getAllStudents();
        ArrayList<Course> courseList = courseDAO.getAllCourses();

        request.setAttribute("studentList", studentList);
        request.setAttribute("courseList", courseList);

        request.getRequestDispatcher("admin/addAttendance.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int totalClasses = Integer.parseInt(request.getParameter("totalClasses"));
        int attendedClasses = Integer.parseInt(request.getParameter("attendedClasses"));

        if (attendedClasses > totalClasses) {
            request.setAttribute("error", "Attended classes cannot be greater than total classes!");
            doGet(request, response);
            return;
        }

        Attendance attendance = new Attendance();
        attendance.setStudentId(studentId);
        attendance.setCourseId(courseId);
        attendance.setTotalClasses(totalClasses);
        attendance.setAttendedClasses(attendedClasses);

        AttendanceDAO attendanceDAO = new AttendanceDAO();
        boolean status = attendanceDAO.addAttendance(attendance);

        if (status) {
            response.sendRedirect("AttendanceServlet");
        } else {
            request.setAttribute("error", "Failed to add attendance! A record might already exist for this student and course.");
            doGet(request, response);
        }
    }
}
