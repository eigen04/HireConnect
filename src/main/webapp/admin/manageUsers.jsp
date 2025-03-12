<%@page import="com.dao.UserDAO"%>
<%@page import="com.entity.User"%>
<%@page import="com.entity.Job"%>
<%@page import="com.dao.JobDAO"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage User Listings</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <%@ include file="../components/allcss.jsp"%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/st.css">
</head>
<body>
<%@ include file="sidebar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Manage User Listings</h1>
            </div>

            <!-- Manage Job Listings -->
            <div class="card mt-4">
                <div class="card-header">Manage User Listings</div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            List<User> userList = UserDAO.getUserListings();
                            for (User user : userList) {
                            %>
                            <tr>
                                <td><%= user.getFull_name() %></td>
                                <td><%= user.getEmail() %></td>
                                <td><%= user.getRole() %></td>
                                <td>
                                    <!-- Delete User Form -->
                                    <form action="AdminDeleteUserServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="<%= user.getUser_id() %>">
                                        <button type="submit" class="btn btn-danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="../jobseeker/footer.jsp" %>
</body>
</html>
