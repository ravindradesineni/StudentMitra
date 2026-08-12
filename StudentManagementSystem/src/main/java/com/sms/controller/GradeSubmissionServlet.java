package com.sms.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.AssignmentDAO;

@WebServlet("/GradeSubmissionServlet")
public class GradeSubmissionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        try {
            int submissionId = Integer.parseInt(request.getParameter("submissionId"));
            int marks = Integer.parseInt(request.getParameter("marks"));
            String feedback = request.getParameter("feedback");

            AssignmentDAO assignmentDAO = new AssignmentDAO();
            boolean success = assignmentDAO.gradeSubmission(submissionId, marks, feedback);

            if (success) {
                session.setAttribute("success", "Submission graded successfully!");
            } else {
                session.setAttribute("error", "Failed to grade submission.");
            }
            
            response.sendRedirect("ViewSubmissionServlet?submissionId=" + submissionId);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error grading submission: " + e.getMessage());
            response.sendRedirect("AssignmentSubmissionsServlet");
        }
    }
}
