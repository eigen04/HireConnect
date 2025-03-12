<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Schedule Interview</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/recruiter/st.css">
    <%@ include file="../components/allcss.jsp"%>
    <style>
        /* Sidebar styling */
        .sidebar {
            width: 300px;
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
            margin-left: 260px; /* Sidebar width + some gap */
            padding: 10px;
            margin-top: 20px;
        }

        /* Center the form and limit its width */
        .form-container {
            width: 70%; /* Reduce width */
            max-width: 1000px;
            background: white;
            padding: 15px; /* Reduce padding */
            border-radius: 10px;
            box-shadow: 0px 0px 8px rgba(0, 0, 0, 0.1);
            margin: auto;
            margin-top: 10px; /* Center the form */
        }

        /* Prevent form elements from stretching */
        form .form-control {
            width: 100%;
        }

        footer {
            position: relative;
            bottom: 20px; /* Moves it slightly up */
            margin-top: -180px; /* Reduce gap from content */
            padding: 10px;
            text-align: center;
            background: #f1f1f1;
        }

        h2 {
            margin-left: 300px;
        }
    </style>
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    <div class="main-content">
        <h2>Schedule Interview</h2>
        <div class="form-container">
            <form action="<%=request.getContextPath()%>/InterviewServlet" method="post">
                <div class="mb-3">
                    <label for="applicationId" class="form-label">Select Application</label>
                    <select class="form-control" id="applicationId" name="application_id" required>
                        <option value="">-- Select Application --</option>
                        <%
                            // Fetch applications from DB
                            String jdbcURL = "jdbc:mysql://localhost:3306/hireconnect_db";
                            String dbUser = "root";
                            String dbPassword = "anant2004";
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                                String query = "SELECT a.application_id, u.full_name FROM applications a " +
                                              "JOIN job_seekers js ON a.seeker_id = js.seeker_id " +
                                              "JOIN users u ON js.user_id = u.user_id " +
                                              "WHERE a.status NOT IN ('Interview', 'Interview Scheduled')";
                                PreparedStatement stmt = conn.prepareStatement(query);
                                ResultSet rs = stmt.executeQuery();

                                boolean hasApplications = false;
                                while (rs.next()) {
                                    hasApplications = true;
                                    int appId = rs.getInt("application_id");
                                    String fullName = rs.getString("full_name");
                        %>
                                    <option value="<%= appId %>">Application ID: <%= appId %> - <%= fullName %></option>
                        <%
                                }
                                if (!hasApplications) {
                        %>
                                    <option value="">No applications available</option>
                        <%
                                }
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                        %>
                                <option value="">Error loading applications</option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="interviewDate" class="form-label">Interview Date & Time</label>
                    <input type="datetime-local" class="form-control" id="interviewDate" name="interview_date" required>
                </div>

                <div class="mb-3">
                    <label for="interviewMode" class="form-label">Interview Mode</label>
                    <select class="form-control" id="interviewMode" name="interview_mode" required>
                        <option value="Online">Online</option>
                        <option value="Offline">Offline</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="meetingLink" class="form-label">Meeting Link (if online)</label>
                    <input type="text" class="form-control" id="meetingLink" name="meeting_link">
                </div>

                <button type="submit" class="btn btn-success">Schedule Interview</button>
            </form>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
