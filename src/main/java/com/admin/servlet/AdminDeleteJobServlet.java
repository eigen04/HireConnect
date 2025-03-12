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

@WebServlet("/admin/AdminDeleteJobServlet")
public class AdminDeleteJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int jobId = Integer.parseInt(request.getParameter("jobId"));

        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM jobs WHERE job_id=?")) {
            ps.setInt(1, jobId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/adminDashboard.jsp");
    }
}
