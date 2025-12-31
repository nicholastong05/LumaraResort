<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment – Lumara Resort</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css" />
</head>

<body>

<jsp:include page="navbar.jsp" />

<header class="booking-hero">
    <h1>Payment</h1>
    <p>Review your booking and complete payment</p>
</header>

<div class="booking-container">

    <!-- Booking Summary -->
    <div class="booking-summary">
        <h2>Booking Summary</h2>
        <p><strong>Name:</strong> <%= request.getAttribute("name") %></p>
        <p><strong>Room Type:</strong> <%= request.getAttribute("roomType") %></p>
        <p><strong>Check-in:</strong> <%= request.getAttribute("checkIn") %></p>
        <p><strong>Check-out:</strong> <%= request.getAttribute("checkOut") %></p>
        <p><strong>Total Nights:</strong> <%= request.getAttribute("nights") %></p>
        <p><strong>Total Amount:</strong> RM <%= request.getAttribute("totalAmount") %></p>
    </div>

    <!-- Payment Form -->
    <form method="POST" action="<%= request.getContextPath() %>/payment" class="payment-form">

        <!-- Hidden booking ID -->
        <input type="hidden" name="bookingId" value="<%= request.getAttribute("bookingId") %>" />

        <!-- Payment Method Selection (UI only for now) -->
        <div class="payment-methods">
            <h2>Select Payment Method</h2>

            <div class="payment-option">
                <input type="radio" name="paymentMethod" value="card" checked />
                <label>💳 Credit / Debit Card</label>
            </div>

            <div class="payment-option">
                <input type="radio" name="paymentMethod" value="paypal" />
                <label>🅿️ PayPal</label>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="payment-actions">
            <button type="submit" name="action" value="confirm" class="btn-booking">
                Confirm Payment
            </button>

            <button type="submit" name="action" value="cancel" class="btn-booking">
                Cancel Payment
            </button>
        </div>
    </form>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>
