package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.EventDAO;
import com.sms.model.Event;

@WebServlet("/AcademicCalendarServlet")
public class AcademicCalendarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        String search = request.getParameter("search");
        String type = request.getParameter("type");
        String sort = request.getParameter("sort");

        EventDAO eventDAO = new EventDAO();
        ArrayList<Event> eventList = eventDAO.getAllEvents(search, type, sort);

        request.setAttribute("eventList", eventList);
        request.setAttribute("search", search != null ? search : "");
        request.setAttribute("type", type != null ? type : "All");
        request.setAttribute("sort", sort != null ? sort : "ASC");
        
        request.getRequestDispatcher("admin/academicCalendar.jsp").forward(request, response);
    }
}
