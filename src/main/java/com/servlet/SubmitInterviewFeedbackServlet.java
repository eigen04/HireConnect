package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SubmitInterviewFeedbackServlet")
public class SubmitInterviewFeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int interviewId = Integer.parseInt(request.getParameter("interview_id"));
        String feedback = request.getParameter("feedback");
        int rating = Integer.parseInt(request.getParameter("rating"));

        String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
        String dbUser = "root";
        String dbPassword = "anant2004";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            String query = "INSERT INTO interview_feedback (interview_id, feedback, rating) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, interviewId);
            stmt.setString(2, feedback);
            stmt.setInt(3, rating);
            stmt.executeUpdate();
            stmt.close();
            conn.close();

            response.sendRedirect("recruiter/recruiterDashboard.jsp"); // Redirect back to the dashboard after submitting feedback
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
