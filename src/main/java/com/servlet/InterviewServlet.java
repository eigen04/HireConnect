package com.servlet;

import java.io.IOException;
import java.sql.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.Properties;

@WebServlet("/InterviewServlet")
public class InterviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String applicationId = request.getParameter("application_id");
        String interviewDate = request.getParameter("interview_date");
        String interviewMode = request.getParameter("interview_mode");
        String meetingLink = request.getParameter("meeting_link");

        if ("Offline".equals(interviewMode)) {
            meetingLink = null;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hireconnect_db", "root", "anant2004");

            // Check if the application is accepted first
            String checkStatusQuery = "SELECT status FROM applications WHERE application_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkStatusQuery);
            checkStmt.setInt(1, Integer.parseInt(applicationId));
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                String appStatus = rs.getString("status");

                // Only allow scheduling an interview if the status is "Accepted"
                if ("Accepted".equals(appStatus)) {

                    // Check if interview is already scheduled
                    String checkInterviewQuery = "SELECT interview_id FROM interviews WHERE application_id = ?";
                    PreparedStatement checkInterviewStmt = conn.prepareStatement(checkInterviewQuery);
                    checkInterviewStmt.setInt(1, Integer.parseInt(applicationId));
                    ResultSet interviewRs = checkInterviewStmt.executeQuery();

                    if (interviewRs.next()) {
                        // Interview already scheduled, update it
                        String updateQuery = "UPDATE interviews SET interview_date = ?, interview_mode = ?, meeting_link = ?, status = 'Scheduled' WHERE application_id = ?";
                        stmt = conn.prepareStatement(updateQuery);
                        stmt.setString(1, interviewDate);
                        stmt.setString(2, interviewMode);
                        stmt.setString(3, meetingLink);
                        stmt.setInt(4, Integer.parseInt(applicationId));
                    } else {
                        // No interview found, insert a new record
                        String insertQuery = "INSERT INTO interviews (application_id, interview_date, interview_mode, meeting_link, status) VALUES (?, ?, ?, ?, 'Scheduled')";
                        stmt = conn.prepareStatement(insertQuery);
                        stmt.setInt(1, Integer.parseInt(applicationId));
                        stmt.setString(2, interviewDate);
                        stmt.setString(3, interviewMode);
                        stmt.setString(4, meetingLink);
                    }

                    int rows = stmt.executeUpdate();
                    if (rows > 0) {
                        response.sendRedirect("recruiter/viewApplications.jsp?msg=Interview Scheduled Successfully");
                    } else {
                        response.sendRedirect("recruiter/scheduleInterview.jsp?error=Failed to schedule interview");
                    }
                } else {
                    response.sendRedirect("recruiter/viewApplications.jsp?error=Only accepted applications can be scheduled for interviews");
                }
            } else {
                response.sendRedirect("recruiter/viewApplications.jsp?error=Application not found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("recruiter/scheduleInterview.jsp?error=Database error");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
    // ✅ Email Notification Function
    private void sendEmailNotification(String recipientEmail, String date, String mode, String meetingLink, String status) {
        String host = "smtp.gmail.com";
        String port = "587";
        String senderEmail = "hireconnect.notifications@gmail.com";
        String senderPassword = "qdjq gsar zpoz tioh";

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Interview " + status + " - HireConnect");

            String emailContent = "Dear Candidate,\n\n"
                    + "Your interview has been **" + status + "** as follows:\n"
                    + "📅 Date & Time: " + date + "\n"
                    + "📌 Mode: " + mode + "\n"
                    + (meetingLink != null ? "🔗 Meeting Link: " + meetingLink + "\n" : "")
                    + "\nBest Regards,\nHireConnect Team";

            message.setText(emailContent);

            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
