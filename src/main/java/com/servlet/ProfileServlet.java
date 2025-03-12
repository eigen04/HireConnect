package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.DBConnection;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");  // Fixed parameter name
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String skills = request.getParameter("skills");

        try {
            Connection con = DBConnection.getConn();
            if (con == null) {
                response.getWriter().write("DB connection failed");
                return;
            }
            PreparedStatement ps = con.prepareStatement("UPDATE users SET full_name=?, email=?, phone=?, skills=? WHERE user_id=?");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, skills);
            ps.setInt(5, userId);

            int updated = ps.executeUpdate();
            if (updated > 0) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}

