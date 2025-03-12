package com.servlet;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import com.dao.DBConnection;

@WebServlet("/HireConnect/RegisterServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String role = request.getParameter("userType");
        String phone = request.getParameter("phone");

        if (role == null || role.isEmpty()) {
            request.setAttribute("error", "Please select a user type.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

        try (Connection conn = DBConnection.getConn()) {
            String userInsertQuery = "INSERT INTO users (full_name, email, password, role, phone) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement userStmt = conn.prepareStatement(userInsertQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            userStmt.setString(1, fullName);
            userStmt.setString(2, email);
            userStmt.setString(3, hashedPassword);
            userStmt.setString(4, role);
            userStmt.setString(5, phone);
            userStmt.executeUpdate();

            ResultSet rs = userStmt.getGeneratedKeys();
            int userId = 0;
            if (rs.next()) {
                userId = rs.getInt(1);
            }

            if ("recruiter".equals(role)) {
                String companyName = request.getParameter("company");
                String companyWebsite = request.getParameter("website");

                String recruiterInsertQuery = "INSERT INTO recruiters (user_id, company_name, company_website) VALUES (?, ?, ?)";
                PreparedStatement recruiterStmt = conn.prepareStatement(recruiterInsertQuery);
                recruiterStmt.setInt(1, userId);
                recruiterStmt.setString(2, companyName);
                recruiterStmt.setString(3, companyWebsite);
                recruiterStmt.executeUpdate();
            } else if ("job_seeker".equals(role)) {
                String resumePath = request.getParameter("resume_path");
                String skills = request.getParameter("skills");
                int experience = Integer.parseInt(request.getParameter("experience"));

                String seekerInsertQuery = "INSERT INTO job_seekers (user_id, resume_path, skills, experience) VALUES (?, ?, ?, ?)";
                PreparedStatement seekerStmt = conn.prepareStatement(seekerInsertQuery);
                seekerStmt.setInt(1, userId);
                seekerStmt.setString(2, resumePath);
                seekerStmt.setString(3, skills);
                seekerStmt.setInt(4, experience);
                seekerStmt.executeUpdate();
            }

            HttpSession session = request.getSession();
            session.setAttribute("user_id", userId);
            session.setAttribute("role", role);

            if ("employer".equals(role)) {
                response.sendRedirect("employerDashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration failed. Try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
