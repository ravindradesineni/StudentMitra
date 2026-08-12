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
import com.sms.model.Assignment;

@WebServlet("/AdminAssignmentsServlet")
public class AdminAssignmentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        AssignmentDAO assignmentDAO = new AssignmentDAO();
        ArrayList<Assignment> list = assignmentDAO.getAllAssignments();
        request.setAttribute("assignmentList", list);

        request.getRequestDispatcher("admin/assignments.jsp").forward(request, response);
    }
}
