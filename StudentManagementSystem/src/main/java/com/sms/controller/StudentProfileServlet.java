package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.sms.dao.StudentDAO;
import com.sms.dao.AttendanceDAO;
import com.sms.dao.MarksDAO;
import com.sms.model.Student;
import com.sms.model.Attendance;
import com.sms.model.Marks;

@WebServlet("/StudentProfileServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,  // 1MB
    maxFileSize = 1024 * 1024 * 2,       // 2MB max for profile picture
    maxRequestSize = 1024 * 1024 * 10    // 10MB
)
public class StudentProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        StudentDAO studentDAO = new StudentDAO();
        // Load latest details from database to ensure fresh content
        Student freshStudent = studentDAO.getStudentById(student.getStudentId());
        
        if (freshStudent == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        // Calculate Overall Attendance Percentage
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        ArrayList<Attendance> attendanceList = attendanceDAO.getAttendanceByStudentId(freshStudent.getStudentId());
        int totalClasses = 0;
        int attendedClasses = 0;
        for (Attendance att : attendanceList) {
            totalClasses += att.getTotalClasses();
            attendedClasses += att.getAttendedClasses();
        }
        double overallAttendance = 100.0;
        if (totalClasses > 0) {
            overallAttendance = ((double) attendedClasses / totalClasses) * 100.0;
        }

        // Retrieve subject marks
        MarksDAO marksDAO = new MarksDAO();
        ArrayList<Marks> marksList = marksDAO.getMarksByStudentId(freshStudent.getStudentId());

        request.setAttribute("student", freshStudent);
        request.setAttribute("overallAttendance", overallAttendance);
        request.setAttribute("marksList", marksList);

        request.getRequestDispatcher("student/studentProfile.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String emergencyContact = request.getParameter("emergencyContact");

        StudentDAO studentDAO = new StudentDAO();
        Student latestStudent = studentDAO.getStudentById(student.getStudentId());

        if (latestStudent == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        latestStudent.setPhone(phone);
        latestStudent.setAddress(address);
        latestStudent.setEmergencyContact(emergencyContact);

        try {
            Part filePart = request.getPart("profilePicture");
            if (filePart != null && filePart.getSize() > 0) {
                // Validate size
                if (filePart.getSize() > 1024 * 1024 * 2) {
                    request.setAttribute("error", "Maximum image size should be 2 MB.");
                    doGet(request, response);
                    return;
                }

                String fileName = getFileName(filePart);
                String ext = "";
                int dotIdx = fileName.lastIndexOf('.');
                if (dotIdx > 0) {
                    ext = fileName.substring(dotIdx).toLowerCase();
                }

                if (ext.equals(".jpg") || ext.equals(".jpeg") || ext.equals(".png")) {
                    String uniqueName = "student_" + latestStudent.getStudentId() + "_" + System.currentTimeMillis() + ext;
                    String uploadPath = request.getServletContext().getRealPath("") + java.io.File.separator + "uploads" + java.io.File.separator + "students";
                    java.io.File uploadDir = new java.io.File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    // Delete old photo if it exists and is not default
                    String oldPhotoPath = latestStudent.getProfilePhoto();
                    if (oldPhotoPath != null && !oldPhotoPath.isEmpty() && !oldPhotoPath.contains("default-avatar.png")) {
                        String realPath = request.getServletContext().getRealPath("") + java.io.File.separator + oldPhotoPath;
                        java.io.File oldFile = new java.io.File(realPath);
                        if (oldFile.exists()) {
                            oldFile.delete();
                        }
                    }

                    filePart.write(uploadPath + java.io.File.separator + uniqueName);
                    latestStudent.setProfilePhoto("uploads/students/" + uniqueName);
                } else {
                    request.setAttribute("error", "Invalid file type. Only JPG, JPEG, and PNG are allowed.");
                    doGet(request, response);
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Upload failed: " + e.getMessage());
            doGet(request, response);
            return;
        }

        boolean success = studentDAO.updateStudent(latestStudent);
        if (success) {
            session.setAttribute("student", latestStudent); // Update session student
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile details.");
        }

        doGet(request, response);
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