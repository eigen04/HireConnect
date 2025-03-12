<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<style>

/* Footer Section */
.footer {
    background: #007BFF;
    color: #ffffff;
    padding: 40px 0;
    font-size: 14px;
    width: 100%; /* Ensures full width */
    position: relative; /* Keeps it from overlapping */
    bottom: 0;
}
.footer .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}
.footer-top {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
}
.footer-column {
    flex: 1;
    min-width: 220px;
    margin-bottom: 20px;
}
.footer-column h3, .footer-column h4 {
    color: #f8f9fa;
}
.footer-column ul {
    list-style: none;
    padding: 0;
}
.footer-column ul li {
    margin-bottom: 8px;
}
.footer-column ul li a {
    color: #ffffff;
    text-decoration: none;
    transition: 0.3s;
}
.footer-column ul li a:hover {
    color: #f1c40f;
}
.footer-column p a {
    color: #f1c40f;
    text-decoration: none;
}
.footer-column p a:hover {
    text-decoration: underline;
}
.social-icons a {
    display: inline-block;
    color: #ffffff;
    font-size: 18px;
    margin-right: 10px;
    transition: 0.3s;
}
.social-icons a:hover {
    color: #f1c40f;
}
.footer-bottom {
    text-align: center;
    margin-top: 20px;
    border-top: 1px solid #ffffff;
    padding-top: 15px;
    font-size: 13px;
}

	
</style>
</head>
<body>
<footer class="footer">
    <div class="container">
        <div class="footer-top">
            <div class="footer-column">
    <h3>HireConnect</h3>
    <p>Your AI-powered job recruitment platform. Connecting talents with top companies.</p>
    <img src="images/foot.png" alt="HireConnect Logo" width="200" style="display: block; margin-top: 10px;">
</div>

            <div class="footer-column">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="jobs.jsp">Browse Jobs</a></li>
                    <li><a href="employers.jsp">For Employers</a></li>
                    <li><a href="about.jsp">About Us</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h4>Support</h4>
                <ul>
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">FAQs</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h4>Contact Us</h4>
                <p>Email: <a href="mailto:support@hireconnect.com">support@hireconnect.com</a></p>
                <p>Phone: +91 98765 43210</p>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 HireConnect. All rights reserved.</p>
        </div>
    </div>
</footer>


</body>
</html>







