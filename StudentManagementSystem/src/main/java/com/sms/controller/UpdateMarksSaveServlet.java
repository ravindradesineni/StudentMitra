package com.sms.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sms.dao.MarksDAO;
import com.sms.model.Marks;

@WebServlet("/UpdateMarksSaveServlet")
public class UpdateMarksSaveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        int marksId = Integer.parseInt(request.getParameter("marksId"));
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int internal1 = Integer.parseInt(request.getParameter("internal1"));
        int internal2 = Integer.parseInt(request.getParameter("internal2"));
        int assignment = Integer.parseInt(request.getParameter("assignment"));
        int finalExam = Integer.parseInt(request.getParameter("finalExam"));

        if (internal1 < 0 || internal1 > 20 || internal2 < 0 || internal2 > 20 ||
            assignment < 0 || assignment > 10 || finalExam < 0 || finalExam > 50) {
            request.setAttribute("error", "Marks limits exceeded! (Internal 1: 0-20, Internal 2: 0-20, Assignment: 0-10, Final Exam: 0-50)");
            request.getRequestDispatcher("UpdateMarksServlet?id=" + marksId).forward(request, response);
            return;
        }

        Marks marks = new Marks();
        marks.setMarksId(marksId);
        marks.setStudentId(studentId);
        marks.setCourseId(courseId);
        marks.setInternal1(internal1);
        marks.setInternal2(internal2);
        marks.setAssignment(assignment);
        marks.setFinalExam(finalExam);

        MarksDAO marksDAO = new MarksDAO();
        boolean status = marksDAO.updateMarks(marks);

        if (status) {
            response.sendRedirect("MarksServlet");
        } else {
            request.setAttribute("error", "Failed to update marks!");
            request.getRequestDispatcher("UpdateMarksServlet?id=" + marksId).forward(request, response);
        }
    }
}
