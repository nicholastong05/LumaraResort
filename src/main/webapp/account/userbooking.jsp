<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_v2.css">

    <style>
        .account-wrapper {
            display: flex;
            max-width: 1200px;
            margin: 50px auto;
            gap: 30px;
        }

        .account-sidebar {
            width: 260px;
        }

        .account-user {
            margin-bottom: 30px;
        }

        .account-user h3 {
            margin: 0;
        }

        .account-menu a {
            display: block;
            padding: 12px;
            margin-bottom: 8px;
            border-radius: 10px;
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }

        .account-menu a.active {
            background: #0a3d62;
            color: white;
        }

        .account-menu a:hover {
            background: #eef3f7;
        }

        .logout-link {
            margin-top: 20px;
            color: #b91c1c;
        }

        .logout-link:hover {
            background: #fee2e2;
        }

        .account-content {
            flex: 1;
            background: #f8fafc;
            padding: 30px;
            border-radius: 20px;
        }

        .profile-card {
            background: white;
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 20px;
        }

        .booking-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-top: 15px;
        }

        .booking-meta p {
            margin: 0;
            font-size: 14px;
        }

        .booking-meta strong {
            display: block;
            font-size: 13px;
            color: #555;
        }

        .btn-cancel-booking {
            margin-top: 20px;
            background: #fee2e2;
            color: #991b1b;
            border: none;
            padding: 10px 16px;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 500;
        }

        .btn-cancel-booking:hover {
            background: #fecaca;
        }

        .alert {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 10px;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>

<body>

<jsp:include page="../navbar.jsp" />

<div class="account-wrapper">

    <!-- SIDEBAR -->
    <div class="account-sidebar">
        <div class="account-user">
            <h3>${username}</h3>
            <small>${email}</small>
        </div>

        <div class="account-menu">
            <a href="${pageContext.request.contextPath}/account/profile">
                Account Overview
            </a>

            <a href="${pageContext.request.contextPath}/account/userbooking" class="active">
                My Bookings
            </a>

            <a href="${pageContext.request.contextPath}/account/cards">
                Payment Methods
            </a>

            <a href="${pageContext.request.contextPath}/account/settings">
                Settings
            </a>

            <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                Sign out
            </a>
        </div>
    </div>

    <!-- CONTENT -->
    <div class="account-content">

        <h2>My Bookings</h2>
        <p style="color:#555">View your past and upcoming reservations</p>

        <!-- SUCCESS / ERROR MESSAGES -->
        <c:if test="${not empty sessionScope.bookingSuccess}">
            <div class="alert alert-success">
                ${sessionScope.bookingSuccess}
                <c:remove var="bookingSuccess" scope="session"/>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.bookingError}">
            <div class="alert alert-error">
                ${sessionScope.bookingError}
                <c:remove var="bookingError" scope="session"/>
            </div>
        </c:if>

        <c:if test="${empty bookings}">
            <div class="profile-card">
                <p>You have no bookings yet.</p>
            </div>
        </c:if>

        <c:forEach var="booking" items="${bookings}">
            <div class="profile-card">
                <h3>${booking.name}</h3>

                <div class="booking-meta">
                    <p>
                        <strong>Room Type</strong>
                        ${booking.roomType}
                    </p>

                    <p>
                        <strong>Check-in</strong>
                        ${booking.checkIn}
                    </p>

                    <p>
                        <strong>Check-out</strong>
                        ${booking.checkOut}
                    </p>

                    <p>
                        <strong>Booked On</strong>
                        ${booking.createdAt}
                    </p>
                </div>

                <!-- CANCEL BOOKING -->
                <form method="post"
                      action="${pageContext.request.contextPath}/account/userbooking"
                      onsubmit="return confirm('Are you sure you want to cancel this booking?');">

                    <input type="hidden" name="bookingId" value="${booking.id}">

                    <button type="submit" class="btn-cancel-booking">
                        Cancel Booking
                    </button>
                </form>
            </div>
        </c:forEach>

    </div>
</div>

<jsp:include page="../footer.jsp" />

</body>
</html>
