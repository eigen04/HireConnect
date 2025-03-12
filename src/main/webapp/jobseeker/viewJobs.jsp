<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Jobs</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <%@ include file="../components/allcss.jsp" %>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/jobseeker/st.css">
    <style>
        .sidebar { width: 240px; position: fixed; height: 100%; top: 0; left: 0; background-color: #f8f9fa; padding-top: 20px; z-index: 1; }
        .container { margin-left: 250px !important; padding-top: 10px; }
        footer { bottom: 40px; margin-top: 200px; }
    </style>
</head>
<body>

<%@ include file="../jobseeker/sidebar.jsp" %>

<%
    HttpSession sessionUser = request.getSession();
    Integer seekerId = (Integer) sessionUser.getAttribute("user_id"); // Get user ID from session
    String appliedJobId = request.getParameter("job_id");
%>

<div class="container mt-5">
    <h2>Available Jobs</h2>
    <p>Here are the jobs posted by recruiters that are available for you to apply to.</p>

    <% if (request.getParameter("success") != null && request.getParameter("success").equals("applied")) { %>
        <div class="alert alert-success">You have successfully applied for the job!</div>
    <% } %>
    
    <form action="" method="GET" class="d-flex mb-3">
        <input type="text" name="keyword" class="form-control me-2" placeholder="Search Jobs..." value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>" required>
        <button type="submit" class="btn btn-primary">Search</button>
    </form>
    
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Job Title</th>
                <th>Company</th> <!-- Added column for company name -->
                <th>Salary</th>
                <th>Location</th>
                <th>Actions</th>
                <th>Job Alerts</th>
            </tr>
        </thead>
        <tbody>
    <%
    String keyword = request.getParameter("keyword");
    String query = "SELECT j.job_id, j.title, j.salary_range, j.location, r.company_name FROM jobs j " + 
                   "JOIN recruiters r ON j.recruiter_id = r.recruiter_id"; // Joining jobs with recruiters

    if (keyword != null && !keyword.trim().isEmpty()) {
        query += " WHERE j.title LIKE ? OR j.location LIKE ?"; // Search by title or location
    }
    query += " ORDER BY FIELD(j.title, ?) DESC"; // Priority to matching jobs on top

    try {
        String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
        String dbUser = "root";
        String dbPassword = "anant2004";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        
        PreparedStatement stmt = conn.prepareStatement(query);
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setString(3, keyword);  // Priority to matching job titles
        } else {
            stmt.setString(1, "");  // Default empty keyword for no search
        }

        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int jobId = rs.getInt("job_id");
            String title = rs.getString("title");
            String companyName = rs.getString("company_name"); // Fetch company name
            String salary = rs.getString("salary_range");
            String location = rs.getString("location");

            boolean hasApplied = false;

            if (seekerId != null) {
                String checkQuery = "SELECT * FROM applications WHERE seeker_id = ? AND job_id = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                checkStmt.setInt(1, seekerId);
                checkStmt.setInt(2, jobId);
                ResultSet checkRs = checkStmt.executeQuery();
                if (checkRs.next() || (appliedJobId != null && appliedJobId.equals(String.valueOf(jobId)))) {
                    hasApplied = true;
                }
                checkStmt.close();
            }
    %>
            <tr>
                <td><%= title %></td>
                <td><%= companyName %></td> <!-- Display the company name -->
                <td><%= salary %></td>
                <td><%= location %></td>
                <td>
                    <% if (seekerId != null) { %>
                        <% if (hasApplied) { %>
                            <button class="btn btn-secondary" disabled>Applied</button>
                        <% } else { %>
                            <form action="<%= request.getContextPath() %>/ApplyJobServlet" method="post">
                                <input type="hidden" name="job_id" value="<%= jobId %>">
                                <input type="hidden" name="redirect" value="dashboard">
                                <button type="submit" class="btn btn-success">Apply</button>
                            </form>
                        <% } %>
                    <% } else { %>
                        <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-primary">Login to Apply</a>
                    <% } %>
                </td>
                <td>
                    <% if (seekerId != null) { %>
                        <form action="<%= request.getContextPath() %>/JobAlertsServlet" method="post">
                            <input type="hidden" name="job_id" value="<%= jobId %>">
                            <input type="hidden" name="user_id" value="<%= seekerId %>">
                            <input type="hidden" name="redirect" value="dashboard">
                            <button type="submit" class="btn btn-warning">Set Job Alert</button>
                        </form>
                    <% } else { %>
                        <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-warning">Login to Set Alert</a>
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
%>

</tbody>
    </table>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
