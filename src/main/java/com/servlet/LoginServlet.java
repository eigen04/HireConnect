package com.servlet;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import com.dao.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Hardcoded admin login
        if ("admin@gmail.com".equals(email) && "admin@2004".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user_id", 1);
            session.setAttribute("role", "admin");
            session.setAttribute("email", email);
            session.setAttribute("full_name", "Admin User"); // Set default admin name
            response.sendRedirect("admin/adminDashboard.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConn()) {
            String query = "SELECT user_id, full_name, password, role FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String fullName = rs.getString("full_name"); // Fetch full_name
                String storedHashedPassword = rs.getString("password");
                String role = rs.getString("role");

                if (BCrypt.checkpw(password, storedHashedPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user_id", userId);
                    session.setAttribute("full_name", fullName); // Store full_name in session
                    session.setAttribute("role", role);
                    session.setAttribute("email", email);

                    if (role.equalsIgnoreCase("recruiter")) {
                        // Fetch recruiter_id from the recruiters table
                        String recruiterQuery = "SELECT recruiter_id FROM recruiters WHERE user_id = ?";
                        PreparedStatement recruiterStmt = conn.prepareStatement(recruiterQuery);
                        recruiterStmt.setInt(1, userId);
                        ResultSet recruiterRs = recruiterStmt.executeQuery();

                        if (recruiterRs.next()) {
                            int recruiterId = recruiterRs.getInt("recruiter_id");
                            session.setAttribute("recruiter_id", recruiterId); // Set recruiter_id in session
                        }

                        recruiterRs.close();
                        recruiterStmt.close();

                        response.sendRedirect("recruiter/recruiterDashboard.jsp");
                    } else if (role.equalsIgnoreCase("admin")) {
                        response.sendRedirect("admin/adminDashboard.jsp");
                    } else { // Job Seeker
                        // Fetch seeker_id from the job_seekers table
                        String seekerQuery = "SELECT seeker_id FROM job_seekers WHERE user_id = ?";
                        PreparedStatement seekerStmt = conn.prepareStatement(seekerQuery);
                        seekerStmt.setInt(1, userId);
                        ResultSet seekerRs = seekerStmt.executeQuery();

                        if (seekerRs.next()) {
                            int seekerId = seekerRs.getInt("seeker_id");
                            session.setAttribute("seeker_id", seekerId); // Set seeker_id in session
                        }

                        seekerRs.close();
                        seekerStmt.close();

                        response.sendRedirect("jobseeker/dashboard.jsp");
                    }

                } else {
                    request.setAttribute("error", "Invalid email or password.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }

                rs.close();
                stmt.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Login failed. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
