package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.sms.dao.DepartmentDAO;
import com.sms.model.Department;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DepartmentSummaryServlet")
public class DepartmentSummaryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DepartmentDAO dao = new DepartmentDAO();

        ArrayList<Department> departmentList = dao.getDepartmentSummary();

        request.setAttribute("departmentList", departmentList);

        request.getRequestDispatcher("admin/departmentSummary.jsp")
               .forward(request, response);
    }
}