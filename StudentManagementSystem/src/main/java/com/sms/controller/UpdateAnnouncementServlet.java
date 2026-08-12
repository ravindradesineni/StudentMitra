package com.sms.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.AnnouncementDAO;
import com.sms.model.Announcement;

@WebServlet("/UpdateAnnouncementServlet")
public class UpdateAnnouncementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        AnnouncementDAO announcementDAO = new AnnouncementDAO();
        Announcement announcement = announcementDAO.getAnnouncementById(id);

        if (announcement != null) {
            request.setAttribute("announcement", announcement);
            request.getRequestDispatcher("admin/updateAnnouncement.jsp").forward(request, response);
        } else {
            response.sendRedirect("AnnouncementsServlet");
        }
    }
}
