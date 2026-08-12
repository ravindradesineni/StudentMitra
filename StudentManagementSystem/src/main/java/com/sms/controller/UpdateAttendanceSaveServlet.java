package com.sms.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.AttendanceDAO;
import com.sms.model.Attendance;

@WebServlet("/UpdateAttendanceSaveServlet")
public class UpdateAttendanceSaveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int attendanceId = Integer.parseInt(request.getParameter("attendanceId"));
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int totalClasses = Integer.parseInt(request.getParameter("totalClasses"));
        int attendedClasses = Integer.parseInt(request.getParameter("attendedClasses"));

        if (attendedClasses > totalClasses) {
            request.setAttribute("error", "Attended classes cannot be greater than total classes!");
            request.getRequestDispatcher("UpdateAttendanceServlet?id=" + attendanceId).forward(request, response);
            return;
        }

        Attendance attendance = new Attendance();
        attendance.setAttendanceId(attendanceId);
        attendance.setStudentId(studentId);
        attendance.setCourseId(courseId);
        attendance.setTotalClasses(totalClasses);
        attendance.setAttendedClasses(attendedClasses);

        AttendanceDAO attendanceDAO = new AttendanceDAO();
        boolean status = attendanceDAO.updateAttendance(attendance);

        if (status) {
            response.sendRedirect("AttendanceServlet");
        } else {
            request.setAttribute("error", "Failed to update attendance!");
            request.getRequestDispatcher("UpdateAttendanceServlet?id=" + attendanceId).forward(request, response);
        }
    }
}
