package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.MarksDAO;
import com.sms.model.Marks;

@WebServlet("/MarksServlet")
public class MarksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        MarksDAO marksDAO = new MarksDAO();
        ArrayList<Marks> marksList = marksDAO.getAllMarks();
        request.setAttribute("marksList", marksList);

        request.getRequestDispatcher("admin/marks.jsp").forward(request, response);
    }
}
