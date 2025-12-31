<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Admin - Bookings</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css">
</head>

<body>
<jsp:include page="../navbar.jsp" />

<h2 style="text-align:center">All Bookings</h2>

<table border="1" width="90%" align="center" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Room Type</th>
        <th>Check In</th>
        <th>Check Out</th>
        <th>Created At</th>
        <th>Actions</th>
    </tr>

    <c:forEach var="b" items="${bookingList}">
        <tr>
            <td>${b.id}</td>
            <td>${b.name}</td>
            <td>${b.roomType}</td>
            <td>${b.checkIn}</td>
            <td>${b.checkOut}</td>
            <td>${b.createdAt}</td>
            <td>
                <a href="edit-booking?id=${b.id}">Edit</a> |
                <a href="delete-booking?id=${b.id}"
                   onclick="return confirm('Delete this booking?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
