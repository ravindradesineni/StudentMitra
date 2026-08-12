package com.sms.controller;

import java.io.IOException;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddStudentServlet")
public class AddStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String department = request.getParameter("department");
        int year = Integer.parseInt(request.getParameter("year"));
        String course = request.getParameter("course");
        String semester = request.getParameter("semester");
        String emergencyContact = request.getParameter("emergencyContact");
        String status = request.getParameter("status");
        String address = request.getParameter("address");
        

        Student student = new Student();

        student.setFullName(fullName);
        student.setEmail(email);
        student.setPhone(phone);
        student.setGender(gender);
        student.setDob(dob);
        student.setDepartment(department);
        student.setYear(year);
        student.setCourse(course);
        student.setSemester(semester);
        student.setEmergencyContact(emergencyContact);
        student.setStatus(status != null ? status : "Active");
        student.setAddress(address);
        student.setProfilePhoto("uploads/students/default-avatar.png");
        

        StudentDAO studentDAO = new StudentDAO();

        boolean success = studentDAO.addStudent(student);

        if (success) {

            response.sendRedirect("StudentsServlet");

        } else {

            response.getWriter().println("<h2>Failed to Add Student!</h2>");

        }

    }

}