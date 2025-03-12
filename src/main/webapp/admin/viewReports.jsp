<%@ page import="com.dao.ApplicationDAO"%>
<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.dao.UserDAO"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>📊 Hiring Trends Report</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <%@ include file="../components/allcss.jsp"%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/st.css">

    <!-- Include Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Custom Styles for a Modern Look */
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }
        .card:hover {
            transform: scale(1.03);
        }
        .card-header {
            font-weight: bold;
            background: linear-gradient(135deg, #007bff, #6610f2);
            color: white;
            text-align: center;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        canvas {
            max-height: 280px;
        }
    </style>
</head>
<body>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2 text-primary">📊 Hiring Trends Report</h1>
            </div>

            <div class="row">
                <!-- User Statistics Doughnut Chart -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">User Distribution</div>
                        <div class="card-body d-flex justify-content-center">
                            <canvas id="userChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <!-- Application Status Doughnut Chart -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">Application Status</div>
                        <div class="card-body d-flex justify-content-center">
                            <canvas id="applicationChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>

<%@ include file="../jobseeker/footer.jsp" %>

<!-- JavaScript for Charts -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // User Statistics Data (Modernized with Hover Effects)
        const userData = {
            labels: ["Recruiters", "Job Seekers"],
            datasets: [{
                data: [<%= UserDAO.getTotalRecruiters() %>, <%= UserDAO.getTotalJobSeekers() %>],
                backgroundColor: ["#007bff", "#dc3545"],
                hoverBackgroundColor: ["#0056b3", "#a71d2a"]
            }]
        };

        // Application Status Data
        const applicationData = {
            labels: ["Pending Applications", "Accepted Applications", "Rejected Applications"],
            datasets: [{
                data: [<%= ApplicationDAO.getTotalPendingApplications() %>, <%= ApplicationDAO.getTotalAcceptedApplications() %>, <%= ApplicationDAO.getTotalRejectedApplications() %>],
                backgroundColor: ["#ffc107", "#28a745", "#dc3545"],
                hoverBackgroundColor: ["#e0a800", "#218838", "#a71d2a"]
            }]
        };

        // Chart.js Options
        const chartOptions = {
            responsive: true,
            animation: {
                animateScale: true,
                animateRotate: true
            },
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        font: {
                            size: 14
                        },
                        color: '#333'
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function (tooltipItem) {
                            return tooltipItem.label + ": " + tooltipItem.raw;
                        }
                    }
                }
            }
        };

        // Render Doughnut Charts (Modern Look)
        new Chart(document.getElementById("userChart"), { type: "doughnut", data: userData, options: chartOptions });
        new Chart(document.getElementById("applicationChart"), { type: "doughnut", data: applicationData, options: chartOptions });
    });
</script>

</body>
</html>
