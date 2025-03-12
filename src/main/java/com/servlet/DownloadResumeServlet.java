package com.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/DownloadResumeServlet")
public class DownloadResumeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int seekerId = Integer.parseInt(request.getParameter("seeker_id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hireconnect_db", "root", "anant2004");
            PreparedStatement stmt = conn.prepareStatement("SELECT file_name, file_path FROM resumes WHERE seeker_id = ?");
            stmt.setInt(1, seekerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String fileName = rs.getString("file_name");
                String filePath = rs.getString("file_path");
                File file = new File(filePath);

                // Set response headers
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

                // Read and write file to response
                FileInputStream fileInputStream = new FileInputStream(file);
                OutputStream outStream = response.getOutputStream();
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }
                fileInputStream.close();
                outStream.close();
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
