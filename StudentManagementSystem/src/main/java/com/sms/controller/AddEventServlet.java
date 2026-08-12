package com.sms.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.EventDAO;
import com.sms.model.Event;

@WebServlet("/AddEventServlet")
public class AddEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        request.getRequestDispatcher("admin/addEvent.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String eventType = request.getParameter("eventType");
        String dateStr = request.getParameter("eventDate");
        String timeStr = request.getParameter("eventTime");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        try {
            Event event = new Event();
            event.setTitle(title);
            event.setEventType(eventType);
            
            if (dateStr != null && !dateStr.isEmpty()) {
                event.setEventDate(Date.valueOf(dateStr));
            }
            
            if (timeStr != null && !timeStr.isEmpty()) {
                // HTML input type="time" might be HH:mm, need HH:mm:ss for Time.valueOf
                if (timeStr.length() == 5) {
                    timeStr += ":00";
                }
                event.setEventTime(Time.valueOf(timeStr));
            }
            
            event.setDescription(description);
            event.setStatus(status != null ? status : "Upcoming");

            EventDAO eventDAO = new EventDAO();
            boolean success = eventDAO.addEvent(event);

            if (success) {
                response.sendRedirect("AcademicCalendarServlet");
            } else {
                request.setAttribute("error", "Failed to add event to database.");
                doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid inputs: " + e.getMessage());
            doGet(request, response);
        }
    }
}
