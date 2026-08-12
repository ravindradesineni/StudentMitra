package com.sms.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.AssignmentDAO;
import com.sms.dao.StudentDAO;
import com.sms.model.Assignment;
import com.sms.model.Student;
import com.sms.model.Submission;

@WebServlet("/ViewSubmissionServlet")
public class ViewSubmissionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int submissionId = 0;
        String subIdStr = request.getParameter("submissionId");
        if (subIdStr != null && !subIdStr.isEmpty()) {
            try {
                submissionId = Integer.parseInt(subIdStr);
            } catch (NumberFormatException e) {
                submissionId = 0;
            }
        }

        AssignmentDAO assignmentDAO = new AssignmentDAO();
        Submission submission = null;

        if (submissionId > 0) {
            submission = assignmentDAO.getSubmissionByIdForAdmin(submissionId);
        } else {
            String studentIdStr = request.getParameter("studentId");
            String assignmentIdStr = request.getParameter("assignmentId");
            
            if (studentIdStr != null && assignmentIdStr != null) {
                try {
                    int studentId = Integer.parseInt(studentIdStr);
                    int assignmentId = Integer.parseInt(assignmentIdStr);
                    
                    StudentDAO studentDAO = new StudentDAO();
                    Student s = studentDAO.getStudentById(studentId);
                    Assignment a = assignmentDAO.getAssignmentById(assignmentId);
                    
                    if (s != null && a != null) {
                        submission = new Submission();
                        submission.setStudentId(studentId);
                        submission.setStudentName(s.getFullName());
                        submission.setStudentEmail(s.getEmail());
                        submission.setDepartment(s.getDepartment());
                        submission.setAssignmentId(assignmentId);
                        submission.setAssignmentTitle(a.getTitle());
                        submission.setSubject(a.getSubject());
                        submission.setDueDate(a.getDueDate());
                        submission.setSubmissionId(0);
                        
                        java.time.LocalDate dueDate = java.time.LocalDate.parse(a.getDueDate());
                        if (java.time.LocalDate.now().isAfter(dueDate)) {
                            submission.setStatus("Expired");
                        } else {
                            submission.setStatus("Pending");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        if (submission == null) {
            response.sendRedirect("AssignmentSubmissionsServlet");
            return;
        }

        request.setAttribute("submission", submission);
        request.getRequestDispatcher("admin/viewSubmission.jsp").forward(request, response);
    }
}
