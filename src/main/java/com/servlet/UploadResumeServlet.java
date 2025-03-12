package com.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet("/UploadResumeServlet")
public class UploadResumeServlet extends HttpServlet {
    private static final String SAVE_DIR = "uploads"; // Folder where resumes will be saved

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get Job Seeker ID from session
        Integer seekerId = (Integer) request.getSession().getAttribute("seeker_id");

        // Check if seekerId is null
        if (seekerId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Seeker ID is missing.");
            return; // stop execution if seekerId is not available
        }

        // Get upload path
        String uploadPath = getServletContext().getRealPath("") + File.separator + SAVE_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        // Get file part
        Part filePart = request.getPart("resume");
        String fileName = filePart.getSubmittedFileName();
        String filePath = uploadPath + File.separator + fileName;

        // Save file on server
        filePart.write(filePath);

        // Save file path in database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hireconnect_db", "root", "anant2004");

            // Check if resume already exists for this seeker
            PreparedStatement checkStmt = conn.prepareStatement("SELECT resume_id FROM resumes WHERE seeker_id = ?");
            checkStmt.setInt(1, seekerId);
            if (checkStmt.executeQuery().next()) {
                // Update existing resume
                PreparedStatement updateStmt = conn.prepareStatement("UPDATE resumes SET file_name = ?, file_path = ? WHERE seeker_id = ?");
                updateStmt.setString(1, fileName);
                updateStmt.setString(2, filePath);
                updateStmt.setInt(3, seekerId);
                updateStmt.executeUpdate();
            } else {
                // Insert new resume
                PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO resumes (seeker_id, file_name, file_path) VALUES (?, ?, ?)");
                insertStmt.setInt(1, seekerId);
                insertStmt.setString(2, fileName);
                insertStmt.setString(3, filePath);
                insertStmt.executeUpdate();
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("jobseeker/dashboard.jsp?uploadSuccess=true");
    }

}
