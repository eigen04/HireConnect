<!-- Sidebar for Admin -->
<div class="sidebar">
    <div class="sidebar-header">
        <span>Admin Panel</span>
    </div>
    <ul>
        <li class="active"><a href="adminDashboard.jsp"><i class="fa-solid fa-tachometer-alt"></i> Dashboard</a></li>
        <li><a href="manageJobs.jsp"><i class="fa-solid fa-briefcase"></i> Manage Jobs</a></li>
         <li><a href="manageUsers.jsp"><i class="fa-solid fa-briefcase"></i> Manage Users</a></li>
        <li><a href="manageApplications.jsp"><i class="fa-solid fa-file-alt"></i> Applications</a></li>
        <li><a href="viewReports.jsp"><i class="fa-solid fa-chart-line"></i> Reports</a></li>
        <li><a href="<%=request.getContextPath()%>/LogoutServlet"><i class="fa-solid fa-sign-out-alt"></i> Logout</a></li>

    </ul>
</div>
