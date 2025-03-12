<%@page import="com.dao.DBConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
    html, body {
        height: 100%; /* Ensure the body takes the full height of the viewport */
        margin: 0; /* Remove default margin */
    }

    .container-fluid {
        display: flex;
        flex-direction: column;
        height: 80%; /* Make the container take up full height */
    }

    main {
        flex: 1; /* Allow main content to take the available space */
    }

    footer {
        padding-top: 20px;
        padding-bottom: 20px;
        background-color: #f8f9fa; /* Optional */
        margin-top: auto; /* Push the footer to the bottom */
    }
</style>

    <title>All Job Applications</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <%@ include file="../components/allcss.jsp"%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/jobseeker/st.css">
</head>
<body>

    <%@ include file="sidebar.jsp"%>
    <div class="container-fluid">
        <div class="row">
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">All Job Applications</h1>
                </div>

                <!-- Application List Section -->
                <div class="card mt-4">
                    <div class="card-header">My Applied Jobs</div>
                    <div class="card-body">
                        <p>✅ Under Review | 📅 Interview Scheduled | ❌ Rejected</p>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Job Title</th>
                                    <th>Company</th> <!-- Added column for company name -->
                                    <th>Location</th>
                                    <th>Salary Estimate</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                Connection conn = null;
                                PreparedStatement stmt = null;
                                ResultSet rs = null;
                                
                                try {
                                    conn = DBConnection.getConn();
                                    
                                    if (session.getAttribute("user_id") != null) {
                                        int userId = (Integer) session.getAttribute("user_id");

                                        // Step 1: Fetch seeker_id from job_seekers table
                                        String seekerQuery = "SELECT seeker_id FROM job_seekers WHERE user_id = ?";
                                        PreparedStatement seekerStmt = conn.prepareStatement(seekerQuery);
                                        seekerStmt.setInt(1, userId);
                                        ResultSet seekerRs = seekerStmt.executeQuery();

                                        if (seekerRs.next()) {
                                            int seekerId = seekerRs.getInt("seeker_id");

                                            // Step 2: Fetch all applied jobs from applications table along with company name
                                            String query = "SELECT j.title, r.company_name, j.location, j.salary_range, a.status " +
                                                           "FROM jobs j " +
                                                           "JOIN applications a ON j.job_id = a.job_id " +
                                                           "JOIN recruiters r ON j.recruiter_id = r.recruiter_id " +
                                                           "WHERE a.seeker_id = ?";

                                            stmt = conn.prepareStatement(query);
                                            stmt.setInt(1, seekerId);
                                            rs = stmt.executeQuery();

                                            boolean hasResults = false;
                                            while (rs.next()) {
                                                hasResults = true;
                                %>
                                                <tr>
                                                    <td><%= rs.getString("title") %></td>
                                                    <td><%= rs.getString("company_name") %></td> <!-- Display company name -->
                                                    <td><%= rs.getString("location") %></td>
                                                    <td><%= rs.getString("salary_range") %></td>
                                                    <td>
                                                        <% if(rs.getString("status").equals("Pending")) { %>
                                                            <span class="badge bg-warning">✅ Under Review</span>
                                                        <% } else if(rs.getString("status").equals("Accepted")) { %>
                                                            <span class="badge bg-success">✅ Accepted</span>
                                                        <% } else if (rs.getString("status").equals("Interview Scheduled")) { %>
                                                            <span class="badge bg-primary">📅 Interview Scheduled</span>
                                                        <% } else if (rs.getString("status").equals("Interview")) { %>
                                                            <span class="badge bg-primary">📅 Interview Scheduled</span>
                                                        <% } else { %>
                                                            <span class="badge bg-danger">❌ Rejected</span>
                                                        <% } %>
                                                    </td>
                                                </tr>
                                <%
                                            }

                                            // Step 3: If no applications found
                                            if (!hasResults) { 
                                %>
                                                <tr>
                                                    <td colspan="5" class="text-center text-muted">
                                                        🚫 No applications found.
                                                    </td>
                                                </tr>
                                <%
                                            }
                                        }
                                        
                                        // Close seeker statement
                                        seekerRs.close();
                                        seekerStmt.close();
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                    if (conn != null) conn.close();
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <%@ include file="footer.jsp"%>
</body>
</html>
