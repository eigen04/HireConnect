<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
    // Get job_id from request
    String jobId = request.getParameter("job_id");
    if (jobId == null) {
        response.sendRedirect("dashboard.jsp"); // Redirect if no job ID is provided
        return;
    }

    String title = "", salary = "", location = "", isFeatured = "No";

    try {
        String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
        String dbUser = "root";
        String dbPassword = "anant2004";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Fetch job details
        String query = "SELECT title, salary_range, location, is_premium  FROM jobs WHERE job_id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(jobId));
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            title = rs.getString("title");
            salary = rs.getString("salary_range");
            location = rs.getString("location");
            isFeatured = rs.getInt("is_premium") == 1 ? "Yes" : "No";
        }

        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upgrade Job Posting</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Upgrade Job Posting</h2>
        <p>Boost visibility by upgrading your job listing to a <strong>Featured Job</strong>.</p>

        <div class="card p-3">
            <h4><%= title %></h4>
            <p><strong>Salary:</strong> <%= salary %></p>
            <p><strong>Location:</strong> <%= location %></p>
            <p><strong>Featured:</strong> <%= isFeatured %></p>

            <% if (!isFeatured.equals("Yes")) { %>
                <form action="fakePayment.jsp" method="GET">
    <input type="hidden" name="job_id" value="<%= jobId %>">
    <button type="submit" class="btn btn-success">Upgrade to Featured Job</button>
</form>


            <% } else { %>
                <button class="btn btn-secondary" disabled>Already Upgraded</button>
            <% } %>
        </div>

        <a href="recruiterDashboard.jsp" class="btn btn-secondary mt-3">Back to Jobs</a>
    </div>
</body>
</html>
