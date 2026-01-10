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
        <h3 class="payment-title">Payment Method</h3>
        <div class="saved-card-box">
            <label for="savedCardSelect" class="saved-card-label">
                Saved Payment Method
            </label>

            <select id="savedCardSelect" class="saved-card-select">
                <option value="1">Visa •••• 3456 (08/27)</option>
                <option value="2">MasterCard •••• 1122 (05/26)</option>
                <option value="new">+ Add new card</option>
            </select>
        </div>
        <div class="divider">OR</div>
        <input type="radio" name="paymentChoice" value="new" id="newCardRadio" hidden>
        <div class="card-payment-box">
            <div class="card-header">
                <h4>Add Card Details</h4>
            </div>

            <p class="card-subtitle">
                Enter your credit or debit card information.
            </p>

            <div class="card-form">
                <label>
                    Card Number
                    <input type="text" placeholder="1234 5678 9012 3456">
                </label>

                <label>
                    Cardholder Name
                    <input type="text" placeholder="John Doe">
                </label>

                <div class="card-row">
                    <label>
                        Expiry Date
                        <input type="text" placeholder="MM/YY">
                    </label>

                    <label>
                        CVV
                        <input type="text" placeholder="123">
                    </label>
                </div>
            </div>
        </div>


        <!-- Action Buttons -->
        <div class="payment-actions">
            <button type="submit" name="action" value="cancel" class="btn btn-cancel">
                ✕ Cancel
            </button>

            <button type="submit" name="action" value="confirm" class="btn btn-confirm">
                ✓ Confirm
            </button>
        </div>


<jsp:include page="footer.jsp" />

</body><script>
    const newCardRadio = document.getElementById("newCardRadio");
    const savedCardRadio = document.getElementById("savedCardRadio");
    const cardInputs = document.querySelectorAll(".card-form input");

    cardInputs.forEach(input => {
        input.addEventListener("focus", () => {
            newCardRadio.checked = true;
        });
    });
</script>

</html>
