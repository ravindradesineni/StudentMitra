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

@WebServlet("/AddAnnouncementServlet")
public class AddAnnouncementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        request.getRequestDispatcher("admin/addAnnouncement.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");

        Announcement a = new Announcement();
        a.setTitle(title);
        a.setDescription(description);

        AnnouncementDAO announcementDAO = new AnnouncementDAO();
        boolean status = announcementDAO.addAnnouncement(a);

        if (status) {
            response.sendRedirect("AnnouncementsServlet");
        } else {
            request.setAttribute("error", "Failed to post announcement!");
            doGet(request, response);
        }
    }
}
