<%@page import="com.dao.ApplicationDAO"%>
<%@page import="com.entity.Application"%>
<%@page import="com.entity.User"%>
<%@page import="com.entity.Job"%>
<%@page import="com.dao.JobDAO"%>
<%@page import="com.dao.UserDAO"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
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
                <h1 class="h2">👋 Welcome, Admin!</h1>
            </div>
            
            <!-- Job Statistics -->
            <div class="row">
                <div class="col-md-3">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Total Job Listings</h5>
                            <p class="card-text"><%= JobDAO.getTotalJobListings() %></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-primary mb-3 p-3">
                        <h5 class="card-title" style="font-size: 20px;">Total Users</h5>
                        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                            <p class="card-text" style="font-size: 16px; margin: 0;">Total Users: <%= UserDAO.getTotalUsers() %></p>
                            <p class="card-text" style="font-size: 16px; margin: 0;">Recruiters: <%= UserDAO.getTotalRecruiters() %></p>
                            <p class="card-text" style="font-size: 16px; margin: 0;">Job Seekers: <%= UserDAO.getTotalJobSeekers() %></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="card text-white bg-primary mb-3 p-3">
                        <h5 class="card-title" style="font-size: 20px;">Total Applications</h5>
                        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                            <p class="card-text" style="font-size: 16px; margin: 0;">Total Applications: <%= ApplicationDAO.getTotalApplications() %></p>
                            <p class="card-text" style="font-size: 16px; margin: 0;">Pending: <%= ApplicationDAO.getTotalPendingApplications() %></p>
                            <p class="card-text" style="font-size: 16px; margin: 0;">Accepted: <%= ApplicationDAO.getTotalAcceptedApplications() %></p>
                            <p class="card-text" style="font-size: 16px; margin: 0;">Rejected: <%= ApplicationDAO.getTotalRejectedApplications() %></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Manage Job Listings -->
            <div class="card mt-4">
                <div class="card-header">Manage Job Listings</div>
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
                            int count = 0;
                            for (Job job : jobList) {
                                if (count >= 2) break; // Limit to 2 jobs
                                count++;
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
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    <a href="manageJobs.jsp" class="btn btn-primary">View All Jobs</a>
                </div>
            </div>

            <!-- Manage User Listings -->
            <div class="card mt-4">
                <div class="card-header">Manage User Listings</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            List<User> userList = UserDAO.getUserListings();
                            int cnt = 0;
                            for (User user : userList) {
                                if (cnt >= 2) break; // Limit to 2 jobs
                                cnt++;
                            %>
                            <tr>
                                <td><%= user.getFull_name() %></td>
                                <td><%= user.getEmail() %></td>
                                <td><%= user.getRole() %></td>
                                <td>
                                    <!-- Delete User Form -->
                                    <form action="AdminDeleteUserServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="<%= user.getUser_id() %>">
                                        <button type="submit" class="btn btn-danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                    <a href="manageUsers.jsp" class="btn btn-primary">View All Users</a>
                </div>
            </div>

            <!-- Manage Applications -->
            <div class="card mt-4">
    <div class="card-header">Manage Applications</div>
    <div class="card-body">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Job ID</th>
                    <th>Seeker ID</th>
                    <th>Status</th>
                    <th>Applied At</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<Application> applicationList = ApplicationDAO.getApplications();
                int appCount = 0;
                for (Application app : applicationList) { // Changed variable name to 'app'
                    if (appCount >= 2) break; // Limit to 2 applications
                    appCount++;
                %>
                <tr>
                    <td><%= app.getJobId() %></td> <!-- Corrected method name -->
                    <td><%= app.getSeekerId() %></td> <!-- Corrected method name -->
                    <td><%= app.getStatus() %></td>
                    <td><%= app.getAppliedAt() %></td> <!-- Corrected method name -->
                    <td><%= app.getEmail() %></td>
                    <td>
                        <!-- Delete Application Form -->
                        <form action="AdminDeleteApplicationServlet" method="post" style="display:inline;">
                            <input type="hidden" name="applicationId" value="<%= app.getApplicationId() %>"> <!-- Corrected method name -->
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
        <a href="manageApplications.jsp" class="btn btn-primary">View All Applications</a>
    </div>
</div>


            <div class="card mt-4">
                <div class="card-header">Hiring Trends Report</div>
                <div class="card-body">
                    <p>📊 Report on job approvals, rejections, and applications received.</p>
                    <a href="viewReports.jsp" class="btn btn-primary">Generate Report</a>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="../jobseeker/footer.jsp" %>
</body>
</html>
