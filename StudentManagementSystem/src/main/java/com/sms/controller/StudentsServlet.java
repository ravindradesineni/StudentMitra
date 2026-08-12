package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/StudentsServlet")
public class StudentsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        StudentDAO studentDAO = new StudentDAO();

        ArrayList<Student> studentList;

        String keyword = request.getParameter("search");

        if (keyword != null && !keyword.trim().isEmpty()) {

            studentList = studentDAO.searchStudents(keyword);

        } else {

            studentList = studentDAO.getAllStudents();

        }

        request.setAttribute("studentList", studentList);

        request.getRequestDispatcher("admin/students.jsp")
               .forward(request, response);

    }

}