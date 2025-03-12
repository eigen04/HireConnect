<div class="sidebar">
    <div class="sidebar-header">
        <h4>Recruiter Panel</h4>
    </div>
    <ul class="sidebar-menu">
        <li class="active">
            <a href="recruiterDashboard.jsp">
                <i class="fa-solid fa-tachometer-alt"></i> Dashboard
            </a>
        </li>
        <li>
            <a href="recruiterDashboard.jsp">
                <i class="fa-solid fa-briefcase"></i> Manage Jobs
            </a>
        </li>
        <li>
            <a href="postJob.jsp">
                <i class="fa-solid fa-plus-circle"></i> Post a Job
            </a>
        </li>
        <li>
            <a href="viewApplications.jsp">
                <i class="fa-solid fa-file-alt"></i> View Applications
            </a>
        </li>
        <li>
            <a href="scheduleInterview.jsp">
                <i class="fa-solid fa-calendar-check"></i> Schedule Interviews
            </a>
        </li>
        <li>
            <a href="<%=request.getContextPath()%>/LogoutServlet">
                <i class="fa-solid fa-sign-out-alt"></i> Logout
            </a>
        </li>
    </ul>
</div>
