package com.sms.controller;

import java.io.IOException;
import java.io.File;
import java.util.ArrayList;
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
import com.sms.dao.CourseDAO;
import com.sms.model.StudyMaterial;
import com.sms.model.Course;

@WebServlet("/UploadMaterialServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 25,       // Allow slightly larger boundary for request, validate strictly in code (20MB)
    maxRequestSize = 1024 * 1024 * 60     // 60MB
)
public class UploadMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final long MAX_FILE_SIZE = 20 * 1024 * 1024; // 20 MB strictly

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        CourseDAO courseDAO = new CourseDAO();
        ArrayList<Course> courseList = courseDAO.getAllCourses();
        request.setAttribute("courseList", courseList);

        request.getRequestDispatcher("admin/uploadMaterial.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        String course = request.getParameter("course");
        String semester = request.getParameter("semester");
        String category = request.getParameter("category");
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        Part filePart = null;
        try {
            filePart = request.getPart("file");
        } catch (Exception e) {
            request.setAttribute("error", "Error reading file upload: " + e.getMessage());
            doGet(request, response);
            return;
        }

        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "Please select a file to upload.");
            doGet(request, response);
            return;
        }

        // Validate File Size
        if (filePart.getSize() > MAX_FILE_SIZE) {
            request.setAttribute("error", "File size exceeds the maximum limit of 20 MB.");
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

        List<String> allowedExts = Arrays.asList(".pdf", ".doc", ".docx", ".ppt", ".pptx", ".xls", ".xlsx", ".zip", ".jpg", ".jpeg", ".png");
        if (!allowedExts.contains(ext)) {
            request.setAttribute("error", "Invalid file type. Only PDF, DOC, DOCX, PPT, PPTX, XLS, XLSX, ZIP, JPG, JPEG, and PNG are allowed.");
            doGet(request, response);
            return;
        }

        // Save File
        try {
            String uniqueName = "material_" + System.currentTimeMillis() + "_" + fileName;
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "study-materials";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(uploadPath + File.separator + uniqueName);
            String relativePath = "uploads/study-materials/" + uniqueName;

            StudyMaterial material = new StudyMaterial();
            material.setCourse(course);
            material.setSemester(semester);
            material.setCategory(category);
            material.setTitle(title);
            material.setDescription(description);
            material.setFileName(fileName);
            material.setFileType(ext.replace(".", "").toUpperCase());
            material.setFilePath(relativePath);

            StudyMaterialDAO materialDAO = new StudyMaterialDAO();
            boolean success = materialDAO.addMaterial(material);

            if (success) {
                response.sendRedirect("StudyMaterialsServlet");
            } else {
                // Delete uploaded file if DB register fails
                File physicalFile = new File(uploadPath + File.separator + uniqueName);
                if (physicalFile.exists()) {
                    physicalFile.delete();
                }
                request.setAttribute("error", "Failed to save file information in database.");
                doGet(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "File upload error: " + e.getMessage());
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
