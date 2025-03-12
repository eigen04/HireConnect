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

@WebServlet("/UpdateJobServlet")
public class UpdateJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get job details from the form
        int jobId = Integer.parseInt(request.getParameter("job_id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String category = request.getParameter("category");
        String salaryRange = request.getParameter("salary_range");
        String jobType = request.getParameter("job_type");

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
        String dbUser = "root";
        String dbPassword = "anant2004";

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to update job details
            String sql = "UPDATE jobs SET title = ?, description = ?, location = ?, category = ?, salary_range = ?, job_type = ? WHERE job_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Set parameters
            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, location);
            stmt.setString(4, category);
            stmt.setString(5, salaryRange);
            stmt.setString(6, jobType);
            stmt.setInt(7, jobId);

            // Execute update
            int rowsUpdated = stmt.executeUpdate();
            stmt.close();
            conn.close();

            // Redirect after successful update
            if (rowsUpdated > 0) {
                response.sendRedirect("recruiter/recruiterDashboard.jsp?success=job_updated");
            } else {
                response.sendRedirect("recruiter/recruiterDashboard.jsp?error=update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("recruiterDashboard.jsp?error=exception");
        }
    }
}
