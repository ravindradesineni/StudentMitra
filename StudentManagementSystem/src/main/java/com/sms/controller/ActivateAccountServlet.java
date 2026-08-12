package com.sms.controller;

import java.io.IOException;

import com.sms.dao.StudentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ActivateAccountServlet")
public class ActivateAccountServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentId = Integer.parseInt(request.getParameter("studentId"));

        String defaultPassword = request.getParameter("defaultPassword");

        String newPassword = request.getParameter("newPassword");

        String confirmPassword = request.getParameter("confirmPassword");

        // Check Password Match

        if (!newPassword.equals(confirmPassword)) {

            request.setAttribute("error", "Passwords do not match!");

            request.getRequestDispatcher("student/activateAccount.jsp")
                   .forward(request, response);

            return;

        }

        StudentDAO dao = new StudentDAO();

        boolean status = dao.activateAccount(studentId,
                                             defaultPassword,
                                             newPassword);

        if (status) {

            request.setAttribute("success",
                    "Account Activated Successfully! Redirecting to Login...");

            request.getRequestDispatcher("student/activateAccount.jsp")
                   .forward(request, response);

        } else {

            request.setAttribute("error",
                    "Invalid Student ID or Default Password!");

            request.getRequestDispatcher("student/activateAccount.jsp")
                   .forward(request, response);

        }

    }

}