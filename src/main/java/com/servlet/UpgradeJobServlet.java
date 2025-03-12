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

@WebServlet("/UpgradeJobServlet")
public class UpgradeJobServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jobId = request.getParameter("job_id");

        if (jobId == null) {
            response.sendRedirect("/recruiter/recruiterDashboard.jsp");
            return;
        }

        try {
            String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
            String dbUser = "root";
            String dbPassword = "anant2004";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Mark the job as premium
            String query = "UPDATE jobs SET is_premium = 1 WHERE job_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(jobId));
            stmt.executeUpdate();

            stmt.close();
            conn.close();

            response.sendRedirect("recruiter/confirmation.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/recruiter/recruiterDashboard.jsp?error=true");
        }
    }
}
