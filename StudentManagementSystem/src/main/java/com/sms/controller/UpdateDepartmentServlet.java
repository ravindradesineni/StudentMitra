package com.sms.controller;

import java.io.IOException;

import com.sms.dao.DepartmentDAO;
import com.sms.model.Department;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateDepartmentServlet")
public class UpdateDepartmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int departmentId = Integer.parseInt(request.getParameter("id"));

        DepartmentDAO departmentDAO = new DepartmentDAO();

        Department department = departmentDAO.getDepartmentById(departmentId);

        request.setAttribute("department", department);

        request.getRequestDispatcher("admin/updateDepartment.jsp")
               .forward(request, response);

    }

}