package com.servlet;

import com.razorpay.*;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jobId = request.getParameter("job_id");
        String paymentId = request.getParameter("payment_id");

        if (jobId == null || paymentId == null) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        try {
            RazorpayClient client = new RazorpayClient("rzp_test_xxxxxxx", "your_secret_key");

            Payment payment = client.payments.fetch(paymentId);

            if ("captured".equals(payment.get("status"))) {
                // Payment successful, update DB
                String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
                String dbUser = "root";
                String dbPassword = "anant2004";
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                String query = "UPDATE jobs SET is_premium = 1 WHERE job_id = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, Integer.parseInt(jobId));
                stmt.executeUpdate();

                stmt.close();
                conn.close();

                response.sendRedirect("/recruiter/recruiterDashboard.jsp?paymentSuccess=true");
            } else {
                response.sendRedirect("paymentFailed.jsp"); // Handle failure
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("paymentFailed.jsp"); 
        }
    }
}
