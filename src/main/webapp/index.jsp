<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HireConnect</title>
<%@include file="components/allcss.jsp"%>
<link rel="stylesheet" href="CSS/style.css">
</head>
<body>
<%@include file="components/navbar.jsp"%>
<section class="hero-section">
    <div class="container">
        <div class="hero-content">
            <!-- Left: Text & CTA -->
            <div class="hero-text">
                <h1 class="hero-heading">
                    <i class="fa-solid fa-briefcase"></i> Find Your Dream Job or Hire Top Talent Effortlessly!
                </h1>
                <p class="hero-subtext">
                    Join thousands of professionals connecting with top companies worldwide.
                </p>
                <!-- CTA Buttons -->
                <div>
                    <a href="login.jsp" class="btn btn-primary btn-cta">
                        <i class="fa-solid fa-search"></i> Find Jobs
                    </a>
                    <a href="login.jsp" class="btn btn-outline-light btn-cta">
                        <i class="fa-solid fa-plus"></i> Post a Job
                    </a>
                </div>
                <!-- Stats -->
                <div class="hero-stats">
                    <div class="stat-box">
                        <i class="fa-solid fa-briefcase"></i>
                        <p>10,000+ Jobs</p>
                    </div>
                    <div class="stat-box">
                        <i class="fa-solid fa-building"></i>
                        <p>5,000+ Companies</p>
                    </div>
                    <div class="stat-box">
                        <i class="fa-solid fa-users"></i>
                        <p>50,000+ Users</p>
                    </div>
                </div>
            </div>
            <!-- Right: Illustration -->
            <div class="hero-image">
                <img src="images/img1.svg" alt="Job Search Illustration">
            </div>
        </div>
    </div>
</section>
<section class="container mt-5 how-it-works">
    <h2 class="text-center">How It Works</h2>
    <div class="row text-center">
        <div class="col-md-6">
            <h4>For Job Seekers</h4>
            <div class="card p-4 shadow-lg border-0">
                <p>📝 <strong>Sign Up</strong> – Create your profile in minutes.</p>
                <p>🔍 <strong>Browse Jobs</strong> – Find jobs that match your skills.</p>
                <p>💼 <strong>Apply & Get Hired</strong> – Connect with top companies.</p>
            </div>
        </div>
        <div class="col-md-6">
            <h4>For Employers</h4>
            <div class="card p-4 shadow-lg border-0">
                <p>📢 <strong>Post a Job</strong> – Describe the role & skills required.</p>
                <p>🧐 <strong>Get Applications</strong> – AI-matched candidates.</p>
                <p>🤝 <strong>Hire the Best</strong> – Schedule interviews & hire talent.</p>
            </div>
        </div>
    </div>
</section>


<!-- Featured Jobs Section -->
<section class="container mt-5">
    <h2 class="text-center mb-4">Featured Jobs & Companies</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card p-3 shadow-sm border-0 hover-effect">
                <h5>💼 Software Engineer</h5>
                <p>🌍 Google | 📍 Remote | ₹12-18 LPA</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card p-3 shadow-sm border-0 hover-effect">
                <h5>📊 Marketing Manager</h5>
                <p>🌍 Amazon | 📍 Bangalore | ₹10-15 LPA</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card p-3 shadow-sm border-0 hover-effect">
                <h5>📈 Data Scientist</h5>
                <p>🌍 Microsoft | 📍 Hyderabad | ₹15-20 LPA</p>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="container mt-5">
    <h2 class="text-center mb-4">Success Stories</h2>
    <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="card p-4 text-center shadow-lg border-0">
                    <p>💬 "I found my dream job within a week using HireConnect!"</p>
                    <p><strong>- Rohan, Software Engineer</strong></p>
                    <p>⭐⭐⭐⭐⭐</p>
                </div>
            </div>
            <div class="carousel-item">
                <div class="card p-4 text-center shadow-lg border-0">
                    <p>💬 "Hiring on HireConnect made recruiting 10x faster!"</p>
                    <p><strong>- Priya, HR Manager</strong></p>
                    <p>⭐⭐⭐⭐⭐</p>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev" href="#testimonialCarousel" role="button" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#testimonialCarousel" role="button" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
    </div>
</section>

<!-- Why Choose Us Section -->
<section class="container mt-5">
    <h2 class="text-center mb-4">Why Choose HireConnect?</h2>
    <div class="row text-center">
        <div class="col-md-3">
            <div class="card p-3 shadow-lg border-0">
                <h5>🎯 AI-Based Matching</h5>
                <p>Personalized job recommendations.</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 shadow-lg border-0">
                <h5>✅ Verified Listings</h5>
                <p>Only authentic jobs posted.</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 shadow-lg border-0">
                <h5>📂 Easy Resume Upload</h5>
                <p>Quickly apply with your CV.</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 shadow-lg border-0">
                <h5>⏳ Faster Hiring</h5>
                <p>Connect with recruiters instantly.</p>
            </div>
        </div>
    </div>
</section>





<%@include file="components/footer.jsp" %>
</body>
</html>