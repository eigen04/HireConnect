package com.servlet;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditJobServlet")
public class EditJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get job_id from request
        int jobId = Integer.parseInt(request.getParameter("job_id"));

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
        String dbUser = "root";
        String dbPassword = "anant2004";

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to retrieve job details by job_id
            String sql = "SELECT * FROM jobs WHERE job_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, jobId);

            // Execute query and get the job details
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Set job details as request attributes
                request.setAttribute("job_id", jobId);
                request.setAttribute("title", rs.getString("title"));
                request.setAttribute("description", rs.getString("description"));
                request.setAttribute("location", rs.getString("location"));
                request.setAttribute("category", rs.getString("category"));
                request.setAttribute("salary_range", rs.getString("salary_range"));
                request.setAttribute("job_type", rs.getString("job_type"));
            }

            stmt.close();
            conn.close();

            // Forward to edit job page
            request.getRequestDispatcher("recruiter/editJob.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("recruiterDashboard.jsp?error=exception");
        }
    }
}
