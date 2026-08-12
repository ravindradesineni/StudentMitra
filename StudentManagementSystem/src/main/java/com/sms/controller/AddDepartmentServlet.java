package com.sms.controller;

import java.io.IOException;

import com.sms.dao.DepartmentDAO;
import com.sms.model.Department;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddDepartmentServlet")
public class AddDepartmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String departmentName = request.getParameter("departmentName");

        Department department = new Department();

        department.setDepartmentName(departmentName);

        DepartmentDAO departmentDAO = new DepartmentDAO();

        boolean status = departmentDAO.addDepartment(department);

        if (status) {

            response.sendRedirect("DepartmentsServlet");

        } else {

            response.getWriter().println("<h2>Failed to Add Department!</h2>");

        }

    }

}