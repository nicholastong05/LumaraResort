<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard – Lumara Resort</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css" />
</head>

<body>

<jsp:include page="navbar.jsp" />

<section class="admin-container">
    <h2>Admin Dashboard</h2>

    <div class="admin-cards">

        <div class="admin-card">
            <h3>Manage Rooms</h3>
            <p>Add, update, or remove rooms</p>
        </div>

        <a href="<%= request.getContextPath() %>/admin/bookings" class="admin-card">
            <h3>View Bookings</h3>
            <p>Check customer bookings</p>
        </a>

        <div class="admin-card">
            <h3>Update Prices</h3>
            <p>Modify room prices</p>
        </div>

    </div>
</section>

<jsp:include page="footer.jsp" />

</body>
</html>
