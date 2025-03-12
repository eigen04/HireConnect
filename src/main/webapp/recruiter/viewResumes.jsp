<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Resumes</title>
</head>
<body>
    <h2>Resumes Uploaded by Job Seekers</h2>
    <table border="1">
        <tr>
            <th>Job Seeker ID</th>
            <th>Resume</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hireconnect_db", "root", "anant2004");
                PreparedStatement stmt = conn.prepareStatement("SELECT seeker_id, file_name FROM resumes");
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("seeker_id") %></td>
            <td><a href="DownloadResumeServlet?seeker_id=<%= rs.getInt("seeker_id") %>"><%= rs.getString("file_name") %></a></td>
        </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
