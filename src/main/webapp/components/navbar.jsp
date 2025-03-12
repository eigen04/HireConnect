<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Navbar</title>
<link rel="stylesheet" href="CSS/style.css">
</head>
<body>
<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand fw-bold" href="index.jsp">
            <i class="fa-solid fa-briefcase"></i> HireConnect
        </a>

        <!-- Toggle button for mobile view -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto"> <!-- Center links -->
                <li class="nav-item mx-3">
                    <a class="nav-link active" href="index.jsp"><i class="fa-solid fa-home"></i> Home</a>
                </li>
                <li class="nav-item mx-3">
                    <a class="nav-link" href="login.jsp"><i class="fa-solid fa-search"></i> Find Jobs</a>
                </li>
                <li class="nav-item mx-3">
                    <a class="nav-link" href="login.jsp"><i class="fa-solid fa-plus"></i> Post a Job</a>
                </li>
            </ul>

            <!-- Search Bar (Optional) -->
            <form class="d-flex navbar-search">
                <input class="form-control me-2" type="search" placeholder="Search Jobs..." aria-label="Search">
                <button class="btn btn-light" type="submit"><i class="fa-solid fa-search"></i></button>
            </form>

            <ul class="navbar-nav ms-3"> <!-- Right-side links -->
                <li class="nav-item mx-2">
                    <a class="nav-link" href="login.jsp"><i class="fa-solid fa-sign-in-alt"></i> Login</a>
                </li>
                <li class="nav-item mx-2">
                    <a class="btn btn-outline-light btn-signup fw-bold" href="register.jsp"><i class="fa-solid fa-user-plus"></i> Signup</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- Navbar End -->

</body>
</html>