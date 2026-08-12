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

@WebServlet("/UpdateAssignmentSaveServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB limit
    maxRequestSize = 1024 * 1024 * 20     // 20MB request limit
)
public class UpdateAssignmentSaveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10 MB

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
        String title = request.getParameter("title");
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("dueDate");

        AssignmentDAO assignmentDAO = new AssignmentDAO();
        Assignment latestAssignment = assignmentDAO.getAssignmentById(assignmentId);

        if (latestAssignment == null) {
            response.sendRedirect("AdminAssignmentsServlet");
            return;
        }

        latestAssignment.setTitle(title);
        latestAssignment.setSubject(subject);
        latestAssignment.setDescription(description);
        latestAssignment.setDueDate(dueDate);

        Part filePart = null;
        try {
            filePart = request.getPart("pdfFile");
        } catch (Exception e) {
            request.setAttribute("error", "Error reading file upload: " + e.getMessage());
            request.setAttribute("assignment", latestAssignment);
            request.getRequestDispatcher("admin/updateAssignment.jsp").forward(request, response);
            return;
        }

        String newPdfPath = latestAssignment.getPdfPath();
        boolean newFileUploaded = false;

        if (filePart != null && filePart.getSize() > 0) {
            // Validate File Size
            if (filePart.getSize() > MAX_FILE_SIZE) {
                request.setAttribute("error", "PDF file size exceeds the maximum limit of 10 MB.");
                request.setAttribute("assignment", latestAssignment);
                request.getRequestDispatcher("admin/updateAssignment.jsp").forward(request, response);
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
                request.setAttribute("assignment", latestAssignment);
                request.getRequestDispatcher("admin/updateAssignment.jsp").forward(request, response);
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

                // Delete old PDF if it exists
                String oldPdfPath = latestAssignment.getPdfPath();
                if (oldPdfPath != null && !oldPdfPath.isEmpty()) {
                    String realPath = request.getServletContext().getRealPath("") + File.separator + oldPdfPath;
                    File oldFile = new File(realPath);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }

                filePart.write(uploadPath + File.separator + uniqueName);
                newPdfPath = "uploads/assignments/" + uniqueName;
                newFileUploaded = true;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "PDF upload failed: " + e.getMessage());
                request.setAttribute("assignment", latestAssignment);
                request.getRequestDispatcher("admin/updateAssignment.jsp").forward(request, response);
                return;
            }
        }

        if (newFileUploaded) {
            latestAssignment.setPdfPath(newPdfPath);
        }

        boolean success = assignmentDAO.updateAssignment(latestAssignment);

        if (success) {
            response.sendRedirect("AdminAssignmentsServlet");
        } else {
            // Delete uploaded file if DB save fails
            if (newFileUploaded && newPdfPath != null) {
                String realPath = request.getServletContext().getRealPath("") + File.separator + newPdfPath;
                File physicalFile = new File(realPath);
                if (physicalFile.exists()) {
                    physicalFile.delete();
                }
            }
            request.setAttribute("error", "Failed to update assignment details.");
            request.setAttribute("assignment", latestAssignment);
            request.getRequestDispatcher("admin/updateAssignment.jsp").forward(request, response);
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
