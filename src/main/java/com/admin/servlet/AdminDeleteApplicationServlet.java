package com.admin.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.DBConnection;

@WebServlet("/admin/AdminDeleteApplicationServlet")
public class AdminDeleteApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the application ID from the request parameter
        int applicationId = Integer.parseInt(request.getParameter("applicationId"));

        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM applications WHERE application_id=?")) {

            // Set the application ID parameter in the query
            ps.setInt(1, applicationId);

            // Execute the update query to delete the application record
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // After deleting, redirect the admin to the admin dashboard page
        response.sendRedirect(request.getContextPath() + "/admin/adminDashboard.jsp");
    }
}
