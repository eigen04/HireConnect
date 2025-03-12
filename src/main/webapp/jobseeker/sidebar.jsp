
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<%@ include file="../components/allcss.jsp"%>
<link rel="stylesheet" href="st.css">
</head>
<body>
<div class="sidebar">
		<div class="sidebar-header">
			<span>Dashboard</span>
		</div>
		<ul>
			<li class="active"><a href="dashboard.jsp"><i
					class="fa-solid fa-tachometer-alt"></i> Dashboard</a></li>
			<li><a href="profile.jsp"><i class="fa-solid fa-user"></i> My Profile</a></li>

			<li><a href="viewJobs.jsp"><i class="fa-solid fa-briefcase"></i>
					Jobs</a></li>
			<li><a href="myApplications.jsp"><i
					class="fa-solid fa-file-alt"></i> Applications</a></li>
			<li><a href="<%= request.getContextPath() %>/LogoutServlet"><i class="fa-solid fa-sign-out-alt"></i>
					Logout</a></li>
		</ul>
	</div>
</body>
</html>