<%@ page import="com.dao.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession userSession = request.getSession();
    Integer userId = (Integer) userSession.getAttribute("user_id");

    if (userId == null) {
        response.sendRedirect("../login.jsp"); // Redirect if not logged in
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        con = DBConnection.getConn();
        ps = con.prepareStatement(
            "SELECT u.full_name, u.email, u.phone, u.skills, js.resume_path " +
            "FROM users u " +
            "JOIN job_seekers js ON u.user_id = js.user_id " + 
            "WHERE u.user_id = ?"
        );
        ps.setInt(1, userId);
        rs = ps.executeQuery();
        
        if (!rs.next()) {
            out.print("<div class='alert alert-danger'>User data not found!</div>");
            return;
        }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professional Profile</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
            padding-top: 20px;
        }
        
        .content-wrapper {
            margin-left: 240px;
            padding: 30px;
        }
        
        .profile-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .profile-header {
            background: linear-gradient(135deg, #3a8ffe 0%, #1d5ffe 100%);
            height: 120px;
            position: relative;
        }
        
        .profile-img-container {
            position: absolute;
            bottom: -50px;
            left: 30px;
        }
        
        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 4px solid white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            object-fit: cover;
        }
        
        .profile-body {
            padding: 70px 30px 30px;
        }
        
        .profile-name {
            font-family: 'Poppins', sans-serif;
            font-size: 24px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        
        .profile-title {
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 20px;
        }
        
        .profile-info {
            margin-bottom: 30px;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            padding: 12px 15px;
            background: #f8f9fa;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .info-item:hover {
            background: #e9ecef;
        }
        
        .info-item i {
            font-size: 18px;
            color: #3a8ffe;
            margin-right: 15px;
            width: 25px;
            text-align: center;
        }
        
        .info-text {
            font-size: 15px;
            color: #495057;
        }
        
        .form-control {
            border: 1px solid #ced4da;
            border-radius: 8px;
            padding: 10px 15px;
            font-size: 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #3a8ffe;
            box-shadow: 0 0 0 0.2rem rgba(58, 143, 254, 0.25);
        }
        
        .btn-edit {
            background: #3a8ffe;
            color: white;
            border-radius: 8px;
            padding: 12px 20px;
            font-weight: 500;
            border: none;
            transition: all 0.3s ease;
        }
        
        .btn-edit:hover {
            background: #1d5ffe;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(29, 95, 254, 0.3);
        }
        
        .btn-save {
            background: #28a745;
            color: white;
            border-radius: 8px;
            padding: 12px 20px;
            font-weight: 500;
            border: none;
            transition: all 0.3s ease;
        }
        
        .btn-save:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }
        
        .resume-box {
            background: #e9f7ef;
            border-radius: 8px;
            padding: 20px;
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .resume-box i {
            font-size: 30px;
            color: #28a745;
            margin-right: 15px;
        }
        
        .resume-link {
            color: #28a745;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        
        .resume-link:hover {
            color: #218838;
            text-decoration: underline;
        }
        
        .resume-upload {
            margin-top: 20px;
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 8px;
            display: block;
        }
        
        .input-hidden {
            background: transparent;
            border: none;
            width: 100%;
            padding: 0;
            margin: 0;
            color: #495057;
        }
        
        .input-hidden:focus {
            outline: none;
        }
        
        .input-editable {
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 8px 12px;
            width: 100%;
        }
    </style>
</head>
<body>
<%@ include file="sidebar.jsp"%>

<div class="content-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <!-- Profile card -->
                <div class="profile-card">
                    <!-- Profile header with background color -->
                    <div class="profile-header">
                        <div class="profile-img-container">
                            <img src="../images/img2.png" alt="Profile Picture" class="profile-img">
                        </div>
                    </div>
                    
                    <!-- Profile body with details -->
                    <div class="profile-body">
                        <h2 class="profile-name" id="displayName"><%= rs.getString("full_name") %></h2>
                        <p class="profile-title">Job Seeker</p>
                        
                  
    <div class="resume-box">
        <i class="fas fa-file-alt"></i>
        <div>
            <% 
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hireconnect_db", "root", "anant2004");
                PreparedStatement stmt = conn.prepareStatement("SELECT file_path FROM resumes WHERE seeker_id = ?");
                stmt.setInt(1, (Integer) session.getAttribute("seeker_id"));
                ResultSet resultSet = stmt.executeQuery();

                if (resultSet.next()) {
                    String resumePath = resultSet.getString("file_path");
                    if (resumePath != null && !resumePath.isEmpty()) {
            %>
                        <strong>Resume</strong>
                        <div class="text-success">Resume Uploaded</div>
            <% 
                    } else { 
            %>
                        <strong>Resume</strong>
                        <div class="text-muted">No resume uploaded yet</div>
            <% 
                    }
                } else { 
            %>
                    <strong>Resume</strong>
                    <div class="text-muted">No resume uploaded yet</div>
            <%
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </div>
    </div>

                        
                        <!-- Profile information -->
                        <div class="profile-info">
                            <form id="profileForm">
                                <!-- Full Name -->
                                <div class="info-item">
                                    <i class="fas fa-user"></i>
                                    <div class="w-100">
                                        <label class="small text-muted d-block mb-1">Full Name</label>
                                        <input type="text" id="name" class="input-hidden" 
                                               value="<%= rs.getString("full_name") %>" readonly>
                                    </div>
                                </div>
                                
                                <!-- Email -->
                                <div class="info-item">
                                    <i class="fas fa-envelope"></i>
                                    <div class="w-100">
                                        <label class="small text-muted d-block mb-1">Email</label>
                                        <input type="email" id="email" class="input-hidden" 
                                               value="<%= rs.getString("email") %>" readonly>
                                    </div>
                                </div>
                                
                                <!-- Phone -->
                                <div class="info-item">
                                    <i class="fas fa-phone"></i>
                                    <div class="w-100">
                                        <label class="small text-muted d-block mb-1">Phone</label>
                                        <input type="text" id="phone" class="input-hidden" 
                                               value="<%= rs.getString("phone") %>" readonly>
                                    </div>
                                </div>
                                
                                <!-- Skills -->
                                <div class="info-item">
                                    <i class="fas fa-cogs"></i>
                                    <div class="w-100">
                                        <label class="small text-muted d-block mb-1">Skills</label>
                                        <input type="text" id="skills" class="input-hidden" 
                                               value="<%= rs.getString("skills") %>" readonly>
                                    </div>
                                </div>
                                
                                <!-- Buttons -->
                                <div class="d-grid gap-2 mt-4">
                                    <button type="button" class="btn btn-edit" id="editProfile">
                                        <i class="fas fa-user-edit me-2"></i> Edit Profile
                                    </button>
                                    <button type="button" class="btn btn-save" id="saveProfile" style="display:none;">
                                        <i class="fas fa-save me-2"></i> Save Changes
                                    </button>
                                </div>
                            </form>
                            
                            <!-- Resume upload form -->
                            <!-- Resume Upload Section -->
<div class="card mt-4">
    <div class="card-header">Upload Your Resume</div>
    <div class="card-body">
        <form action="<%= request.getContextPath() %>/UploadResumeServlet" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="resume" class="form-label">Choose Resume (PDF/DOCX):</label>
                <input type="file" id="resume" name="resume" class="form-control" accept=".pdf,.doc,.docx" required>
            </div>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-upload me-2"></i> Upload Resume
            </button>
        </form>
    </div>
</div>

<!-- Display Uploaded Resumes -->
<div class="card mt-4">
    <div class="card-header">Your Uploaded Resumes</div>
    <div class="card-body">
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Resume Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hireconnect_db", "root", "anant2004");
                    PreparedStatement stmt = conn.prepareStatement("SELECT file_name, seeker_id FROM resumes WHERE seeker_id = ?");
                    stmt.setInt(1, (Integer) session.getAttribute("seeker_id")); 
                    ResultSet rsSet = stmt.executeQuery();
                    boolean hasResumes = false;
                    
                    while (rsSet.next()) {
                        hasResumes = true;
                %>
                <tr>
                    <td><%= rsSet.getString("file_name") %></td>
                    <td>
                        <a href="<%= request.getContextPath() %>/DownloadResumeServlet?seeker_id=<%= rsSet.getInt("seeker_id") %>" class="btn btn-success btn-sm">
                            <i class="fas fa-download"></i> Download
                        </a>
                        <a href="<%= request.getContextPath() %>/ViewResumeServlet?seeker_id=<%= rsSet.getInt("seeker_id") %>" target="_blank" class="btn btn-info btn-sm">
                            <i class="fas fa-eye"></i> View
                        </a>
                        <form action="<%= request.getContextPath() %>/DeleteResumeServlet" method="POST" style="display: inline;">
    <input type="hidden" name="seeker_id" value="<%= rsSet.getInt("seeker_id") %>">
    <button type="submit" class="btn btn-danger btn-sm">
        <i class="fas fa-trash"></i> Delete
    </button>
</form>

                    </td>
                </tr>
                <%
                    }
                    if (!hasResumes) {
                %>
                <tr>
                    <td colspan="2" class="text-center text-danger">
                        No resume uploaded yet.
                    </td>
                </tr>
                <%
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
    </div>
</div>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- jQuery for AJAX -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
$(document).ready(function () {
    $("#editProfile").click(function () {
        // Change inputs to editable
        $(".input-hidden").each(function() {
            $(this).removeClass("input-hidden").addClass("input-editable").prop("readonly", false);
        });
        
        // Update display name in real-time
        $("#name").on("input", function() {
            $("#displayName").text($(this).val());
        });
        
        // Toggle buttons
        $("#editProfile").hide();
        $("#saveProfile").show();
    });

    $("#saveProfile").click(function () {
        const name = $("#name").val();
        const email = $("#email").val();
        const phone = $("#phone").val();
        const skills = $("#skills").val();

        // Basic validation
        if (!name || !email || !phone) {
            alert("Please fill in all required fields");
            return;
        }
        
        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert("Please enter a valid email address");
            return;
        }

        $.ajax({
            url: "<%= request.getContextPath() %>/ProfileServlet",
            type: "POST",
            data: { name, email, phone, skills },
            success: function (response) {
                if (response.trim() === "success") {
                    // Show success message
                    const successAlert = $('<div class="alert alert-success alert-dismissible fade show" role="alert">' +
                        'Profile updated successfully!' +
                        '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
                        '</div>');
                    
                    $(".profile-body").prepend(successAlert);
                    
                    // Return inputs to read-only state
                    $(".input-editable").each(function() {
                        $(this).removeClass("input-editable").addClass("input-hidden").prop("readonly", true);
                    });
                    
                    // Toggle buttons back
                    $("#saveProfile").hide();
                    $("#editProfile").show();
                    
                    // Auto-dismiss alert after 3 seconds
                    setTimeout(function() {
                        successAlert.alert('close');
                    }, 3000);
                } else {
                    alert("Error updating profile: " + response);
                }
            },
            error: function (xhr, status, error) {
                alert("Error: " + error);
            }
        });
    });
});
</script>

</body>
</html>

<%
    } catch (Exception e) {
        out.print("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>