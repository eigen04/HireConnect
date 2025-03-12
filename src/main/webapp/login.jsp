<!DOCTYPE html>
<html>
<head>
    <title>Login | HireConnect</title>
    <%@include file="components/allcss.jsp"%>
    <style>
    .login-container {
    padding-top: 50px; /* Adjust as needed */
    max-width: 800px; /* Optional: to control width */
    margin: 0 auto; /* Center align */
}
.footer{

padding-top:200px;

}
    </style>
</head>
<body>
<%@include file="components/navbar.jsp"%>
<div class="login-container mt-4 mb-5">


    <h2 class="text-center">Login to HireConnect</h2>
    <form action="LoginServlet" method="post" class="p-4 border rounded">
        
        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        
        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" name="remember_me" id="rememberMe">
            <label class="form-check-label" for="rememberMe">Remember Me</label>
        </div>
        
        <button type="submit" class="btn btn-primary w-100">Login</button>
        
        <div class="text-center mt-3">
            <a href="register.jsp">Register</a>
        </div>
    </form>
</div>
</body>
<%@include file="components/footer.jsp" %>
</html>
