package com.lumara.servlet;

import com.lumara.util.CardValidator;
import com.lumara.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String bookingIdStr = request.getParameter("bookingId");

        if (bookingIdStr == null || action == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdStr);

        // 1. Handle Manual User Cancellation
        if ("cancel".equals(action)) {
            // Pass "manual" to indicate the user clicked the cancel button
            cancelBooking(bookingId, response, "manual");
            return;
        }

        if ("confirm".equals(action)) {

            // ---- CHECK IF USER USED NEW CARD ----
            String cardNumber = request.getParameter("cardNumber");
            String expiryDate = request.getParameter("expiryDate");
            String cvv = request.getParameter("cvv");

            // If user entered data in the New Card fields
            if (cardNumber != null && !cardNumber.trim().isEmpty()) {

                // ✅ CENTRALIZED VALIDATION
                String validationError =
                        CardValidator.validate(cardNumber, expiryDate, cvv);

                if (validationError != null) {
                    /* 2. LOGIC CHANGE: 
                       Instead of sending them back to the payment page to try again,
                       we strictly cancel the booking immediately.
                       We pass "validation_fail" as the reason.
                    */
                    cancelBooking(bookingId, response, "validation_fail");
                    return;
                }
            }

            confirmPayment(response);
            return;
        }

        response.sendRedirect("index.jsp");
    }


    /* =========================
       CANCEL BOOKING (Modified)
       ========================= */
    // Added 'String reason' to decide where to redirect after deleting
    private void cancelBooking(int bookingId, HttpServletResponse response, String reason)
            throws IOException {

        try (Connection conn = DBConnection.getConnection()) {

            // The DB logic remains exactly the same
            String sql = "DELETE FROM bookings WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, bookingId);
                pstmt.executeUpdate();
            }

            // Redirect based on the reason for cancellation
            if ("validation_fail".equals(reason)) {
                // Redirects with the specific error message you requested
                response.sendRedirect("booking.jsp?error=invalid_card_cancelled");
            } else {
                // Default behavior for manual cancellation
                response.sendRedirect("booking.jsp?cancelled=true");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking.jsp?error=cancel_failed");
        }
    }


    /* =========================
       CONFIRM PAYMENT
       ========================= */
    private void confirmPayment(HttpServletResponse response)
            throws IOException {

        // Phase 1: simulated payment success
        response.sendRedirect("payment_success.jsp");
    }
}