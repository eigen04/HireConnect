<%@page import="com.entity.Job"%>
<%@page import="com.dao.JobDAO"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Job Listings</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <%@ include file="../components/allcss.jsp"%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/st.css">
</head>
<body>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Manage Job Listings</h1>
            </div>

            <!-- Manage Job Listings -->
            <div class="card mt-4">
                <div class="card-header">Job Listings</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Job Title</th>
                                <th>Company</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Job> jobList = JobDAO.getJobListings();
                                for (Job job : jobList) {
                            %>
                            <tr>
                                <td><%= job.getTitle() %></td>
                                <td>
                                    <form action="AdminDeleteJobServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="jobId" value="<%= job.getJob_id() %>">
                                        <button type="submit" class="btn btn-danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="../jobseeker/footer.jsp" %>
</body>
</html>
