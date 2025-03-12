<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Post a Job</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/recruiter/st.css">
    <%@ include file="../components/allcss.jsp"%>
    <style>
        /* Sidebar styling */
        .sidebar {
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            background: #007bff;
            padding-top: 20px;
            color: white;
        }

        /* Adjust the main content to prevent overlap */
        .main-content {
            margin-left: 300px; /* Sidebar width + some gap */
            padding: 10px;
        }

        /* Center the form and limit its width */
        .form-container {
        width:50%;
            max-width: 800px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin: auto; /* Center the form */
        }

        /* Prevent form elements from stretching */
        form .form-control {
            width: 100%;
        }
    </style>
</head>
<body>

    <%@ include file="sidebar.jsp" %>

    <div class="main-content">
        <h2>Post a New Job</h2>
        <div class="form-container">
            <form action="<%=request.getContextPath()%>/PostJobServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">Job Title</label>
                    <input type="text" class="form-control" name="title" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" name="description" required></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Location</label>
                    <input type="text" class="form-control" name="location" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <input type="text" class="form-control" name="category" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Salary Range</label>
                    <input type="text" class="form-control" name="salary_range">
                </div>
                <div class="mb-3">
                    <label class="form-label">Job Type</label>
                    <select class="form-control" name="job_type" required>
                        <option value="Full-Time">Full-Time</option>
                        <option value="Part-Time">Part-Time</option>
                        <option value="Internship">Internship</option>
                        <option value="Contract">Contract</option>
                    </select>
                </div>
                <input type="hidden" name="recruiter_id" value="<%= session.getAttribute("recruiter_id") %>">
                <button type="submit" class="btn btn-primary">Post Job</button>
            </form>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>
