package com.sms.controller;

import java.io.File;
import java.io.IOException;
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

@WebServlet("/AddAssignmentServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB limit
    maxRequestSize = 1024 * 1024 * 20     // 20MB request limit
)
public class AddAssignmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10 MB

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        request.getRequestDispatcher("admin/addAssignment.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("dueDate");

        String pdfPath = null;
        Part filePart = null;
        try {
            filePart = request.getPart("pdfFile");
        } catch (Exception e) {
            request.setAttribute("error", "Error reading file upload: " + e.getMessage());
            doGet(request, response);
            return;
        }

        if (filePart != null && filePart.getSize() > 0) {
            // Validate File Size
            if (filePart.getSize() > MAX_FILE_SIZE) {
                request.setAttribute("error", "PDF file size exceeds the maximum limit of 10 MB.");
                doGet(request, response);
                return;
            }

            // Validate File Type
            String fileName = getFileName(filePart);
            String ext = "";
            int dotIdx = fileName.lastIndexOf('.');
            if (dotIdx > 0) {
                ext = fileName.substring(dotIdx).toLowerCase();
            }

            if (!ext.equals(".pdf")) {
                request.setAttribute("error", "Invalid file type. Only PDF files are allowed for assignments.");
                doGet(request, response);
                return;
            }

            // Save PDF
            try {
                String uniqueName = "assignment_" + System.currentTimeMillis() + "_" + fileName;
                String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "assignments";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(uploadPath + File.separator + uniqueName);
                pdfPath = "uploads/assignments/" + uniqueName;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "PDF upload failed: " + e.getMessage());
                doGet(request, response);
                return;
            }
        }

        Assignment assignment = new Assignment();
        assignment.setTitle(title);
        assignment.setSubject(subject);
        assignment.setDescription(description);
        assignment.setDueDate(dueDate);
        assignment.setPdfPath(pdfPath);

        AssignmentDAO assignmentDAO = new AssignmentDAO();
        boolean status = assignmentDAO.addAssignment(assignment);

        if (status) {
            response.sendRedirect("AdminAssignmentsServlet");
        } else {
            // If database save fails, delete the uploaded file if any
            if (pdfPath != null) {
                String realPath = request.getServletContext().getRealPath("") + File.separator + pdfPath;
                File physicalFile = new File(realPath);
                if (physicalFile.exists()) {
                    physicalFile.delete();
                }
            }
            request.setAttribute("error", "Failed to create assignment in the database.");
            doGet(request, response);
        }
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
