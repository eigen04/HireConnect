package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.dao.DBConnection;

@WebServlet("/ApplyJobServlet")
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id"); // Get user ID from session
        String jobIdStr = request.getParameter("job_id");
        String redirect = request.getParameter("redirect");

        if (userId == null) {
            response.sendRedirect("login.jsp"); // Redirect if not logged in
            return;
        }

        if (jobIdStr == null || jobIdStr.isEmpty()) {
            response.sendRedirect("jobseeker/viewJobs.jsp?error=Invalid job ID");
            return;
        }

        try {
            int jobId = Integer.parseInt(jobIdStr);

            try (Connection conn = DBConnection.getConn()) {
                // Check if the user has already applied for this job
                String checkQuery = "SELECT application_id FROM applications WHERE job_id = ? AND seeker_id = (SELECT seeker_id FROM job_seekers WHERE user_id = ?)";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                    checkStmt.setInt(1, jobId);
                    checkStmt.setInt(2, userId);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next()) {
                            response.sendRedirect("jobseeker/viewJobs.jsp?error=already_applied");
                            return;
                        }
                    }
                }

                // Fetch seeker_id and email
                String query = "SELECT js.seeker_id, u.email FROM job_seekers js JOIN users u ON js.user_id = u.user_id WHERE js.user_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, userId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            int seekerId = rs.getInt("seeker_id");
                            String email = rs.getString("email");

                            // Insert into applications table
                            String insertQuery = "INSERT INTO applications (job_id, seeker_id, email, status) VALUES (?, ?, ?, 'Pending')";
                            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                                insertStmt.setInt(1, jobId);
                                insertStmt.setInt(2, seekerId);
                                insertStmt.setString(3, email);

                                int rowsInserted = insertStmt.executeUpdate();
                                if (rowsInserted > 0) {
                                    // Check if we should redirect to dashboard
                                    if ("dashboard".equals(redirect)) {
                                        response.sendRedirect("jobseeker/dashboard.jsp?success=applied");
                                    } else {
                                        response.sendRedirect("jobseeker/viewJobs.jsp?success=applied&job_id=" + jobId);
                                    }
                                    return;
                                } else {
                                    response.sendRedirect("jobseeker/viewJobs.jsp?error=failed");
                                    return;
                                }
                            }
                        } else {
                            response.sendRedirect("jobseeker/viewJobs.jsp?error=not_a_seeker");
                            return;
                        }
                    }
                }
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("jobseeker/viewJobs.jsp?error=invalid_format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jobseeker/viewJobs.jsp?error=server_error");
        }
    }
}