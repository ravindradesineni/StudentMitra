package com.sms.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        request.getRequestDispatcher("student/changePassword.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirm password do not match!");
            request.getRequestDispatcher("student/changePassword.jsp").forward(request, response);
            return;
        }

        StudentDAO studentDAO = new StudentDAO();
        boolean status = studentDAO.changePassword(student.getStudentId(), currentPassword, newPassword);

        if (status) {
            // Update password in session
            student.setPassword(newPassword);
            session.setAttribute("student", student);
            request.setAttribute("success", "Password updated successfully!");
        } else {
            request.setAttribute("error", "Incorrect current password!");
        }

        request.getRequestDispatcher("student/changePassword.jsp").forward(request, response);
    }
}
