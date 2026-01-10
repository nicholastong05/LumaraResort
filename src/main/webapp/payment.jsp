<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    /* =========================
       LOAD SAVED CARDS (JDBC)
       ========================= */
    java.util.List<java.util.Map<String, String>> savedCards =
            new java.util.ArrayList<>();

    Integer userId = null;
    if (session != null && session.getAttribute("userId") != null) {
        userId = (Integer) session.getAttribute("userId");
    } else {
        userId = 2; // TEMP dev user
    }

    try (java.sql.Connection conn =
                 com.lumara.util.DBConnection.getConnection()) {

        String sql =
            "SELECT payment_id, card_brand, card_last4, expiry_month, expiry_year " +
            "FROM user_payment_methods WHERE user_id = ?";

        try (java.sql.PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    java.util.Map<String, String> card =
                            new java.util.HashMap<>();

                    card.put("id", rs.getString("payment_id"));
                    card.put("brand", rs.getString("card_brand"));
                    card.put("last4", rs.getString("card_last4"));
                    card.put(
                        "expiry",
                        rs.getString("expiry_month") + "/" +
                        rs.getString("expiry_year")
                    );

                    savedCards.add(card);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    request.setAttribute("savedCards", savedCards);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment – Lumara Resort</title>
    <link rel="stylesheet" , href="<%= request.getContextPath() %>/css/style_v2.css" />
</head>

<body>

<jsp:include page="navbar.jsp" />

<header class="booking-hero">
    <h1>Payment</h1>
    <p>Review your booking and complete payment</p>
</header>

<div class="booking-container">

    <!-- BOOKING SUMMARY -->
    <div class="booking-summary">
        <h2>Booking Summary</h2>
        <p><strong>Name:</strong> <%= request.getAttribute("name") %></p>
        <p><strong>Room Type:</strong> <%= request.getAttribute("roomType") %></p>
        <p><strong>Check-in:</strong> <%= request.getAttribute("checkIn") %></p>
        <p><strong>Check-out:</strong> <%= request.getAttribute("checkOut") %></p>
        <p><strong>Total Nights:</strong> <%= request.getAttribute("nights") %></p>
        <p><strong>Total Amount:</strong>
            RM <%= request.getAttribute("totalAmount") %></p>
    </div>

    <!-- PAYMENT FORM -->
    <form method="POST"
          action="<%= request.getContextPath() %>/payment"
          class="payment-form">

        <!-- Hidden booking ID -->
        <input type="hidden" name="bookingId"
               value="<%= request.getAttribute("bookingId") %>" />

        <h3 class="payment-title">Payment Method</h3>

        <!-- SAVED CARDS -->
        <div class="saved-card-box">
            <label for="savedCardSelect" class="saved-card-label">
                Saved Payment Method
            </label>

            <select id="savedCardSelect" class="saved-card-select">

                <%
                    java.util.List cards =
                        (java.util.List) request.getAttribute("savedCards");

                    if (cards != null && !cards.isEmpty()) {
                        for (Object obj : cards) {
                            java.util.Map card =
                                (java.util.Map) obj;
                %>
                    <option value="<%= card.get("id") %>">
                        <%= card.get("brand") %>
                        •••• <%= card.get("last4") %>
                        (<%= card.get("expiry") %>)
                    </option>
                <%
                        }
                    }
                %>

                <option value="new">+ Add new card</option>
            </select>
        </div>

        <div class="divider">OR</div>

        <!-- NEW CARD -->
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
                    <input type="text"
                           name="cardNumber"
                           placeholder="1234 5678 9012 3456">
                </label>

                <label>
                    Cardholder Name
                    <input type="text"
                           name="cardholderName"
                           placeholder="John Doe">
                </label>

                <div class="card-row">
                    <label>
                        Expiry Date
                        <input type="text"
                               name="expiryDate"
                               placeholder="MM/YY">
                    </label>

                    <label>
                        CVV
                        <input type="text"
                               name="cvv"
                               placeholder="123">
                    </label>
                </div>
            </div>
        </div>

        <!-- ACTION BUTTONS -->
        <div class="payment-actions">
            <button type="submit"
                    name="action"
                    value="cancel"
                    class="btn btn-cancel">
                ✕ Cancel
            </button>

            <button type="submit"
                    name="action"
                    value="confirm"
                    class="btn btn-confirm">
                ✓ Confirm
            </button>
        </div>

    </form>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>
