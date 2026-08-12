package com.sms.controller;

import java.io.IOException;

import com.sms.dao.DepartmentDAO;
import com.sms.model.Department;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateDepartmentSaveServlet")
public class UpdateDepartmentSaveServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        String departmentName = request.getParameter("departmentName");

        Department department = new Department();

        department.setDepartmentId(departmentId);
        department.setDepartmentName(departmentName);

        DepartmentDAO departmentDAO = new DepartmentDAO();

        boolean status = departmentDAO.updateDepartment(department);

        if (status) {

            response.sendRedirect("DepartmentsServlet");

        } else {

            response.getWriter().println("<h2>Department Update Failed!</h2>");

        }

    }

}