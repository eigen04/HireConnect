<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>

<!DOCTYPE html>
<html>
<head>
    <title>Upload Resume</title>
</head>
<body>
    <h2>Upload Your Resume</h2>
<form action="<%= request.getContextPath() %>/UploadResumeServlet" method="post" enctype="multipart/form-data">
        <input type="file" name="resume" required>
        <input type="submit" value="Upload Resume">
    </form>
</body>
</html>
