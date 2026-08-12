package com.sms.controller;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.AssignmentDAO;
import com.sms.model.Assignment;

@WebServlet("/DeleteAssignmentServlet")
public class DeleteAssignmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int assignmentId = Integer.parseInt(request.getParameter("id"));
        AssignmentDAO assignmentDAO = new AssignmentDAO();
        Assignment assignment = assignmentDAO.getAssignmentById(assignmentId);

        if (assignment != null) {
            // Delete associated file if exists
            if (assignment.getPdfPath() != null && !assignment.getPdfPath().isEmpty()) {
                String realPath = request.getServletContext().getRealPath("") + File.separator + assignment.getPdfPath();
                File physicalFile = new File(realPath);
                if (physicalFile.exists()) {
                    physicalFile.delete();
                }
            }
            assignmentDAO.deleteAssignment(assignmentId);
        }

        response.sendRedirect("AdminAssignmentsServlet");
    }
}
