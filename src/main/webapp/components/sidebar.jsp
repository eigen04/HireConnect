<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sidebar</title>
    <style>
        /* Sidebar Styling */
        .sidebar {
    position: fixed;
    top: 60px; /* Adjust based on your navbar height */
    left: 0;
    width: 250px; /* Sidebar width */
    height: 100vh;
    background-color: #007bff;
    transition: width 0.3s ease-in-out;
    padding-top: 10px;
    overflow-y: auto; /* Allows scrolling if content overflows */
}

        .sidebar .sidebar-header {
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            padding-bottom: 10px;
            border-bottom: 2px solid white;
            color: white;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            padding: 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
            display: block;
            font-size: 16px;
        }

        .sidebar ul li a:hover {
            background: rgba(255, 255, 255, 0.2);
            transition: 0.3s;
        }

        .sidebar ul li.active a {
            font-weight: bold;
            border-left: 4px solid white;
            padding-left: 10px;
        }

        /* Main Content */
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s ease;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <span>Dashboard</span>
    </div>
    <ul>
        <li class="active"><a href="dashboard.jsp"><i class="fa-solid fa-tachometer-alt"></i> Dashboard</a></li>
        <li><a href="profile.jsp"><i class="fa-solid fa-user"></i> My Profile</a></li>
        <li><a href="jobs.jsp"><i class="fa-solid fa-briefcase"></i> Jobs</a></li>
        <li><a href="applications.jsp"><i class="fa-solid fa-file-alt"></i> Applications</a></li>
        <li><a href="logout.jsp"><i class="fa-solid fa-sign-out-alt"></i> Logout</a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <h1>Welcome to the Dashboard</h1>
</div>

</body>
</html>
