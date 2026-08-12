package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.EventDAO;
import com.sms.model.Event;

@WebServlet("/StudentAcademicCalendarServlet")
public class StudentAcademicCalendarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        String search = request.getParameter("search");
        String type = request.getParameter("type");
        String upcomingOnlyStr = request.getParameter("upcomingOnly");
        boolean upcomingOnly = "true".equalsIgnoreCase(upcomingOnlyStr);

        EventDAO eventDAO = new EventDAO();
        ArrayList<Event> eventList = eventDAO.getAllEvents(search, type, "ASC");

        if (upcomingOnly) {
            eventList = eventList.stream()
                    .filter(e -> "Upcoming".equalsIgnoreCase(e.getStatus()))
                    .collect(Collectors.toCollection(ArrayList::new));
        }

        request.setAttribute("eventList", eventList);
        request.setAttribute("search", search != null ? search : "");
        request.setAttribute("type", type != null ? type : "All");
        request.setAttribute("upcomingOnly", upcomingOnly);

        request.getRequestDispatcher("student/academicCalendar.jsp").forward(request, response);
    }
}
