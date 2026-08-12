package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.StudentDAO;
import com.sms.dao.AttendanceDAO;
import com.sms.dao.MarksDAO;
import com.sms.model.Student;
import com.sms.model.Attendance;
import com.sms.model.Marks;

@WebServlet("/AdminStudentProfileServlet")
public class AdminStudentProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        try {
            int studentId = Integer.parseInt(request.getParameter("id"));
            StudentDAO studentDAO = new StudentDAO();
            Student student = studentDAO.getStudentById(studentId);

            if (student != null) {
                // Calculate Overall Attendance Percentage
                AttendanceDAO attendanceDAO = new AttendanceDAO();
                ArrayList<Attendance> attendanceList = attendanceDAO.getAttendanceByStudentId(studentId);
                int totalClasses = 0;
                int attendedClasses = 0;
                for (Attendance att : attendanceList) {
                    totalClasses += att.getTotalClasses();
                    attendedClasses += att.getAttendedClasses();
                }
                double overallAttendance = 100.0;
                if (totalClasses > 0) {
                    overallAttendance = ((double) attendedClasses / totalClasses) * 100.0;
                }

                // Retrieve subject marks
                MarksDAO marksDAO = new MarksDAO();
                ArrayList<Marks> marksList = marksDAO.getMarksByStudentId(studentId);

                request.setAttribute("student", student);
                request.setAttribute("overallAttendance", overallAttendance);
                request.setAttribute("marksList", marksList);

                request.getRequestDispatcher("admin/studentProfile.jsp").forward(request, response);
            } else {
                response.sendRedirect("StudentsServlet");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("StudentsServlet");
        }
    }
}
