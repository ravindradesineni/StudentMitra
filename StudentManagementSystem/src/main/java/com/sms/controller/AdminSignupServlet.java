package com.sms.controller;

import java.io.IOException;

import com.sms.dao.AdminDAO;
import com.sms.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminSignupServlet")
public class AdminSignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check password confirmation
        if (!password.equals(confirmPassword)) {

            response.getWriter().println("<h2>Passwords do not match!</h2>");

            return;
        }

        Admin admin = new Admin();

        admin.setFullName(fullName);
        admin.setEmail(email);
        admin.setUsername(username);
        admin.setPassword(password);

        AdminDAO dao = new AdminDAO();

     // Check if username already exists
        if (dao.isUsernameExists(username)) {

            request.setAttribute("error", "Username already exists!");

            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("username", username);

            request.getRequestDispatcher("admin/signup.jsp")
                   .forward(request, response);

            return;
        }
        if (dao.isEmailExists(email)) {

            request.setAttribute("error", "Email is already registered!");

            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("username", username);

            request.getRequestDispatcher("admin/signup.jsp")
                   .forward(request, response);

            return;
        }

     // Save new admin
     boolean status = dao.addAdmin(admin);

     if (status) {

    	    request.setAttribute("success", "Account created successfully! Redirecting to Login...");

    	    request.getRequestDispatcher("admin/signup.jsp")
    	           .forward(request, response);

    	} else {

    		 request.setAttribute("error",
    		            "Failed to create account!");

    		    request.setAttribute("fullName", fullName);
    		    request.setAttribute("email", email);
    		    request.setAttribute("username", username);

    		    request.getRequestDispatcher("admin/signup.jsp")
    		           .forward(request, response);

    	}

    }

}