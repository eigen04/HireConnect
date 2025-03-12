package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.dao.DBConnection;

@WebServlet("/JobApplicationsServlet")
public class ApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");

        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ArrayList<String> applications = new ArrayList<>();

        try (Connection con = DBConnection.getConn()) {
            String query = "SELECT status FROM applications WHERE user_email=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, userEmail);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                applications.add(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("applications", applications);
        request.getRequestDispatcher("myApplications.jsp").forward(request, response);
    }
}