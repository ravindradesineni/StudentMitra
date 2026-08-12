package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.AssignmentDAO;
import com.sms.model.Assignment;
import com.sms.model.Submission;
import com.sms.model.Student;

@WebServlet("/StudentAssignmentsServlet")
public class StudentAssignmentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        AssignmentDAO assignmentDAO = new AssignmentDAO();

        ArrayList<Assignment> assignmentList = assignmentDAO.getAllAssignments();
        ArrayList<Submission> submissionList = assignmentDAO.getSubmissionsByStudent(student.getStudentId());

        // Map submissions by Assignment ID for easy access in JSP
        Map<Integer, Submission> submissionMap = new HashMap<>();
        for (Submission s : submissionList) {
            submissionMap.put(s.getAssignmentId(), s);
        }

        request.setAttribute("assignmentList", assignmentList);
        request.setAttribute("submissionMap", submissionMap);

        request.getRequestDispatcher("student/assignments.jsp").forward(request, response);
    }
}
