package com.sms.controller;

import java.io.IOException;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/StudentLoginServlet")
public class StudentLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentId = Integer.parseInt(request.getParameter("studentId"));
        String password = request.getParameter("password");

        StudentDAO studentDAO = new StudentDAO();

        Student student = studentDAO.validateStudent(studentId, password);

        if (student != null) {

            HttpSession session = request.getSession();

            session.setAttribute("student", student);

            response.sendRedirect("StudentDashboardServlet");

        } else {

            request.setAttribute("error", "Invalid Student ID or Password!");

            request.getRequestDispatcher("/student/login.jsp")
                   .forward(request, response);

        }

    }

}