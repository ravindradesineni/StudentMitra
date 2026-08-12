	package com.sms.controller;
	import jakarta.servlet.http.HttpSession;
	
	import java.io.IOException;
	
	import com.sms.dao.AdminDAO;
	
	import jakarta.servlet.ServletException;
	import jakarta.servlet.annotation.WebServlet;
	import jakarta.servlet.http.HttpServlet;
	import jakarta.servlet.http.HttpServletRequest;
	import jakarta.servlet.http.HttpServletResponse;
	
	@WebServlet("/AdminLoginServlet")
	public class AdminLoginServlet extends HttpServlet {
	
	    private static final long serialVersionUID = 1L;
	
	    public AdminLoginServlet() {
	        super();
	    }
	
	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	
	        // Get data from login form
	        String username = request.getParameter("username");
	        String password = request.getParameter("password");
	
	        // Create DAO object
	        AdminDAO adminDAO = new AdminDAO();
	
	        // Check login
	        boolean status = adminDAO.validateAdmin(username, password);
	
	        if (status) {
	
	            HttpSession session = request.getSession();
	
	            session.setAttribute("admin", username);
	
	            response.sendRedirect("DashboardServlet");
	
	        }else{
	
	            request.setAttribute("error", "Invalid Username or Password!");
	
	            request.getRequestDispatcher("admin/login.jsp")
	                   .forward(request, response);
	
	        }
	    }
	
	}
