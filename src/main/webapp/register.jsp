<!DOCTYPE html>
<html>
<head>
    <title>Register | HireConnect</title>
    <%@include file="components/allcss.jsp"%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script>
        function toggleFields() {
            let userType = document.querySelector('input[name="userType"]:checked').value;
            document.getElementById("jobSeekerFields").style.display = (userType === "job_seeker") ? "block" : "none";
            document.getElementById("recruiterFields").style.display = (userType === "recruiter") ? "block" : "none";
        }
    </script>
    <style>
    .login-container {
    padding-top: 50px; /* Adjust as needed */
    max-width: 1000px; /* Optional: to control width */
    margin: 0 auto; /* Center align */
}
    </style>
</head>
<body>
<%@include file="components/navbar.jsp"%>
<div class="login-container mt-4 mb-5">
    <h2 class="text-center">Register for HireConnect</h2>
    <form action="HireConnect/RegisterServlet" method="post" enctype="multipart/form-data" class="p-4 border rounded">
        
        <!-- Common Fields -->
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="full_name" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Confirm Password</label>
            <input type="password" name="confirm_password" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">User Type</label><br>
            <input type="radio" name="userType" value="job_seeker" onclick="toggleFields()" required> Job Seeker
            <input type="radio" name="userType" value="recruiter" onclick="toggleFields()"> Employer
        </div>

        <!-- Job Seeker Fields -->
        <div id="jobSeekerFields" style="display:none;">
            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <input type="text" name="phone" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Resume Upload (Optional)</label>
                <input type="file" name="resume" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Skills (Comma-separated)</label>
                <input type="text" name="skills" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Experience (Years)</label>
                <input type="number" name="experience" class="form-control" min="0">
            </div>
            <div class="mb-3">
                <label class="form-label">LinkedIn Profile (Optional)</label>
                <input type="url" name="linkedin" class="form-control">
            </div>
        </div>

        <!-- Employer Fields -->
        <div id="recruiterFields" style="display:none;">
            <div class="mb-3">
                <label class="form-label">Company Name</label>
                <input type="text" name="company" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Company Website</label>
                <input type="url" name="website" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <input type="text" name="phone" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Company Description</label>
                <textarea name="description" class="form-control"></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Company Logo Upload (Optional)</label>
                <input type="file" name="logo" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Industry</label>
                <select name="industry" class="form-control">
                    <option>IT</option>
                    <option>Healthcare</option>
                    <option>Finance</option>
                    <option>Education</option>
                    <option>Other</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Company Size</label>
                <select name="companySize" class="form-control">
                    <option>1-10</option>
                    <option>11-50</option>
                    <option>51-200</option>
                    <option>201-500</option>
                    <option>501+</option>
                </select>
            </div>
        </div>
        
        <button type="submit" class="btn btn-primary w-100">Register</button>
    </form>
    </div>
</body>
<%@include file="components/footer.jsp" %>
</html>
