<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="card mt-4">
    <div class="card-header">Submit Interview Feedback</div>
    <div class="card-body">
        <form action="<%= request.getContextPath() %>/SubmitInterviewFeedbackServlet" method="POST">
            <div class="mb-3">
                <label for="interview_id" class="form-label">Interview ID</label>
                <input type="text" class="form-control" id="interview_id" name="interview_id" required>
            </div>
            <div class="mb-3">
                <label for="feedback" class="form-label">Feedback</label>
                <textarea class="form-control" id="feedback" name="feedback" rows="3" required></textarea>
            </div>
            <div class="mb-3">
                <label for="rating" class="form-label">Rating (1 to 5)</label>
                <input type="number" class="form-control" id="rating" name="rating" min="1" max="5" required>
            </div>
            <button type="submit" class="btn btn-primary">Submit Feedback</button>
        </form>
    </div>
</div>


</body>
</html>