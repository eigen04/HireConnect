<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<%@ include file="../components/allcss.jsp"%>
<link rel="stylesheet" href="st.css">
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
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <!-- Center links -->
                <li class="nav-item mx-2">
                    <a class="nav-link active" href="index.jsp">
                        <i class="fa-solid fa-home"></i> Home
                    </a>
                </li>
                <li class="nav-item mx-2">
                    <a class="nav-link" href="jobs.jsp">
                        <i class="fa-solid fa-search"></i> Find Jobs
                    </a>
                </li>
                <li class="nav-item mx-2">
                    <a class="nav-link" href="trackApplications.jsp">
                        <i class="fa-solid fa-list-check"></i> Track Applications
                    </a>
                </li>
                <li class="nav-item mx-2">
                    <a class="nav-link" href="jobRecommendations.jsp">
                        <i class="fa-solid fa-lightbulb"></i> Job Recommendations
                    </a>
                </li>
            </ul>

            <!-- Search Bar with AJAX-powered real-time search -->
            <form class="d-flex navbar-search position-relative">
                <input class="form-control me-2" type="search" id="jobSearch" placeholder="Search Jobs..."
                    aria-label="Search">
                <button class="btn btn-light" type="submit">
                    <i class="fa-solid fa-search"></i>
                </button>
                <div id="searchResults" class="dropdown-menu"></div> <!-- AJAX search results -->
            </form>
        </div>
    </div>
</nav>

<!-- AJAX script for real-time search -->
<script>
document.getElementById("jobSearch").addEventListener("input", function() {
    let query = this.value;
    let resultsContainer = document.getElementById("searchResults");

    if (query.length > 2) {
        fetch(`searchJobs.jsp?q=${query}`)
            .then(response => response.json())
            .then(data => {
                resultsContainer.innerHTML = "";
                resultsContainer.style.display = "block";

                data.forEach(job => {
                    let item = document.createElement("a");
                    item.href = `jobDetails.jsp?id=${job.id}`;
                    item.classList.add("dropdown-item");
                    item.textContent = job.title;
                    resultsContainer.appendChild(item);
                });
            })
            .catch(error => console.error("Error fetching jobs:", error));
    } else {
        resultsContainer.style.display = "none";
    }
});
</script>

	<!-- Navbar End -->
</body>
</html>