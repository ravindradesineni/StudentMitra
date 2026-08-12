package com.sms.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.StudyMaterialDAO;
import com.sms.dao.CourseDAO;
import com.sms.model.StudyMaterial;
import com.sms.model.Course;

@WebServlet("/UpdateMaterialServlet")
public class UpdateMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            StudyMaterialDAO materialDAO = new StudyMaterialDAO();
            StudyMaterial material = materialDAO.getMaterialById(id);

            if (material != null) {
                CourseDAO courseDAO = new CourseDAO();
                ArrayList<Course> courseList = courseDAO.getAllCourses();

                request.setAttribute("material", material);
                request.setAttribute("courseList", courseList);
                request.getRequestDispatcher("admin/updateMaterial.jsp").forward(request, response);
            } else {
                response.sendRedirect("StudyMaterialsServlet");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("StudyMaterialsServlet");
        }
    }
}
