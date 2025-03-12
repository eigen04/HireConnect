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

@WebServlet("/DeleteJobServlet")
public class DeleteJobServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

            // First, delete related entries in job_alerts
            String deleteAlertsQuery = "DELETE FROM job_alerts WHERE job_id = ?";
            PreparedStatement stmtAlerts = conn.prepareStatement(deleteAlertsQuery);
            stmtAlerts.setInt(1, Integer.parseInt(jobId));
            stmtAlerts.executeUpdate();

            // Now, delete the job
            String deleteJobQuery = "DELETE FROM jobs WHERE job_id = ?";
            PreparedStatement stmtJob = conn.prepareStatement(deleteJobQuery);
            stmtJob.setInt(1, Integer.parseInt(jobId));
            stmtJob.executeUpdate();

            stmtAlerts.close();
            stmtJob.close();
            conn.close();

            // Redirect or send a success message after deletion
            response.sendRedirect("/recruiter/recruiterDashboard.jsp?deleteSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/recruiter/recruiterDashboard.jsp?deleteError=true");
        }
    }
}
