<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Company Reviews</title>
</head>
<body>
    <h2>Submit a Review</h2>
    <form action="<%= request.getContextPath() %>/CompanyReviewServlet" method="post">
        <input type="hidden" name="userId" value="1"> 
        <label>Recruiter ID:</label>
        <input type="text" name="recruiterId" required><br>
        <label>Review:</label>
        <textarea name="reviewText" required></textarea><br>
        <label>Rating:</label>
        <input type="number" name="rating" min="1" max="5" required><br>
        <button type="submit">Submit</button>
    </form>
</body>
</html>
