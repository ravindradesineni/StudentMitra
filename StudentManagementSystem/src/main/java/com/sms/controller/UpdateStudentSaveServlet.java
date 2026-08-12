package com.sms.controller;

import java.io.IOException;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateStudentSaveServlet")
public class UpdateStudentSaveServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentId = Integer.parseInt(request.getParameter("studentId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String department = request.getParameter("department");
        int year = Integer.parseInt(request.getParameter("year"));
        String password = request.getParameter("password");
        String course = request.getParameter("course");
        String semester = request.getParameter("semester");
        String emergencyContact = request.getParameter("emergencyContact");
        String status = request.getParameter("status");
        String address = request.getParameter("address");

        StudentDAO dao = new StudentDAO();
        Student existing = dao.getStudentById(studentId);

        Student student = new Student();

        student.setStudentId(studentId);
        student.setFullName(fullName);
        student.setEmail(email);
        student.setPhone(phone);
        student.setGender(gender);
        student.setDob(dob);
        student.setDepartment(department);
        student.setYear(year);
        student.setPassword(password);
        student.setCourse(course);
        student.setSemester(semester);
        student.setEmergencyContact(emergencyContact);
        student.setStatus(status);
        student.setAddress(address);
        student.setProfilePhoto(existing != null ? existing.getProfilePhoto() : "uploads/students/default-avatar.png");

        boolean statusFlag = dao.updateStudent(student);

        if (statusFlag) {

            response.sendRedirect("StudentsServlet");

        } else {

            response.getWriter().println("<h2>Student Update Failed!</h2>");

        }

    }

}