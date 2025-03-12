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
import javax.servlet.RequestDispatcher;

@WebServlet("/ViewInterviewDetailsServlet")
public class ViewInterviewDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String interviewId = request.getParameter("interview_id");
        System.out.println("Received interview_id: " + interviewId); // Debugging

        if (interviewId == null || interviewId.isEmpty()) {
            System.out.println("ERROR: Missing interview_id, redirecting...");
            response.sendRedirect("recruiter/recruiterDashboard.jsp");
            return;
        }
        
        try {
            String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
            String dbUser = "root";
            String dbPassword = "anant2004";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String query = "SELECT i.interview_id, u.full_name, j.title, i.interview_date, " +
                    "DATE_FORMAT(i.interview_date, '%H:%i:%s') AS interview_time, " +
                    "i.interview_mode, COALESCE(i.additional_notes, '') AS additional_notes " +  
                    "FROM interviews i " +
                    "JOIN applications a ON i.application_id = a.application_id " +
                    "JOIN jobs j ON a.job_id = j.job_id " +
                    "JOIN job_seekers js ON a.seeker_id = js.seeker_id " +  // Added space
                    "JOIN users u ON js.user_id = u.user_id " +  // Added space
                    "WHERE i.interview_id = ?";



            
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(interviewId));
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                System.out.println("✅ Interview details found: " + rs.getString("full_name"));
                
                request.setAttribute("interviewId", rs.getInt("interview_id"));
                request.setAttribute("applicantName", rs.getString("full_name"));
                request.setAttribute("jobTitle", rs.getString("title"));
                request.setAttribute("interviewDate", rs.getDate("interview_date"));
                request.setAttribute("interviewTime", rs.getString("interview_time"));
                request.setAttribute("interviewMode", rs.getString("interview_mode"));
                request.setAttribute("additionalNotes", rs.getString("additional_notes"));

                RequestDispatcher dispatcher = request.getRequestDispatcher("/recruiter/interviewDetails.jsp");
                dispatcher.forward(request, response);
            } else {
                System.out.println("⚠️ No interview found with ID: " + interviewId);
                response.sendRedirect("recruiter/recruiterDashboard.jsp");
            }
            
            stmt.close();
            conn.close();
        } catch (Exception e) {
            System.out.println("❌ Error in ViewInterviewDetailsServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("recruiter/recruiterDashboard.jsp");
        }
    }
}



