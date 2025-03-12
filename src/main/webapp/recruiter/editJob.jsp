<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Job</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Edit Job</h2>
        <form action="UpdateJobServlet" method="post">
            <input type="hidden" name="job_id" value="<%= request.getAttribute("job_id") %>">
            
            <div class="mb-3">
                <label class="form-label">Job Title</label>
                <input type="text" class="form-control" name="title" value="<%= request.getAttribute("title") %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea class="form-control" name="description" required><%= request.getAttribute("description") %></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Location</label>
                <input type="text" class="form-control" name="location" value="<%= request.getAttribute("location") %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Category</label>
                <input type="text" class="form-control" name="category" value="<%= request.getAttribute("category") %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Salary Range</label>
                <input type="text" class="form-control" name="salary_range" value="<%= request.getAttribute("salary_range") %>">
            </div>
            <div class="mb-3">
                <label class="form-label">Job Type</label>
                <select class="form-control" name="job_type" required>
                    <option value="Full-Time" <%= "Full-Time".equals(request.getAttribute("job_type")) ? "selected" : "" %>>Full-Time</option>
                    <option value="Part-Time" <%= "Part-Time".equals(request.getAttribute("job_type")) ? "selected" : "" %>>Part-Time</option>
                    <option value="Internship" <%= "Internship".equals(request.getAttribute("job_type")) ? "selected" : "" %>>Internship</option>
                    <option value="Contract" <%= "Contract".equals(request.getAttribute("job_type")) ? "selected" : "" %>>Contract</option>
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary">Update Job</button>
        </form>
    </div>
</body>
</html>
