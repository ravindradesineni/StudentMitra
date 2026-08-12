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

@WebServlet("/StudentAnnouncementsServlet")
public class StudentAnnouncementsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        AnnouncementDAO announcementDAO = new AnnouncementDAO();
        ArrayList<Announcement> list = announcementDAO.getAllAnnouncements();

        request.setAttribute("announcementList", list);
        request.getRequestDispatcher("student/myAnnouncements.jsp").forward(request, response);
    }
}
