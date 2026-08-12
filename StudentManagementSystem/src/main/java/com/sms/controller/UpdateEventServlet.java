package com.sms.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.EventDAO;
import com.sms.model.Event;

@WebServlet("/UpdateEventServlet")
public class UpdateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            EventDAO eventDAO = new EventDAO();
            Event event = eventDAO.getEventById(id);

            if (event != null) {
                request.setAttribute("event", event);
                request.getRequestDispatcher("admin/updateEvent.jsp").forward(request, response);
            } else {
                response.sendRedirect("AcademicCalendarServlet");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AcademicCalendarServlet");
        }
    }
}
