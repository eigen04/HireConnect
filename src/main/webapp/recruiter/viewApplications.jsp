<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Applications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/recruiter/st.css">
    <%@ include file="../components/allcss.jsp"%>
    <style>
        /* Full height layout */
        html, body {
            height: 100%;
            margin: 0;
        }

        .wrapper {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .main-content {
            flex: 1;
            padding: 20px;
            margin-left: 260px;
        }

        .sidebar {
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            background-color: #007bff;
            padding-top: 20px;
            color: white;
            padding-left: 20px;
        }

        table th, table td {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <%@ include file="sidebar.jsp" %>
    <div class="main-content">
        <div class="card-body">
            <h2>View Applications</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Applicant Name</th>
                        <th>Job Title</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    Integer recruiterId = (Integer) session.getAttribute("recruiter_id");
                    if (recruiterId == null) {
                        recruiterId = (Integer) request.getAttribute("recruiter_id");
                    }
                    if (recruiterId != null) {
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hireconnect_db", "root", "anant2004");
                            String query = "SELECT a.application_id, u.full_name, j.title, a.status, i.status AS interview_status FROM applications a " +
                                           "JOIN jobs j ON a.job_id = j.job_id " +
                                           "JOIN job_seekers js ON a.seeker_id = js.seeker_id " +
                                           "JOIN users u ON js.user_id = u.user_id " +
                                           "LEFT JOIN interviews i ON a.application_id = i.application_id " +
                                           "WHERE j.recruiter_id = ?";
                            PreparedStatement stmt = conn.prepareStatement(query);
                            stmt.setInt(1, recruiterId);
                            ResultSet rs = stmt.executeQuery();
                            while (rs.next()) {
                                String applicantName = rs.getString("full_name");
                                String jobTitle = rs.getString("title");
                                String status = rs.getString("status");
                                int applicationId = rs.getInt("application_id");
                                String interviewStatus = rs.getString("interview_status");
                    %>
                                <tr>
                                    <td><%= applicantName %></td>
                                    <td><%= jobTitle %></td>
                                    <td><%= status %></td>
                                    <td>
                                        <% if ("Pending".equals(status)) { %>
                                            <!-- Accept Button -->
                                            <form action="<%= request.getContextPath() %>/UpdateApplicationStatusServlet" method="POST" style="display:inline;">
                                                <input type="hidden" name="application_id" value="<%= applicationId %>">
                                                <input type="hidden" name="status" value="Accepted">
                                                <button type="submit" class="btn btn-success">Accept</button>
                                            </form>

                                            <!-- Call for Interview Button -->
                                            <% if (interviewStatus == null || !"Scheduled".equals(interviewStatus)) { %>
                                                <a href="<%= request.getContextPath() %>/recruiter/scheduleInterview.jsp?application_id=<%= applicationId %>" class="btn btn-warning">Call for Interview</a>
                                            <% } else { %>
                                                <span class="badge badge-info">Interview Scheduled</span>
                                            <% } %>

                                            <!-- Reject Button -->
                                            <form action="<%= request.getContextPath() %>/UpdateApplicationStatusServlet" method="POST" style="display:inline;">
                                                <input type="hidden" name="application_id" value="<%= applicationId %>">
                                                <input type="hidden" name="status" value="Rejected">
                                                <button type="submit" class="btn btn-danger">Reject</button>
                                            </form>
                                        <% } else if ("Accepted".equals(status)) { %>
                                            <!-- Call for Interview Button (only if interview isn't scheduled yet) -->
                                            <% if (interviewStatus == null || !"Scheduled".equals(interviewStatus)) { %>
                                                <a href="<%= request.getContextPath() %>/recruiter/scheduleInterview.jsp?application_id=<%= applicationId %>" class="btn btn-warning">Call for Interview</a>
                                            <% } else { %>
                                                <span class="badge badge-info">Interview Scheduled</span>
                                            <% } %>
                                        <% } %>
                                    </td>
                                </tr>
                    <%
                            }
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    } else {
                        out.println("<p>Error: Recruiter ID is missing.</p>");
                    }
                    %>
                </tbody>
            </table>
            <a href="recruiterDashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</div>
</body>
</html>
