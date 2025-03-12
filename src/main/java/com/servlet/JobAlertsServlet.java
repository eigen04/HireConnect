package com.servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.DBConnection;

@WebServlet("/JobAlertsServlet")
public class JobAlertsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String userIdStr = request.getParameter("user_id");
            String jobIdStr = request.getParameter("job_id");
            String redirect = request.getParameter("redirect");
            
            if (userIdStr == null || jobIdStr == null) {
                response.sendRedirect("jobseeker/viewJobs.jsp?alertSet=error&reason=missing_data");
                return;
            }
            
            int userId = Integer.parseInt(userIdStr);
            int jobId = Integer.parseInt(jobIdStr);
            
            Connection conn = DBConnection.getConn();
            String query = "INSERT INTO job_alerts (user_id, job_id) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            stmt.setInt(2, jobId);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
            
            // Check if we should redirect to dashboard
            if ("dashboard".equals(redirect)) {
                response.sendRedirect("jobseeker/dashboard.jsp?success=alertset");
            } else {
                response.sendRedirect("jobseeker/viewJobs.jsp?alertSet=success");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("jobseeker/viewJobs.jsp?alertSet=error&reason=invalid_input");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jobseeker/viewJobs.jsp?alertSet=error&reason=database_error");
        }
    }
}