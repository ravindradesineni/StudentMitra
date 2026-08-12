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
import com.sms.model.Attendance;
import com.sms.model.Student;

@WebServlet("/StudentAttendanceServlet")
public class StudentAttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        ArrayList<Attendance> list = attendanceDAO.getAttendanceByStudentId(student.getStudentId());

        request.setAttribute("attendanceList", list);
        request.getRequestDispatcher("student/myAttendance.jsp").forward(request, response);
    }
}
