package com.servlet;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PostJobServlet")
public class PostJobServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get job details from the form
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String category = request.getParameter("category");
        String salaryRange = request.getParameter("salary_range");
        String jobType = request.getParameter("job_type");

        // Get recruiter_id from session
        HttpSession session = request.getSession();
        Integer recruiterId = (Integer) session.getAttribute("recruiter_id");

        // Ensure recruiter_id exists
        if (recruiterId == null) {
            response.sendRedirect("login.jsp"); // Redirect if not logged in
            return;
        }

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
        String dbUser = "root";
        String dbPassword = "anant2004";

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to insert job details
            String sql = "INSERT INTO jobs (title, description, location, category, salary_range, job_type, recruiter_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Set parameters
            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, location);
            stmt.setString(4, category);
            stmt.setString(5, salaryRange);
            stmt.setString(6, jobType);
            stmt.setInt(7, recruiterId);

            // Execute update
            int rowsInserted = stmt.executeUpdate();
            stmt.close();
            conn.close();

            // Redirect after successful insertion
            if (rowsInserted > 0) {
                response.sendRedirect("recruiter/recruiterDashboard.jsp?success=job_posted");
            } else {
                response.sendRedirect("postJob.jsp?error=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("postJob.jsp?error=exception");
        }
    }

}
