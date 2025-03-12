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

@WebServlet("/UpdateApplicationStatusServlet")
public class UpdateApplicationStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int applicationId = Integer.parseInt(request.getParameter("application_id"));
            String status = request.getParameter("status");

            System.out.println("Updating Application ID: " + applicationId + " to status: " + status);

            String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
            String dbUser = "root";
            String dbPassword = "anant2004";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Update the status in the applications table
            String query = "UPDATE applications SET status = ? WHERE application_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, status);
            stmt.setInt(2, applicationId);
            int rowsUpdated = stmt.executeUpdate();
            stmt.close();

            if (rowsUpdated > 0) {
                System.out.println("Application status updated successfully!");

                // If status is "Interview", first check if an interview is already scheduled
                if ("Interview".equals(status)) {
                    String checkQuery = "SELECT COUNT(*) FROM interviews WHERE application_id = ?";
                    PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                    checkStmt.setInt(1, applicationId);
                    ResultSet resultSet = checkStmt.executeQuery();
                    resultSet.next();
                    int count = resultSet.getInt(1);
                    checkStmt.close();

                    if (count == 0) {  // Only insert if no existing interview for this application_id
                        String insertInterviewQuery = "INSERT INTO interviews (application_id, interview_date, interview_mode, meeting_link, status) VALUES (?, NOW(), ?, ?, ?)";
                        PreparedStatement interviewStmt = conn.prepareStatement(insertInterviewQuery);
                        interviewStmt.setInt(1, applicationId);
                        interviewStmt.setString(2, "Online"); // Default mode (change if needed)
                        interviewStmt.setString(3, ""); // Meeting link can be updated later
                        interviewStmt.setString(4, "Scheduled");
                        interviewStmt.executeUpdate();
                        interviewStmt.close();

                        System.out.println("Interview scheduled for Application ID: " + applicationId);
                    } else {
                        System.out.println("Interview already scheduled for Application ID: " + applicationId);
                    }
                }

                response.sendRedirect(request.getContextPath() + "/recruiter/recruiterDashboard.jsp");
            } else {
                System.out.println("Error: No rows updated. Check application_id.");
                response.getWriter().println("Error: No matching application found.");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error occurred while updating the application status: " + e.getMessage());
        }
    }
}

