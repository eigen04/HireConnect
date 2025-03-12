package com.servlet;

import java.io.File;
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

@WebServlet("/DeleteResumeServlet")
public class DeleteResumeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int seekerId = Integer.parseInt(request.getParameter("seeker_id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hireconnect_db", "root", "anant2004");

            // Step 1: Retrieve the resume path from the database
            PreparedStatement getStmt = conn.prepareStatement("SELECT file_path FROM resumes WHERE seeker_id = ?");
            getStmt.setInt(1, seekerId);
            ResultSet rs = getStmt.executeQuery();

            if (rs.next()) {
                String filePath = rs.getString("file_path");

                // Step 2: Delete the file from the server
                File file = new File(filePath);
                if (file.exists() && file.delete()) {
                    // Step 3: Delete the record from the database
                    PreparedStatement delStmt = conn.prepareStatement("DELETE FROM resumes WHERE seeker_id = ?");
                    delStmt.setInt(1, seekerId);
                    int rowsAffected = delStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        request.getSession().setAttribute("message", "Resume deleted successfully.");
                    } else {
                        request.getSession().setAttribute("message", "Failed to delete resume record from database.");
                    }
                } else {
                    request.getSession().setAttribute("message", "Failed to delete resume file.");
                }
            } else {
                request.getSession().setAttribute("message", "No resume found for deletion.");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "An error occurred. Please try again.");
        }

        // Redirect back to profile or dashboard page
        response.sendRedirect(request.getContextPath() + "/jobseeker/profile.jsp");
    }
}
