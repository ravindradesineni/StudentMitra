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

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        AttendanceDAO attendanceDAO = new AttendanceDAO();
        ArrayList<Attendance> attendanceList = attendanceDAO.getAllAttendance();
        request.setAttribute("attendanceList", attendanceList);

        request.getRequestDispatcher("admin/attendance.jsp").forward(request, response);
    }
}
