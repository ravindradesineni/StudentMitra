package com.sms.controller;

import java.io.IOException;
import java.io.File;
import java.util.Arrays;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.sms.dao.StudyMaterialDAO;
import com.sms.model.StudyMaterial;

@WebServlet("/UpdateMaterialSaveServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 25,       // Limit request, validate strictly in code (20MB)
    maxRequestSize = 1024 * 1024 * 60     // 60MB
)
public class UpdateMaterialSaveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final long MAX_FILE_SIZE = 20 * 1024 * 1024; // 20 MB strictly

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int materialId = Integer.parseInt(request.getParameter("materialId"));
        String course = request.getParameter("course");
        String semester = request.getParameter("semester");
        String category = request.getParameter("category");
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        StudyMaterialDAO materialDAO = new StudyMaterialDAO();
        StudyMaterial material = materialDAO.getMaterialById(materialId);

        if (material == null) {
            response.sendRedirect("StudyMaterialsServlet");
            return;
        }

        // Set metadata updates
        material.setCourse(course);
        material.setSemester(semester);
        material.setCategory(category);
        material.setTitle(title);
        material.setDescription(description);

        Part filePart = null;
        try {
            filePart = request.getPart("file");
        } catch (Exception e) {
            request.setAttribute("error", "Error reading file upload: " + e.getMessage());
            request.setAttribute("material", material);
            request.getRequestDispatcher("admin/updateMaterial.jsp").forward(request, response);
            return;
        }

        String oldFilePath = null;
        boolean fileReplaced = false;

        if (filePart != null && filePart.getSize() > 0) {
            // Validate File Size
            if (filePart.getSize() > MAX_FILE_SIZE) {
                request.setAttribute("error", "File size exceeds the maximum limit of 20 MB.");
                request.setAttribute("material", material);
                request.getRequestDispatcher("admin/updateMaterial.jsp").forward(request, response);
                return;
            }

            // Validate File Type
            String fileName = getFileName(filePart);
            String ext = "";
            int dotIdx = fileName.lastIndexOf('.');
            if (dotIdx > 0) {
                ext = fileName.substring(dotIdx).toLowerCase();
            }

            List<String> allowedExts = Arrays.asList(".pdf", ".doc", ".docx", ".ppt", ".pptx", ".xls", ".xlsx", ".zip", ".jpg", ".jpeg", ".png");
            if (!allowedExts.contains(ext)) {
                request.setAttribute("error", "Invalid file type. Only PDF, DOC, DOCX, PPT, PPTX, XLS, XLSX, ZIP, JPG, JPEG, and PNG are allowed.");
                request.setAttribute("material", material);
                request.getRequestDispatcher("admin/updateMaterial.jsp").forward(request, response);
                return;
            }

            try {
                // Save the path of old file to delete on successful database update
                oldFilePath = material.getFilePath();
                
                // Write new physical file
                String uniqueName = "material_" + System.currentTimeMillis() + "_" + fileName;
                String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "study-materials";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(uploadPath + File.separator + uniqueName);
                
                material.setFileName(fileName);
                material.setFileType(ext.replace(".", "").toUpperCase());
                material.setFilePath("uploads/study-materials/" + uniqueName);
                fileReplaced = true;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error uploading replacement file: " + e.getMessage());
                request.setAttribute("material", material);
                request.getRequestDispatcher("admin/updateMaterial.jsp").forward(request, response);
                return;
            }
        }

        // Save modifications to database
        boolean success = materialDAO.updateMaterial(material);
        if (success) {
            // Delete old physical file if it was replaced
            if (fileReplaced && oldFilePath != null) {
                String oldAbsolutePath = request.getServletContext().getRealPath("") + File.separator + oldFilePath.replace("/", File.separator);
                File oldFile = new File(oldAbsolutePath);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }
            response.sendRedirect("StudyMaterialsServlet");
        } else {
            // If DB update failed but we wrote a new file, clean it up
            if (fileReplaced) {
                String absolutePath = request.getServletContext().getRealPath("") + File.separator + material.getFilePath().replace("/", File.separator);
                File createdFile = new File(absolutePath);
                if (createdFile.exists()) {
                    createdFile.delete();
                }
            }
            request.setAttribute("error", "Failed to update study material details in the database.");
            request.setAttribute("material", material);
            request.getRequestDispatcher("admin/updateMaterial.jsp").forward(request, response);
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
