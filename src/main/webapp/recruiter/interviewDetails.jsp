<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interview Details</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header bg-primary text-white">
                Interview Details
            </div>
            <div class="card-body">
                <h5 class="card-title">Interview with <%= request.getAttribute("applicantName") %></h5>
                <p class="card-text"><strong>Job Title:</strong> <%= request.getAttribute("jobTitle") %></p>
                <p class="card-text"><strong>Interview Date:</strong> <%= request.getAttribute("interviewDate") %></p>
                <p class="card-text"><strong>Interview Time:</strong> <%= request.getAttribute("interviewTime") %></p>
                <p class="card-text"><strong>Interview Mode:</strong> <%= request.getAttribute("interviewMode") %></p>
                <p class="card-text"><strong>Additional Notes:</strong> <%= request.getAttribute("additionalNotes") %></p>
                
<a href="recruiter/recruiterDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>
