package com.sms.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.sms.dao.AssignmentDAO;
import com.sms.model.Assignment;
import com.sms.model.Submission;
import com.sms.model.Student;

@WebServlet("/SubmitAssignmentServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB limit
    maxRequestSize = 1024 * 1024 * 20     // 20MB request limit
)
public class SubmitAssignmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10 MB

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));

        AssignmentDAO assignmentDAO = new AssignmentDAO();
        Assignment assignment = assignmentDAO.getAssignmentById(assignmentId);

        if (assignment == null) {
            response.sendRedirect("StudentAssignmentsServlet");
            return;
        }

        Part filePart = null;
        try {
            filePart = request.getPart("submissionFile");
        } catch (Exception e) {
            request.setAttribute("error", "Error reading submission file: " + e.getMessage());
            request.getRequestDispatcher("StudentAssignmentsServlet").forward(request, response);
            return;
        }

        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "Please select a file to upload.");
            response.sendRedirect("StudentAssignmentsServlet");
            return;
        }

        // Validate File Size
        if (filePart.getSize() > MAX_FILE_SIZE) {
            session.setAttribute("error", "File size exceeds the maximum limit of 10 MB.");
            response.sendRedirect("StudentAssignmentsServlet");
            return;
        }

        // Validate File Type
        String fileName = getFileName(filePart);
        String ext = "";
        int dotIdx = fileName.lastIndexOf('.');
        if (dotIdx > 0) {
            ext = fileName.substring(dotIdx).toLowerCase();
        }

        if (!ext.equals(".pdf") && !ext.equals(".doc") && !ext.equals(".docx")) {
            session.setAttribute("error", "Invalid file type. Only PDF, DOC, and DOCX files are allowed.");
            response.sendRedirect("StudentAssignmentsServlet");
            return;
        }

        // Save File & Register Submission
        String fileSaveName = "submission_" + student.getStudentId() + "_" + assignmentId + "_" + System.currentTimeMillis() + ext;
        String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "submissions";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            filePart.write(uploadPath + File.separator + fileSaveName);
            String relativePath = "uploads/submissions/" + fileSaveName;

            // Determine status based on due date
            LocalDate dueDate = LocalDate.parse(assignment.getDueDate());
            LocalDate today = LocalDate.now();
            String status = "Submitted";
            if (today.isAfter(dueDate)) {
                status = "Late Submission";
            }

            Submission submission = new Submission();
            submission.setAssignmentId(assignmentId);
            submission.setStudentId(student.getStudentId());
            submission.setFilePath(relativePath);
            submission.setFileName(fileName);
            submission.setStatus(status);

            boolean success = assignmentDAO.addSubmission(submission);

            if (success) {
                session.setAttribute("success", "Assignment submitted successfully!");
            } else {
                // Cleanup uploaded file if db update fails
                File physicalFile = new File(uploadPath + File.separator + fileSaveName);
                if (physicalFile.exists()) {
                    physicalFile.delete();
                }
                session.setAttribute("error", "Failed to register submission in database.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Submission upload error: " + e.getMessage());
        }

        response.sendRedirect("StudentAssignmentsServlet");
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
