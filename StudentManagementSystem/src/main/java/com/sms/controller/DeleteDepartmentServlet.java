package com.sms.controller;

import java.io.IOException;

import com.sms.dao.DepartmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteDepartmentServlet")
public class DeleteDepartmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int departmentId = Integer.parseInt(request.getParameter("id"));

        DepartmentDAO departmentDAO = new DepartmentDAO();

        boolean status = departmentDAO.deleteDepartment(departmentId);

        if (status) {

            response.sendRedirect("DepartmentsServlet");

        } else {

            response.getWriter().println("<h2>Department Delete Failed!</h2>");

        }

    }

}