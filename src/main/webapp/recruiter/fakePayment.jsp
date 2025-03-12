<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    String jobId = request.getParameter("job_id");
    if (jobId == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fake Payment</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Fake Payment Gateway</h2>
        <p>This is a **simulated payment page**. Click **Proceed** to complete payment.</p>

        <form action="<%= request.getContextPath() %>/UpgradeJobServlet" method="POST">
            <input type="hidden" name="job_id" value="<%= jobId %>">
            <button type="submit" class="btn btn-primary">Proceed with Payment</button>
        </form>

        <a href="upgradeJobPosting.jsp?job_id=<%= jobId %>" class="btn btn-secondary mt-3">Cancel</a>
    </div>
</body>
</html>
