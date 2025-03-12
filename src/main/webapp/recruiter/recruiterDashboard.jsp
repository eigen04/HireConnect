<%@page import="java.sql.Date"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Recruiter Dashboard</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<%@ include file="../components/allcss.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/recruiter/st.css">
</head>
<body>
	<%@ include file="sidebar.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">
						👋 Welcome,
						<%=session.getAttribute("full_name") != null ? session.getAttribute("full_name") : "Guest"%>!
					</h1>
				</div>

				<div class="row">
					<div class="col-md-3">
						<div class="card text-white bg-primary mb-3">
							<div class="card-body">
								<h5 class="card-title">Total Jobs Posted</h5>
								<p class="card-text">
									<%
									// Use the already declared recruiterId
									Integer recruiterId = (Integer) session.getAttribute("recruiter_id");
									if (recruiterId != null) {
										String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
										String dbUser = "root";
										String dbPassword = "anant2004";
										try {
											Class.forName("com.mysql.cj.jdbc.Driver");
											Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
											String query = "SELECT COUNT(*) FROM jobs WHERE recruiter_id = ?";
											PreparedStatement stmt = conn.prepareStatement(query);
											stmt.setInt(1, recruiterId);
											ResultSet rs = stmt.executeQuery();
											if (rs.next()) {
												out.print(rs.getInt(1)); // Print the total count of jobs
											}
											stmt.close();
											conn.close();
										} catch (Exception e) {
											e.printStackTrace();
										}
									}
									%>
								</p>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="card text-white bg-success mb-3">
							<div class="card-body">
								<h5 class="card-title">Applications Received</h5>
								<p class="card-text">
									<%
									// Use the already declared recruiterId
									if (recruiterId != null) {
										String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
										String dbUser = "root";
										String dbPassword = "anant2004";
										try {
											Class.forName("com.mysql.cj.jdbc.Driver");
											Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
											String query = "SELECT COUNT(*) FROM applications WHERE application_id IN (SELECT application_id FROM applications WHERE job_id IN (SELECT job_id FROM jobs WHERE recruiter_id = ?))";
											PreparedStatement stmt = conn.prepareStatement(query);
											stmt.setInt(1, recruiterId);
											ResultSet rs = stmt.executeQuery();
											if (rs.next()) {
												out.print(rs.getInt(1)); // Print the total count of scheduled interviews
											}
											stmt.close();
											conn.close();
										} catch (Exception e) {
											e.printStackTrace();
										}
									}
									%>
								</p>
							</div>
						</div>
					</div>
					<div class="col-md-3">
    <div class="card text-white bg-warning mb-3">
        <div class="card-body">
            <h5 class="card-title">Interviews Scheduled</h5>
            <p class="card-text">
                <%
                // Use the already declared recruiterId from the session
                if (recruiterId != null) {
                    String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
                    String dbUser = "root";
                    String dbPassword = "anant2004";
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                        String query = "SELECT COUNT(*) FROM interviews i " +
                                       "JOIN applications a ON i.application_id = a.application_id " +
                                       "JOIN jobs j ON a.job_id = j.job_id " +
                                       "WHERE j.recruiter_id = ? AND i.interview_date IS NOT NULL";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setInt(1, recruiterId);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            out.print(rs.getInt(1));  // Print the number of scheduled interviews
                        }
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                %>
            </p>
        </div>
    </div>
</div>
<div class="col-md-3">
    <div class="card text-white bg-danger mb-3">
        <div class="card-body">
            <h5 class="card-title">Premium Jobs Posted</h5>
            <p class="card-text">
                <%
                if (recruiterId != null) {
                    String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
                    String dbUser = "root";
                    String dbPassword = "anant2004";
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                        String query = "SELECT COUNT(*) FROM jobs WHERE recruiter_id = ? AND is_premium = TRUE";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setInt(1, recruiterId);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            out.print(rs.getInt(1)); // Display count of premium jobs
                        }
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                %>
            </p>
        </div>
    </div>
</div>


				</div>

				<div class="card mt-4">
    <div class="card-header">Manage Job Listings</div>
    <div class="card-body">
        <a href="postJob.jsp" class="btn btn-primary mb-3">Post New Job</a>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Job Title</th>
                    <th>Salary</th>
                    <th>Location</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                // Fetch all jobs posted by the recruiter
                if (recruiterId != null) {
                    try {
                        String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
                        String dbUser = "root";
                        String dbPassword = "anant2004";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                        
                        // Ensure is_premium is always handled properly
                        String query = "SELECT job_id, title, salary_range, location, COALESCE(is_premium, 0) AS is_premium FROM jobs WHERE recruiter_id = ? LIMIT 5";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setInt(1, recruiterId);
                        ResultSet rs = stmt.executeQuery();
                        
                        while (rs.next()) {
                            int jobId = rs.getInt("job_id");
                            String title = rs.getString("title");
                            String salary = rs.getString("salary_range");
                            String location = rs.getString("location");
                            boolean isPremium = rs.getInt("is_premium") == 1; // Properly handling is_premium

                %>
                <tr>
                    <td><%= title %></td>
                    <td><%= salary %></td>
                    <td><%= location %></td>
                    <td>
    <% if (isPremium) { %>
        <span class="badge bg-warning text-dark">Premium</span>
    <% } else { %>
        <span class="badge bg-info text-dark">Standard</span>
    <% } %>
</td>

                    <td>
                        <a href="<%= request.getContextPath() %>/EditJobServlet?job_id=<%= jobId %>" class="btn btn-warning">Edit</a>
                        <a href="<%= request.getContextPath() %>/DeleteJobServlet?job_id=<%= jobId %>" class="btn btn-danger">Delete</a>
                        <form action="upgradeJobPosting.jsp" method="GET" style="display:inline;">
                            <input type="hidden" name="job_id" value="<%= jobId %>">
                            <button type="submit" class="btn btn-success">Upgrade</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                %>
            </tbody>
        </table>
    </div>
</div>


				<div class="card mt-4">
    <div class="card-header">Track Job Applications</div>
    <div class="card-body">
        <p>📄 View applicants and their status for your job listings.</p>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Applicant Name</th>
                    <th>Job Title</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
    if (recruiterId != null) {
        try {
            String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
            String dbUser = "root";
            String dbPassword = "anant2004";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Modified query to include interview status
            String query = "SELECT a.application_id, u.full_name, j.title, a.status, i.status AS interview_status " +
                           "FROM applications a " +
                           "JOIN jobs j ON a.job_id = j.job_id " +
                           "JOIN job_seekers js ON a.seeker_id = js.seeker_id " +
                           "JOIN users u ON js.user_id = u.user_id " +
                           "LEFT JOIN interviews i ON a.application_id = i.application_id " + // Added LEFT JOIN to fetch interview status
                           "WHERE j.recruiter_id = ? LIMIT 3";

            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, recruiterId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String applicantName = rs.getString("full_name");
                String jobTitle = rs.getString("title");
                String status = rs.getString("status");
                int applicationId = rs.getInt("application_id");
                String interviewStatus = rs.getString("interview_status"); // Now this will not throw an exception
%>
                <tr>
                    <td><%= applicantName %></td>
                    <td><%= jobTitle %></td>
                    <td><%= status %></td>
                    <td>
    <% if ("Pending".equals(status)) { %>
        <!-- Accept Button -->
        <form action="<%= request.getContextPath() %>/UpdateApplicationStatusServlet" method="POST" style="display:inline;">
            <input type="hidden" name="application_id" value="<%= applicationId %>">
            <input type="hidden" name="status" value="Accepted">
            <button type="submit" class="btn btn-success">Accept</button>
        </form>

        <!-- Call for Interview Button -->
        <% if (interviewStatus == null || !"Scheduled".equals(interviewStatus)) { %>
            <a href="<%= request.getContextPath() %>/recruiter/scheduleInterview.jsp?application_id=<%= applicationId %>" class="btn btn-warning">Call for Interview</a>
        <% } else { %>
            <span class="badge badge-info">Interview Scheduled</span>
        <% } %>

        <!-- Reject Button -->
        <form action="<%= request.getContextPath() %>/UpdateApplicationStatusServlet" method="POST" style="display:inline;">
            <input type="hidden" name="application_id" value="<%= applicationId %>">
            <input type="hidden" name="status" value="Rejected">
            <button type="submit" class="btn btn-danger">Reject</button>
        </form>
    <% } else if ("Accepted".equals(status)) { %>
        <!-- Call for Interview Button (only if interview isn't scheduled yet) -->
        <% if (interviewStatus == null || !"Scheduled".equals(interviewStatus)) { %>
            <a href="<%= request.getContextPath() %>/recruiter/scheduleInterview.jsp?application_id=<%= applicationId %>" class="btn btn-warning">Call for Interview</a>
        <% } else { %>
    <span class="badge badge-info" style="color: #000 !important; background-color: #ffc107 !important; font-weight: bold; padding: 5px 10px; border-radius: 5px;">
        Interview Scheduled
    </span>
<% } %>

    <% } %>
</td>

                </tr>
<%
            }
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

            </tbody>
        </table>
        <a href="viewApplications.jsp" class="btn btn-primary">View All Applications</a>
    </div>
</div>
<div class="card mt-4">
    <div class="card-header">Job Alerts Subscription</div>
    <div class="card-body">
        <p>🔔 View job seekers subscribed to job alerts.</p>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Job Title</th>
                    <th>Subscribers</th>
                </tr>
            </thead>
            <tbody>
                <%
                if (recruiterId != null) {
                    try {
                        String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
                        String dbUser = "root";
                        String dbPassword = "anant2004";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        String query = "SELECT j.title, COUNT(ja.user_id) AS subscribers " +
                                       "FROM job_alerts ja " +
                                       "JOIN jobs j ON ja.job_id = j.job_id " +
                                       "WHERE j.recruiter_id = ? " +
                                       "GROUP BY j.title";

                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setInt(1, recruiterId);
                        ResultSet rs = stmt.executeQuery();

                        while (rs.next()) {
                            String jobTitle = rs.getString("title");
                            int subscriberCount = rs.getInt("subscribers");
                %>
                            <tr>
                                <td><%= jobTitle %></td>
                                <td><%= subscriberCount %></td>
                            </tr>
                <%
                        }
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                %>
            </tbody>
        </table>
    </div>
</div>

<div class="card mt-4">
    <div class="card-header">Resumes Uploaded by Job Seekers</div>
    <div class="card-body">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Job Seeker Name</th>
                    <th>Resume</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                if (recruiterId != null) {
                    try {
                        String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
                        String dbUser = "root";
                        String dbPassword = "anant2004";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        // ✅ Fixed Query: Show only one resume per seeker
                        String query = "SELECT DISTINCT u.full_name, r.file_name, r.file_path, js.seeker_id " +
                                "FROM resumes r " +
                                "JOIN job_seekers js ON r.seeker_id = js.seeker_id " +
                                "JOIN applications a ON js.seeker_id = a.seeker_id " +
                                "JOIN jobs j ON a.job_id = j.job_id " +
                                "JOIN users u ON js.user_id = u.user_id " +
                                "WHERE j.recruiter_id = ? " +
                                "GROUP BY js.seeker_id";

                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setInt(1, recruiterId);
                        ResultSet rs = stmt.executeQuery();

                        while (rs.next()) {
                            String fullName = rs.getString("full_name");
                            String fileName = rs.getString("file_name");
                            String filePath = rs.getString("file_path");
                            int seekerId = rs.getInt("seeker_id");
                %>
                            <tr>
                                <td><%= fullName %></td>
                                <td><%= fileName %></td>
                                <td>
                                    <a href="DownloadResumeServlet?file_path=<%= filePath %>" class="btn btn-primary">
                                        Download
                                    </a>
                                    <a href="<%= request.getContextPath() %>/uploads/<%= fileName %>" 
                                       class="btn btn-info" target="_blank">
                                        View
                                    </a>
                                </td>
                            </tr>
                <%
                        }
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                %>
            </tbody>
        </table>
    </div>
</div>

				<div class="card mt-4">
    <div class="card-header">Schedule Interviews</div>
    <div class="card-body">
        <p>📅 Schedule and notify candidates about upcoming interviews.</p>
        
        <%
        // Fetch the 2 most recent interviews for the recruiter
        if (recruiterId != null) {
            try {
                String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
                String dbUser = "root";
                String dbPassword = "anant2004";
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                String query = "SELECT i.interview_id, a.application_id, u.full_name, j.title, i.interview_date " +
                        "FROM interviews i " +
                        "JOIN applications a ON i.application_id = a.application_id " +
                        "JOIN jobs j ON a.job_id = j.job_id " +
                        "JOIN job_seekers js ON a.seeker_id = js.seeker_id " +
                        "JOIN users u ON js.user_id = u.user_id " +
                        "WHERE j.recruiter_id = ? " +
                        "ORDER BY i.interview_date ";

                
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, recruiterId);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    String applicantName = rs.getString("full_name");
                    String jobTitle = rs.getString("title");
                    java.sql.Date interviewDate = rs.getDate("interview_date");  // Use java.sql.Date
                    int interviewId = rs.getInt("interview_id");
                    int applicationId = rs.getInt("application_id");
        %>
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Interview with <%= applicantName %></h5>
                        <p class="card-text">Job Title: <%= jobTitle %></p>
                        <p class="card-text">Interview Date: <%= interviewDate %></p>
<a href="/HireConnect/ViewInterviewDetailsServlet?interview_id=<%= interviewId %>" class="btn btn-info">View Details</a>
                    </div>
                </div>
        <%
                }
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        %>
        
        <a href="scheduleInterview.jsp" class="btn btn-primary">Schedule New Interview</a>
    </div>
</div>
<div class="card mt-4">
    <div class="card-header">Company Reviews & Ratings</div>
    <div class="card-body">
        <p>⭐ See what job seekers say about your company.</p>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Reviewer</th>
                    <th>Review</th>
                    <th>Rating</th>
                </tr>
            </thead>
            <tbody>
                <%
                if (recruiterId != null) {
                    try {
                        String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
                        String dbUser = "root";
                        String dbPassword = "anant2004";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        String query = "SELECT u.full_name, r.review_text, r.rating " +
                                       "FROM company_reviews r " +
                                       "JOIN users u ON r.user_id = u.user_id " +
                                       "WHERE r.recruiter_id = ? " +
                                       "ORDER BY r.created_at DESC LIMIT 3";

                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setInt(1, recruiterId);
                        ResultSet rs = stmt.executeQuery();

                        while (rs.next()) {
                            String reviewerName = rs.getString("full_name");
                            String reviewText = rs.getString("review_text");
                            int rating = rs.getInt("rating");
                %>
                            <tr>
                                <td><%= reviewerName %></td>
                                <td><%= reviewText %></td>
                                <td><%= rating %>/5</td>
                            </tr>
                <%
                        }
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                %>
            </tbody>
        </table>
    </div>
</div>


			</main>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
