package com.sms.controller;

import java.io.IOException;
import java.io.File;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.StudyMaterialDAO;
import com.sms.model.StudyMaterial;

@WebServlet("/DeleteMaterialServlet")
public class DeleteMaterialServlet extends HttpServlet {
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
                // Delete physical file from disk
                String filePath = material.getFilePath();
                String absolutePath = request.getServletContext().getRealPath("") + File.separator + filePath.replace("/", File.separator);
                File file = new File(absolutePath);
                if (file.exists()) {
                    file.delete();
                }

                // Delete database record
                materialDAO.deleteMaterial(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("StudyMaterialsServlet");
    }
}
