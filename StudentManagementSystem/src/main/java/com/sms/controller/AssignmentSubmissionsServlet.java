package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.AssignmentDAO;
import com.sms.model.Submission;

@WebServlet("/AssignmentSubmissionsServlet")
public class AssignmentSubmissionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        String search = request.getParameter("search");
        String status = request.getParameter("status");
        String sort = request.getParameter("sort");

        // Defaults
        if (status == null) status = "All";
        if (sort == null) sort = "";
        if (search == null) search = "";

        AssignmentDAO assignmentDAO = new AssignmentDAO();
        ArrayList<Submission> submissions = assignmentDAO.getSubmissionsForAdmin(search, status, sort);

        request.setAttribute("submissions", submissions);
        request.setAttribute("search", search);
        request.setAttribute("status", status);
        request.setAttribute("sort", sort);

        request.getRequestDispatcher("admin/assignmentSubmissions.jsp").forward(request, response);
    }
}
