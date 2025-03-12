<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Job Alerts</title>
</head>
<body>
    <h2>Your Job Alerts</h2>
    <ul>
        <%
            List<String> jobAlerts = (List<String>) request.getAttribute("jobAlerts");
            if (jobAlerts != null && !jobAlerts.isEmpty()) {
                for (String job : jobAlerts) {
        %>
                    <li><%= job %></li>
        <%
                }
            } else {
        %>
            <li>No job alerts available.</li>
        <%
            }
        %>
    </ul>
</body>
</html>
