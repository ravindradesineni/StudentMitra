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

@WebServlet("/StudentStudyMaterialsServlet")
public class StudentStudyMaterialsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("student/login.jsp");
            return;
        }

        String search = request.getParameter("search");
        String course = request.getParameter("course");
        String semester = request.getParameter("semester");
        String category = request.getParameter("category");

        StudyMaterialDAO materialDAO = new StudyMaterialDAO();
        ArrayList<StudyMaterial> materialList = materialDAO.getAllMaterials(search, course, semester, category);

        // Fetch courses for filter dropdown
        CourseDAO courseDAO = new CourseDAO();
        ArrayList<Course> courseList = courseDAO.getAllCourses();

        request.setAttribute("materialList", materialList);
        request.setAttribute("courseList", courseList);

        request.setAttribute("search", search != null ? search : "");
        request.setAttribute("course", course != null ? course : "All");
        request.setAttribute("semester", semester != null ? semester : "All");
        request.setAttribute("category", category != null ? category : "All");

        request.getRequestDispatcher("student/studyMaterials.jsp").forward(request, response);
    }
}
