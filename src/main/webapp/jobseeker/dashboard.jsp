<%@page import="com.dao.DBConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>User Dashboard</title>
<link rel="stylesheet" 
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<%@ include file="../components/allcss.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jobseeker/st.css">



</head>
<body>
<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Integer userId = (Integer) session.getAttribute("user_id");
%>

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
                            <h5 class="card-title">Total Applications</h5>
                            <p class="card-text">
                                <%
                                try {
                                    Connection conn = DBConnection.getConn();

                                    String seekerQuery = "SELECT seeker_id FROM job_seekers WHERE user_id = ?";
                                    PreparedStatement seekerStmt = conn.prepareStatement(seekerQuery);
                                    seekerStmt.setInt(1, userId);
                                    ResultSet seekerRs = seekerStmt.executeQuery();

                                    if (seekerRs.next()) {
                                        int seekerId = seekerRs.getInt("seeker_id");

                                        String appQuery = "SELECT COUNT(*) FROM applications WHERE seeker_id = ?";
                                        PreparedStatement appStmt = conn.prepareStatement(appQuery);
                                        appStmt.setInt(1, seekerId);
                                        ResultSet appRs = appStmt.executeQuery();

                                        if (appRs.next()) {
                                            out.print(appRs.getInt(1));
                                        } else {
                                            out.print("0");
                                        }

                                        appRs.close();
                                        appStmt.close();
                                    }
                                    seekerRs.close();
                                    seekerStmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.print("0");
                                }
                                %>
                            </p>
                        </div>
                    </div>
                </div>



					<div class="col-md-3">
    <div class="card text-white bg-success mb-3">
        <div class="card-body">
            <h5 class="card-title">Interviews Scheduled</h5>
            <p class="card-text">
                <% 
                try {
                    Connection conn = DBConnection.getConn();
                    String query = "SELECT COUNT(*) FROM interviews i " +
                                   "JOIN applications a ON i.application_id = a.application_id " +
                                   "JOIN job_seekers js ON a.seeker_id = js.seeker_id " +
                                   "WHERE js.user_id = ?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setInt(1, (Integer) session.getAttribute("user_id"));
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        out.print(rs.getInt(1)); // Display interview count
                    }
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </p>
        </div>
    </div>
</div>

					<div class="col-md-3">
                    <div class="card text-white bg-warning mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Total Jobs Available</h5>
                            <p class="card-text">
                                <%
                                try {
                                    Connection conn = DBConnection.getConn();
                                    String query = "SELECT COUNT(*) FROM jobs";
                                    PreparedStatement stmt = conn.prepareStatement(query);
                                    ResultSet rs = stmt.executeQuery();
                                    if (rs.next()) {
                                        out.print(rs.getInt(1));
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.print("0");
                                }
                                %>
                            </p>
                        </div>
                    </div>
                </div>
<div class="col-md-3">
        <div class="card text-white bg-danger mb-3">
            <div class="card-body">
                <h5 class="card-title">Job Alerts</h5>
                <p class="card-text">
                    <% 
                    try {
                        Connection conn = DBConnection.getConn();
                        String query = "SELECT COUNT(*) FROM job_alerts WHERE user_id = ?";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setInt(1, (Integer) session.getAttribute("user_id"));
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            out.print(rs.getInt(1)); // Display job alert count
                        }
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    %>
                </p>
            </div>
        </div>
    </div>
</div>
					<div class="card mt-4">
    <div class="card-header">Latest Job Postings</div>
    <div class="card-body">
        
        <!-- Search Form -->
        <form action="" method="GET" class="d-flex mb-3">
            <input type="text" name="keyword" class="form-control me-2" placeholder="Search Jobs..." value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>" required>
            <button type="submit" class="btn btn-primary">Search</button>
        </form>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Job Title</th>
                    <th>Company</th> <!-- Added column for company name -->
                    <th>Location</th>
                    <th>Salary Estimate</th>
                </tr>
            </thead>
            <tbody>
                <%
                try {
                    Connection conn = DBConnection.getConn();
                    String keyword = request.getParameter("keyword");
                    
                    // Base Query: Join jobs with recruiters to fetch company name
                    String query = "SELECT j.title, j.location, j.salary_range, r.company_name FROM jobs j " + 
                                   "JOIN recruiters r ON j.recruiter_id = r.recruiter_id";
                    
                    // If a search keyword is provided, filter results
                    if (keyword != null && !keyword.trim().isEmpty()) {
                        query += " WHERE j.title LIKE ? OR j.location LIKE ?";
                    }
                    
                    query += " ORDER BY j.created_at DESC LIMIT 3"; // Always limit to 3 latest jobs
                    
                    PreparedStatement stmt = conn.prepareStatement(query);
                    
                    // Set parameters if keyword is present
                    if (keyword != null && !keyword.trim().isEmpty()) {
                        stmt.setString(1, "%" + keyword + "%");
                        stmt.setString(2, "%" + keyword + "%");
                    }

                    ResultSet rs = stmt.executeQuery();
                    
                    while (rs.next()) {
                        String jobTitle = rs.getString("title");
                        String companyName = rs.getString("company_name"); // Fetch company name
                        String location = rs.getString("location");
                        String salary = rs.getString("salary_range");
                %>
                        <tr>
                            <td><%= jobTitle %></td>
                            <td><%= companyName %></td> <!-- Display the company name -->
                            <td><%= location %></td>
                            <td><%= salary %></td>
                        </tr>
                <%
                    }
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
        
        <a href="<%= request.getContextPath() %>/jobseeker/viewJobs.jsp" class="btn btn-primary">View All Jobs</a>
    </div> 
</div>



				<div class="card mt-4">
    <div class="card-header">My Applied Jobs</div>
    <div class="card-body">
        <p>✅ Under Review | 📅 Interview Scheduled | ❌ Rejected</p>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Job Title</th>
                    <th>Company</th> <!-- Added column for company name -->
                    <th>Location</th>
                    <th>Salary Estimate</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% 
                try {
                    Connection conn = DBConnection.getConn();
                    if (conn != null) {
                        if (session.getAttribute("user_id") != null) {
                            
                            // Get seeker_id for the logged-in user
                            String seekerQuery = "SELECT seeker_id FROM job_seekers WHERE user_id = ?";
                            PreparedStatement seekerStmt = conn.prepareStatement(seekerQuery);
                            seekerStmt.setInt(1, userId);
                            ResultSet seekerRs = seekerStmt.executeQuery();


                            if (seekerRs.next()) {
                                int seekerId = seekerRs.getInt("seeker_id");

                                // Fetch applied jobs along with company name
                                String query = "SELECT j.title, j.location, j.salary_range, a.status, r.company_name " +
                                               "FROM jobs j " +
                                               "JOIN applications a ON j.job_id = a.job_id " +
                                               "JOIN recruiters r ON j.recruiter_id = r.recruiter_id " +
                                               "WHERE a.seeker_id = ? " +
                                               "LIMIT 2"; 
                                PreparedStatement stmt = conn.prepareStatement(query);
                                stmt.setInt(1, seekerId);
                                ResultSet rs = stmt.executeQuery();
                                
                                boolean hasResults = false;
                                while (rs.next()) {
                                    hasResults = true;
                                %>
                                    <tr>
                                        <td><%= rs.getString("title") %></td>
                                        <td><%= rs.getString("company_name") %></td> <!-- Display company name -->
                                        <td><%= rs.getString("location") %></td>
                                        <td><%= rs.getString("salary_range") %></td>
                                        <td>
                                            <% if(rs.getString("status").equals("Pending")) { %>
                                                <span class="badge bg-warning">✅ Under Review</span>
                                            <% } else if(rs.getString("status").equals("Accepted")) { %>
                                                <span class="badge bg-success">✅ Accepted</span>
                                            <% } else if (rs.getString("status").equals("Interview Scheduled")) { %>
                                                <span class="badge bg-primary">📅 Interview Scheduled</span>
                                            <% } else if (rs.getString("status").equals("Interview")) { %>
                                                <span class="badge bg-primary">📅 Interview Scheduled</span>
                                            <% } else { %>
                                                <span class="badge bg-danger">❌ Rejected</span>
                                            <% } %>
                                        </td>
                                    </tr>
                                <% 
                                }
                                
                                if (!hasResults) { 
                                %>
                                    <tr>
                                        <td colspan="5" class="text-center">No applications found.</td>
                                    </tr>
                                <% 
                                }
                                rs.close();
                                stmt.close();
                            }
                            seekerRs.close();
                            seekerStmt.close();
                        }
                        conn.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
        <!-- View All Applications Button -->
        <a href="<%= request.getContextPath() %>/jobseeker/myApplications.jsp" class="btn btn-primary">View All Applications</a>
    </div>
</div>


				

<div class="card mt-4">
                <div class="card-header">Upcoming Interviews</div>
                <div class="card-body">
                    <%
                    try {
                        Connection conn = DBConnection.getConn();
                        String query = "SELECT interview_date, interview_mode, meeting_link FROM interviews " +
                                       "JOIN applications ON interviews.application_id = applications.application_id " +
                                       "WHERE applications.seeker_id IN (SELECT seeker_id FROM job_seekers WHERE user_id = ?)";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setInt(1, userId);
                        ResultSet rs = stmt.executeQuery();

                        boolean hasInterview = false;
                        while (rs.next()) {
                            hasInterview = true;
                            out.println("<p><b>Date:</b> " + rs.getString("interview_date") + "<br>");
                            out.println("<b>Mode:</b> " + rs.getString("interview_mode") + "<br>");
                            out.println("<b>Meeting Link:</b> <a href='" + rs.getString("meeting_link") + "' target='_blank'>Join</a></p>");
                        }
                        if (!hasInterview) {
                            out.println("<p>No upcoming interviews.</p>");
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    %>
                </div>
            </div>
<div class="card mt-4">
    <div class="card-header">Your Job Alerts</div>
    <div class="card-body">
        <ul>
            <%
                try {
                    Connection conn = DBConnection.getConn();
                    String query = "SELECT j.title FROM job_alerts ja " +
                                   "JOIN jobs j ON ja.job_id = j.job_id " +
                                   "WHERE ja.user_id = ?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setInt(1, (Integer) session.getAttribute("user_id"));
                    ResultSet rs = stmt.executeQuery();

                    boolean hasAlerts = false;
                    while (rs.next()) {
                        hasAlerts = true;
            %>
                        <li><%= rs.getString("title") %></li>
            <%
                    }
                    if (!hasAlerts) {
                        out.println("<li>No job alerts available.</li>");
                    }
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<li>Error fetching job alerts.</li>");
                }
            %>
        </ul>
    </div>
</div>

<div class="card mt-4"> 
    <div class="card-header">Submit a Company Review</div>
    <div class="card-body">
        <form action="<%= request.getContextPath() %>/CompanyReviewServlet" method="post">
            <input type="hidden" name="userId" value="<%= session.getAttribute("user_id") %>">
            
            <!-- Company Name instead of Recruiter ID -->
            <div class="mb-3">
                <label for="companyName" class="form-label">Company Name:</label>
                <input type="text" id="companyName" name="companyName" class="form-control" required>
            </div>

            <!-- Review Text -->
            <div class="mb-3">
                <label for="reviewText" class="form-label">Your Review:</label>
                <textarea id="reviewText" name="reviewText" class="form-control" required></textarea>
            </div>

            <!-- Rating -->
            <div class="mb-3">
                <label for="rating" class="form-label">Rating (1-5):</label>
                <input type="number" id="rating" name="rating" class="form-control" min="1" max="5" required>
            </div>

            <button type="submit" class="btn btn-success">Submit Review</button>
        </form>
    </div>
</div>



			</main>
		</div>
	</div>
	</div>
		<%@ include file="footer.jsp"%>
</body>
</html>
