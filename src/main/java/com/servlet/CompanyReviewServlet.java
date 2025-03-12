package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CompanyReviewServlet")
public class CompanyReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String companyName = request.getParameter("companyName"); // Get company name from form
        String reviewText = request.getParameter("reviewText");
        int rating = Integer.parseInt(request.getParameter("rating"));

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hireconnect_db", "root", "anant2004");

            // Get recruiter_id from company_name
            String recruiterQuery = "SELECT recruiter_id FROM recruiters WHERE company_name = ?";
            PreparedStatement recruiterStmt = conn.prepareStatement(recruiterQuery);
            recruiterStmt.setString(1, companyName);
            ResultSet recruiterRs = recruiterStmt.executeQuery();

            int recruiterId = 0;
            if (recruiterRs.next()) {
                recruiterId = recruiterRs.getInt("recruiter_id");
            } else {
                // If no recruiter found, redirect with an error
                response.sendRedirect("jobseeker/dashboard.jsp?error=companyNotFound");
                return;
            }

            // Insert the review into the company_reviews table
            String query = "INSERT INTO company_reviews (user_id, recruiter_id, review_text, rating) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            stmt.setInt(2, recruiterId);
            stmt.setString(3, reviewText);
            stmt.setInt(4, rating);

            stmt.executeUpdate();

            // Clean up
            stmt.close();
            recruiterStmt.close();
            conn.close();

            // Redirect back to the dashboard with success message
            response.sendRedirect("jobseeker/dashboard.jsp?success=reviewSubmitted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jobseeker/dashboard.jsp?error=reviewSubmissionFailed");
        }
    }
}
