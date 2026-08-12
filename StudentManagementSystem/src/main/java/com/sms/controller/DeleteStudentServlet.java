package com.sms.controller;

import java.io.IOException;

import com.sms.dao.StudentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentId = Integer.parseInt(request.getParameter("id"));

        StudentDAO studentDAO = new StudentDAO();

        boolean status = studentDAO.deleteStudent(studentId);

        if (status) {

            response.sendRedirect("StudentsServlet");

        } else {

            response.getWriter().println("<h2>Failed to Delete Student!</h2>");

        }

    }

}