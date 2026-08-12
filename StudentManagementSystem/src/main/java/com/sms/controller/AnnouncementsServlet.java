package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.AnnouncementDAO;
import com.sms.model.Announcement;

@WebServlet("/AnnouncementsServlet")
public class AnnouncementsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        AnnouncementDAO announcementDAO = new AnnouncementDAO();
        ArrayList<Announcement> announcementList = announcementDAO.getAllAnnouncements();
        request.setAttribute("announcementList", announcementList);

        request.getRequestDispatcher("admin/announcements.jsp").forward(request, response);
    }
}
